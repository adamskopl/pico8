# Code style

1. Name enums and constants in `THIS_IS_CONSTANT` style.
2. Organize code into focused modules that are easy to update or remove without making a mess. “Module” is a project convention; it does not require a language-level module system.
3. Put a constant or variable on a module's global object when it is specific to that module and is public, meaning other modules are expected to use it. For example, coin types belong on `COINS` when other modules need them.
4. Keep values used only inside a module private. In this project, private values may be globals, but give them a module-specific prefix to avoid collisions. The prefix can be the full module name (for example, `coins_`) or a clear abbreviation used consistently by that module (for example, `go_` for `GAME_OVER`).
5. After any code change, summarize the code changes clearly in a point-by-point list.
6. Live entity collections are an exception: keep them as globally accessible plural names (for example, `coins` or `enemies`) because multiple systems may need to access them. Keep entity behavior and definitions on their module object.
7. Functions used only within a module are private. Define them outside the module object and prefix their names with the module name in lowercase (for example, `coins_update_blinking`).
8. Place a private helper immediately above the module function that uses it, without a blank line when they form one unit. If several module functions use it, place it near the group they support, usually before the first consumer. Avoid a separate helpers section unless it improves navigation.
