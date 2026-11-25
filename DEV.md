Notes from development
======================

VarClient and VarPlayer values
------------------------------

- `FISHCOMP_PERM_*` is stuff like best results but they're encoded weirdly, needs investigation
- `FISHCOMP_CLIENT_*` is client button selections. All of them are resent, in order, when a new option is selected.
- `FISHCOMP_RESULT_*` is the columns in last catch. All of them are resent on a catch. `FISHCOMP_RESULT_RATING` is sent last.

Because of this, client and result can be out of sync.

Rough algorithm
---------------

1. Have a map of fish to possible (hook, distance, bait) pairs
2. Determine the next fish to try and a tackle combination to suggest for it
3. When a fish is caught, remove any combinations that don't get the observed percentages. Remove combos from other fish at the same habitat that have a higher score
4. Go to 2