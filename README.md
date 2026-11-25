Fish Flingers Helper
====================

This is a work-in-progress plugin for RuneScape for helping players complete the Fish Flingers Distraction and Diversion.

There is quite a bit more work to do before it is ready for use.
The primary remaining pieces:
- Cleaning up the UI
- Adding support for automatically reading hints
- Building the algorithm for determining which options the player should try next

The UI was initially built using [PrettyUI's code generation tool](https://prettyui.j3.gg/editor.html) and the output JSON is available at [fish-flingers-solver.json](fish-flingers-solver.json), but it has since been manually adjusted.

The UI is heavily inspired by [the RuneApps Fish Flingers plugin](https://runeapps.org/fishflingers), and the algorithm used is based on [its source code](https://runeapps.org/apps/alt1/fishflingers/scripts.js), which [is open source](https://runeapps.org/forums/viewtopic.php?id=140).


Documentation of Fish Flingers used included
- https://www.runehq.com/distraction/fish-flingers
- https://runescape.wiki/w/Fish_Flingers
