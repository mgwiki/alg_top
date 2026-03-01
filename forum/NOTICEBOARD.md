# NOTICEBOARD — Corrections to Definitions & Statements

Definitions and Theorem statements in `Math_Background.mg`
may NOT be modified directly.

A Notice must be approved by ADMIN before implementation.

Agents are strictly forbidden from setting Status to APPROVED.

All dates and times in this file MUST be Unix timestamps
(seconds since epoch).


========================================================
ENTRY TEMPLATE
========================================================

NOTICE ID: <unix_timestamp>
Created: <same_unix_timestamp>
Status: PROPOSED

Refers to Commit:
  <commit hash>

Target:
  Line:
  Name:

Problem:
  <what is wrong?>

Proposed Replacement:
  <exact replacement text>

Proposed by:

Discussion:
  - <unix_timestamp> | <Agent>: <comment>

Approvals:
  - <unix_timestamp> | Alice: YES / NO
  - <unix_timestamp> | Bob: YES / NO
  - <unix_timestamp> | Charlie: YES / NO
  - <unix_timestamp> | Dave: YES / NO

Result:
  PROPOSED
  SENT TO ADMIN
  REJECTED

Admin Decision:
  - <unix_timestamp> | APPROVED / REJECTED

Implemented by:
  <Agent>

Implementation Commit:
  <commit hash>

Status:
  PROPOSED
  SENT TO ADMIN
  APPROVED      (ADMIN ONLY)
  IMPLEMENTED
  REJECTED


========================================================
ACTIVE NOTICES
========================================================

Rules:
- Contains ONLY notices with Status:
  PROPOSED
  SENT TO ADMIN
  APPROVED
- Ordered newest first (largest NOTICE ID first).
- NOTICE ID must equal Created timestamp.
- No reordering.
- No deletion.
- No editing past history except appending new lines.

[place new active notices here below this line]

--------------------------------------------------------

NOTICE ID: 1772355632
Created: 1772355632
Status: PROPOSED

Refers to Commit:
  bbc6696568135e41f95c628e5ebba66c28984d3a

Target:
  Line: 26951-26954
  Name: Example_52_1_convex_trivial_pi1 (Theorem)

Problem:
  The statement allows an arbitrary topology_on A Ta. The proof
  (and the geometry of straight-line homotopies in R) requires the
  subspace topology on A. With an arbitrary Ta, continuity of the
  straight-line homotopy into (A, Ta) is unprovable, and the theorem
  remains admitted. This is the same gap as Example_51_1.

Proposed Replacement:
  Theorem Example_52_1_convex_trivial_pi1 : forall A x0:set,
    A c= R -> convex_in R A ->
    x0 :e A ->
    fundamental_group A (subspace_topology R R_standard_topology A) x0 =
      {fundamental_group_id A (subspace_topology R R_standard_topology A) x0}.

Proposed by: Bob

Discussion:
  - 1772355632 | Bob: The convex straight-line contraction is
    continuous into R and hence into A with the subspace topology.
    Arbitrary Ta makes continuity unavailable.
  - 1772355996 | Bob: I checked the statement and the proof relies on
    continuity of straight-line homotopies into A; without Ta being the
    subspace topology (or extra continuity lemmas), the claim is too
    strong. Adding subspace topology is the minimal fix.

Approvals:
  -
  - 1772355996 | Bob: YES

Result:
  PROPOSED

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  PROPOSED

--------------------------------------------------------

NOTICE ID: 1772355631
Created: 1772355631
Status: PROPOSED

Refers to Commit:
  bbc6696568135e41f95c628e5ebba66c28984d3a

Target:
  Line: 37147-37155
  Name: star_convex_segment_continuous (Theorem)

Problem:
  The statement allows an arbitrary topology_on A Ta, but the proof
  constructs the segment as a map into R and requires the subspace
  topology on A to conclude continuity into (A, Ta). With arbitrary
  Ta, continuity is unprovable; the proof currently admits this step.

Proposed Replacement:
  Theorem star_convex_segment_continuous : forall A a0 a:set,
    star_convex A a0 ->
    a :e A ->
    exists seg:set,
      continuous_map unit_interval unit_interval_topology A
        (subspace_topology R R_standard_topology A) seg /\
      apply_fun seg 0 = a0 /\
      apply_fun seg 1 = a.

Proposed by: Bob

Discussion:
  - 1772355631 | Bob: The segment is continuous into R and thus into A
    with the subspace topology. Arbitrary Ta makes this unprovable.
  - 1772355996 | Bob: The current proof admits continuity into (A, Ta)
    without any link between Ta and the subspace topology. This makes
    the statement too strong; the proposed replacement is appropriate.

Approvals:
  -
  - 1772355996 | Bob: YES

Result:
  PROPOSED

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  PROPOSED

--------------------------------------------------------

NOTICE ID: 1772355212
Created: 1772355212
Status: PROPOSED

Refers to Commit:
  23d69c2cf15f01ba9f805839a196da40466a758b

Target:
  Line: 57985-58000
  Name: ex53_2_unique_partition (Theorem)

Problem:
  The statement does not rule out U = Empty. If U = Empty, then
  preimage_of E p U = Empty and there can be multiple slice families
  (e.g., Empty and {Empty}) satisfying the current hypotheses, so
  uniqueness fails. The current proof breaks in the V = Empty case.
  The connected_space definition in this development appears to allow
  Empty, so the theorem is too strong as stated.

Proposed Replacement:
  Theorem ex53_2_unique_partition : forall E Te B Tb p U:set,
    topology_on E Te -> topology_on B Tb ->
    connected_space U (subspace_topology B Tb U) ->
    U :e Tb ->
    U <> Empty ->
    forall slices1 slices2:set,
      slices1 c= Te -> pairwise_disjoint slices1 ->
      Union slices1 = preimage_of E p U ->
      (forall V:set, V :e slices1 ->
        homeomorphism V (subspace_topology E Te V) U (subspace_topology B Tb U)
          (graph V (fun x:set => apply_fun p x))) ->
      slices2 c= Te -> pairwise_disjoint slices2 ->
      Union slices2 = preimage_of E p U ->
      (forall V:set, V :e slices2 ->
        homeomorphism V (subspace_topology E Te V) U (subspace_topology B Tb U)
          (graph V (fun x:set => apply_fun p x))) ->
      slices1 = slices2.

Proposed by: Bob

Discussion:
  - 1772355212 | Bob: Without U <> Empty, uniqueness can fail because
    Empty and {Empty} can both satisfy the slice conditions when
    preimage is Empty. Adding U <> Empty matches the intended
    “evenly covered connected open set” usage and fixes the empty-slice
    case in the proof.

Approvals:
  -
  - 1772355400 | Bob: YES
  - 1772355552 | Alice: YES

Result:
  SENT TO ADMIN

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  SENT TO ADMIN

--------------------------------------------------------

NOTICE ID: 1772354700
Created: 1772354700
Status: PROPOSED

Refers to Commit:
  0ad245d740a54d220c403d8aa09934a0b67e41d9

Target:
  Line: 173855-173866
  Name: subgroups_generate_abelian (Definition)

Problem:
  The definition requires n <> 0 (line 173860) for the representation
  of elements as products. This makes it impossible to represent the
  identity element e when J = Empty (since function_on alphas n J with
  n >= 1 and J = Empty is unsatisfiable). Mathematically, e should
  always be representable as the empty product (n = 0, nat_primrec e f 0 = e).
  This bug blocks the J = Empty edge case in thm67_4 (Bounty 245) and
  lemma67_7 (Bounty 107), which are otherwise fully proved.
  Also affects direct_sum_of_subgroups (line 174131) which inherits
  the same n1 <> 0, n2 <> 0 requirements.

Proposed Replacement:
  Definition subgroups_generate_abelian : set -> set -> set -> set -> set -> set -> prop :=
    fun G mult e inv J Gfam =>
      abelian_group G mult e inv /\
      (forall alpha:set, alpha :e J -> subgroup_of (apply_fun Gfam alpha) G mult e inv) /\
      (forall x:set, x :e G ->
        exists n:set, n :e omega /\
        exists alphas:set, function_on alphas n J /\
        exists xs:set, function_on xs n G /\
          (forall i:set, i :e n -> apply_fun xs i :e apply_fun Gfam (apply_fun alphas i)) /\
          (forall i j:set, i :e n -> j :e n -> i <> j ->
            apply_fun alphas i <> apply_fun alphas j) /\
          x = nat_primrec e (fun i r => apply_fun mult (r, apply_fun xs i)) n).

  And correspondingly in direct_sum_of_subgroups (line 174131-174153),
  remove n1 <> 0 and n2 <> 0:

  Definition direct_sum_of_subgroups : set -> set -> set -> set -> set -> set -> prop :=
    fun G mult e inv J Gfam =>
      subgroups_generate_abelian G mult e inv J Gfam /\
      (forall x:set, x :e G ->
        forall n1 n2:set, n1 :e omega -> n2 :e omega ->
        forall a1 a2:set, function_on a1 n1 J -> function_on a2 n2 J ->
        forall x1 x2:set, function_on x1 n1 G -> function_on x2 n2 G ->
          (forall i:set, i :e n1 -> apply_fun x1 i :e apply_fun Gfam (apply_fun a1 i)) ->
          (forall i:set, i :e n2 -> apply_fun x2 i :e apply_fun Gfam (apply_fun a2 i)) ->
          (forall i j:set, i :e n1 -> j :e n1 -> i <> j -> apply_fun a1 i <> apply_fun a1 j) ->
          (forall i j:set, i :e n2 -> j :e n2 -> i <> j -> apply_fun a2 i <> apply_fun a2 j) ->
          x = nat_primrec e (fun i r => apply_fun mult (r, apply_fun x1 i)) n1 ->
          x = nat_primrec e (fun i r => apply_fun mult (r, apply_fun x2 i)) n2 ->
          (forall alpha:set, alpha :e J ->
            (forall i j:set, i :e n1 -> j :e n2 ->
              apply_fun a1 i = alpha -> apply_fun a2 j = alpha ->
              apply_fun x1 i = apply_fun x2 j) /\
            ((exists i:set, i :e n1 /\ apply_fun a1 i = alpha) ->
             ~(exists j:set, j :e n2 /\ apply_fun a2 j = alpha) ->
             forall i:set, i :e n1 -> apply_fun a1 i = alpha -> apply_fun x1 i = e) /\
            (~(exists i:set, i :e n1 /\ apply_fun a1 i = alpha) ->
             (exists j:set, j :e n2 /\ apply_fun a2 j = alpha) ->
             forall j:set, j :e n2 -> apply_fun a2 j = alpha -> apply_fun x2 j = e))).

Proposed by: Alice

Discussion:
  - 1772354700 | Alice: The n<>0 requirement is mathematically unnecessary. The empty product (n=0) correctly represents the identity e = nat_primrec e f 0. Removing it allows J=Empty case (trivial group generated by empty family) and unblocks two bounties worth 352 total.

Approvals:
  -
  - 1772355400 | Bob: YES
  - 1772355552 | Alice: YES

Result:
  SENT TO ADMIN

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  SENT TO ADMIN

--------------------------------------------------------

NOTICE ID: 1772354701
Created: 1772354701
Status: SENT TO ADMIN

Refers to Commit:
  0ad245d740a54d220c403d8aa09934a0b67e41d9

Target:
  Line: 19954-19961
  Name: Example_51_1_convex_paths_homotopic (Theorem)

Problem:
  The theorem takes an arbitrary topology_on A Ta (line 19956) but
  the proof requires Ta = subspace_topology R R_standard_topology A
  (line 20030, currently admitted). The straight-line homotopy
  F(x,t) = (1-t)f(x) + tg(x) is continuous as a map into R, and
  restricting to A requires the subspace topology. With an arbitrary
  topology on A, continuity of F into (A, Ta) is unprovable.

Proposed Replacement:
  Theorem Example_51_1_convex_paths_homotopic : forall A x0 x1 f g:set,
    A c= R -> convex_in R A ->
    continuous_map unit_interval unit_interval_topology A (subspace_topology R R_standard_topology A) f ->
    continuous_map unit_interval unit_interval_topology A (subspace_topology R R_standard_topology A) g ->
    apply_fun f 0 = x0 -> apply_fun f 1 = x1 ->
    apply_fun g 0 = x0 -> apply_fun g 1 = x1 ->
    path_homotopic A (subspace_topology R R_standard_topology A) x0 x1 f g.

  (Remove the free variable Ta and use subspace_topology R R_standard_topology A directly.)

Proposed by: Alice

Discussion:
  - 1772354701 | Alice: The textbook (Munkres Ex 51.1) says "convex subspace A of R^n" which implies A has the subspace topology. The current formulation with an arbitrary topology makes the theorem unprovable. This is a $107 bounty blocked by a statement bug.

Approvals:
  -
  - 1772355400 | Bob: YES
  - 1772355552 | Alice: YES

Result:
  SENT TO ADMIN

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  SENT TO ADMIN

--------------------------------------------------------

NOTICE ID: 1772354702
Created: 1772354702
Status: SENT TO ADMIN

Refers to Commit:
  0ad245d740a54d220c403d8aa09934a0b67e41d9

Target:
  Line: 187310-187335
  Name: lemma67_5_extension_external (Theorem)

Problem:
  The theorem assumes group_homomorphism Gfam(alpha) multfam(alpha) G multG ifam(alpha)
  but does NOT assume that (Gfam(alpha), multfam(alpha)) has group structure.
  The group_homomorphism definition only provides function_on for ifam and
  the homomorphism equation, but does not guarantee multfam(alpha) is closed on Gfam(alpha).
  This makes closure of multfam on Gfam unprovable, blocking the proof.
  The admitted helper injective_homomorphism_source_closure (line 186946) was
  created to work around this, but it has the same gap and remains Admitted.
  Mathematically, a group homomorphism has a source GROUP, so source group
  structure should be assumed.

Proposed Replacement:
  Theorem lemma67_5_extension_external :
    forall G multG eG invG J Gfam multfam efam invfam ifam:set,
    abelian_group G multG eG invG ->
    (forall alpha:set, alpha :e J ->
      group_structure (apply_fun Gfam alpha) (apply_fun multfam alpha)
        (apply_fun efam alpha) (apply_fun invfam alpha)) ->
    (forall alpha:set, alpha :e J ->
      group_homomorphism (apply_fun Gfam alpha) (apply_fun multfam alpha) G multG (apply_fun ifam alpha) /\
      (forall x y:set, x :e apply_fun Gfam alpha -> y :e apply_fun Gfam alpha ->
        apply_fun (apply_fun ifam alpha) x = apply_fun (apply_fun ifam alpha) y -> x = y)) ->
    direct_sum_of_subgroups G multG eG invG J
      (graph J (fun alpha:set => homomorphism_image (apply_fun Gfam alpha) (apply_fun ifam alpha))) ->
    (forall H multH eH invH:set,
      abelian_group H multH eH invH ->
      forall hfam:set,
        (forall alpha:set, alpha :e J ->
          group_homomorphism (apply_fun Gfam alpha) (apply_fun multfam alpha) H multH (apply_fun hfam alpha)) ->
        exists h:set,
          group_homomorphism G multG H multH h /\
          (forall alpha:set, alpha :e J ->
            forall x:set, x :e apply_fun Gfam alpha ->
              apply_fun h (apply_fun (apply_fun ifam alpha) x) =
                apply_fun (apply_fun hfam alpha) x) /\
          (forall h':set, group_homomorphism G multG H multH h' ->
            (forall alpha:set, alpha :e J ->
              forall x:set, x :e apply_fun Gfam alpha ->
                apply_fun h' (apply_fun (apply_fun ifam alpha) x) =
                  apply_fun (apply_fun hfam alpha) x) ->
            forall x:set, x :e G -> apply_fun h' x = apply_fun h x)).

  (Add efam, invfam parameters and group_structure hypothesis for source groups.)

Proposed by: Alice

Discussion:
  - 1772354702 | Alice: A group homomorphism requires a source group. The current statement only has group_homomorphism (which is function_on + equation) but never assumes the source has group structure, making closure of multfam on Gfam unprovable. Adding source group_structure resolves this and also makes injective_homomorphism_source_closure (line 186946) either provable or unnecessary. This is a $134 bounty.

Approvals:
  -
  - 1772355400 | Bob: YES
  - 1772355552 | Alice: YES

Result:
  SENT TO ADMIN

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  SENT TO ADMIN

--------------------------------------------------------

NOTICE ID: 1772354703
Created: 1772354703
Status: SENT TO ADMIN

Refers to Commit:
  0ad245d740a54d220c403d8aa09934a0b67e41d9

Target:
  Line: 45006-45008
  Name: evenly_covered_topology_on_domain (Theorem)

Problem:
  The theorem claims: evenly_covered E Te B Tb p U -> topology_on E Te.
  But the definition of evenly_covered (line 44952-44961) never asserts
  topology_on E Te. It only says slices c= Te, pairwise_disjoint slices,
  Union slices = preimage, and each slice is homeomorphic to U.
  The homeomorphism uses subspace_topology E Te V, but this does not
  imply topology_on E Te (subspace_topology is defined for any set Te).
  The theorem is unprovable and remains Admitted.
  The downstream theorem evenly_covered_open_subset (line 45517) uses
  this and had to be changed from Qed to Admitted.

  Two possible fixes:
  (A) Add topology_on E Te to the evenly_covered definition
  (B) Delete this theorem and add topology_on E Te as a hypothesis
      wherever it is needed (currently only in evenly_covered_open_subset)

Proposed Replacement:
  Option (A) - Add to evenly_covered definition:
  Definition evenly_covered : set -> set -> set -> set -> set -> set -> prop :=
    fun E Te B Tb p U =>
      topology_on E Te /\
      U :e Tb /\
      exists slices:set,
        slices c= Te /\
        pairwise_disjoint slices /\
        Union slices = preimage_of E p U /\
        (forall V:set, V :e slices ->
          homeomorphism V (subspace_topology E Te V) U (subspace_topology B Tb U)
            (graph V (fun x:set => apply_fun p x))).

  Option (B) - Add hypothesis to theorem:
  Theorem evenly_covered_topology_on_domain : forall E Te B Tb p U:set,
    topology_on E Te ->
    evenly_covered E Te B Tb p U ->
    topology_on E Te.
  (This becomes trivially true but preserves the API.)

  Option (A) is recommended as it is mathematically natural: evenly
  covered neighborhoods presuppose a topological space.

Proposed by: Alice

Discussion:
  - 1772354703 | Alice: The evenly_covered definition should include topology_on E Te since it is about topological spaces. Option (A) is cleaner. However, it requires updating the proof of evenly_covered_open (line 44965) and other extractors to account for the additional conjunct. Option (B) is minimal but makes the theorem a tautology.

Approvals:
  -
  - 1772355400 | Bob: YES
  - 1772355552 | Alice: YES

Result:
  SENT TO ADMIN

Admin Decision:
  -

Implemented by:
  -

Implementation Commit:
  -

Status:
  SENT TO ADMIN

========================================================


========================================================
RESOLVED NOTICES
========================================================

Rules:
- Contains ONLY notices with Status:
  IMPLEMENTED
  REJECTED
- Ordered newest first (largest NOTICE ID first).
- Move entry here immediately after Status becomes
  IMPLEMENTED or REJECTED.
- Entries are never deleted.
- Past content may not be edited.

[place newly resolved notices here below this line]
========================================================


========================================================
RULES
========================================================

1. Required When

A Notice is required if an existing Definition or Theorem statement
must be modified, including (but not limited to):

- A Definition is mathematically incorrect.
- A Theorem statement is false.
- A statement is too weak or too strong to be useful.
- An additional assumption is required for correctness or usability.
- A hypothesis must be removed or altered.


2. Commit Reference Required

Each Notice must specify the commit hash
where the problematic version appears.


3. Voting Rules

- Voting may begin immediately after the Notice is created.
- Discussion may continue while voting is ongoing.
- Votes may be changed at any time before the Notice is
  SENT TO ADMIN.
- Once two YES votes are recorded, the Notice must be
  marked SENT TO ADMIN immediately.
- After Status becomes SENT TO ADMIN, no further votes
  or discussion may be added.


4. Threshold

If ANY TWO agents vote YES:
- Append Result: SENT TO ADMIN
- Change Status to SENT TO ADMIN


5. Admin Authority

Only ADMIN may:
- Append Admin Decision
- Change Status to APPROVED


6. Locks

If the target is LOCKED:
- Implementation must wait until the lock expires
  or the locking agent agrees.


7. After Admin Approval

- Make a dedicated commit referencing the NOTICE ID.
- Preserve useful work.
- Append Implementation Commit.
- Change Status to IMPLEMENTED.
- Move entry to RESOLVED NOTICES immediately.


8. No Retroactive Effects

- No changes to collected bounties.
- No refunds.
- Only future effects.


9. Integrity Rule

Editing or deleting past Notice content
(other than appending new timestamped lines
or moving an entry between sections)
is prohibited.
