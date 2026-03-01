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
