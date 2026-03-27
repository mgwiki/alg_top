#!/usr/bin/env perl
use strict;
use warnings;

# Usage:
#   perl deps_recadmit_ordered_fast.pl snippet.v
#   perl deps_recadmit_ordered_fast.pl snippet.v 8292

my $file   = shift @ARGV or die "Usage: $0 <snippet-file> [cutoff_line]\n";
my $cutoff = shift(@ARGV) // 8292;

open my $fh, "<", $file or die "Cannot open $file: $!\n";
local $/ = undef;
my $txt = <$fh>;
close $fh;

# Keep only lines after the cutoff
my @all_lines = split /\R/, $txt;
my @tail = ();
if ($cutoff < @all_lines) {
    @tail = @all_lines[$cutoff .. $#all_lines];
}
my $region = join("\n", @tail);

# Strip Coq comments
$region =~ s/\(\*.*?\*\)//gs;

# ----------------------------
# Pass 1: collect known names
# ----------------------------
my %kind;  # name -> 'T', 'D', or later 'A'
while ($region =~ /^\s*(Lemma|Theorem|Definition)\s+([A-Za-z_][A-Za-z0-9_]*)\b/mg) {
    my ($kw, $name) = ($1, $2);
    my $k = substr($kw, 0, 1);
    $k = 'T' if $k eq 'L';
    $kind{$name} = $k;
}

# -----------------------------------------
# Pass 2: parse theorem blocks + explicit deps
# -----------------------------------------
my %block;
my %lines;
my %admit;
my %deps;         # all known deps (for output)
my %thm_deps;     # theorem/admitted deps only (for recadmit)
my @order;

while ($region =~ /(^\s*(Lemma|Theorem)\s+([A-Za-z_][A-Za-z0-9_]*)\b.*?^\s*(Qed|Admitted)\.)/msg) {
    my $b    = $1;
    my $thm  = $3;
    my $end  = $4;

    if (!exists $block{$thm}) {
        push @order, $thm;
    }

    $block{$thm} = $b;
    $lines{$thm} = scalar(split /\R/, $b);

    my $is_admit = ($b =~ /^\s*admit\.\s*$/m);
    $admit{$thm} = $is_admit ? 1 : 0;
    $kind{$thm}  = 'A' if $is_admit;

    my %seen_all;
    my %seen_thm;

    # Fast path: scan identifier-like tokens, then hash lookup
    while ($b =~ /\b([A-Za-z_][A-Za-z0-9_]*)\b/g) {
        my $n = $1;
        next if $n eq $thm;
        next unless exists $kind{$n};

        $seen_all{$n} = 1;
        $seen_thm{$n} = 1 if $kind{$n} ne 'D';
    }

    $deps{$thm}     = [ sort keys %seen_all ];
    $thm_deps{$thm} = [ keys %seen_thm ];
}

# ---------------------------------------------------
# Pass 3: compute recursive-admit (transitive)
# ---------------------------------------------------
my %recmemo;
my %inprog;

sub recadmit {
    my ($thm) = @_;

    return 0 if !exists($kind{$thm}) || $kind{$thm} eq 'D';
    return 1 if $admit{$thm};

    return $recmemo{$thm} if exists $recmemo{$thm};
    return 0 if $inprog{$thm};   # break cycles conservatively

    $inprog{$thm} = 1;

    for my $d (@{ $thm_deps{$thm} // [] }) {
        if (recadmit($d)) {
            $inprog{$thm} = 0;
            return $recmemo{$thm} = 1;
        }
    }

    $inprog{$thm} = 0;
    return $recmemo{$thm} = 0;
}

# -----------------------------------------
# Output in file order
# -----------------------------------------
for my $thm (@order) {
    my $ad = $admit{$thm} ? "YES" : "NO";
    my $ra = recadmit($thm) ? "YES" : "NO";

    my @annot = map { "$_:" . ($kind{$_} // "?") } @{ $deps{$thm} // [] };

    my $depcount = scalar(@annot);
    my $deplist  = join(",", @annot);

    print "$thm: lines:$lines{$thm}, admit:$ad, recadmit:$ra, deps($depcount):[$deplist].\n";
}
