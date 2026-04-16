# Neovim Wrapper Migration Notes

This document records the work done while moving the Neovim setup into the wrapper-based `lz.n` configuration under `modules/features/wrappedPrograms/neovim`.

It focuses on three things:

- what was migrated
- what broke during the process
- how each issue was resolved

The goal was to keep the config usable while steadily removing stale paths, mismatched plugin IDs, and runtime assumptions from the old setup.

## Starting Point

The original Neovim setup had a mix of legacy Home Manager-style config and the newer wrapper-based config.

The migration work centered on the wrapper tree under:

- [modules/features/wrappedPrograms/neovim/neovim.nix](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/neovim.nix)
- [modules/features/wrappedPrograms/neovim/lua/init.lua](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/lua/init.lua)
- [modules/features/wrappedPrograms/neovim/lua/opts.lua](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/lua/opts.lua)
- [modules/features/wrappedPrograms/neovim/lua/plugins/](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/lua/plugins)

The old config had many plugin-specific files that relied on direct `require(...)` calls and theme assumptions that no longer matched the wrapper package layout.

## What Was Migrated

The plugin tree was rewritten into `lz.n`-style plugin specs.

The general pattern used was:

- `return { "plugin-id", after = function() ... end }`
- `init = function()` when a plugin only needed globals or pre-load configuration
- `lazy = false` only where the plugin had to load immediately

This migration affected many files in `lua/plugins`, including LSP, dashboard, trouble, completion helpers, editor helpers, and theme-related plugins.

The wrapper package list in [neovim.nix](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/neovim.nix) was also kept in sync with the Lua plugin specs so the packpath layout matched the plugin IDs used by `lz.n`.

## Theme Decision

The custom gruvbox-like theme was preserved.

The active colorscheme lives in:

- [modules/features/wrappedPrograms/neovim/colors/gxvjbox.lua](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/colors/gxvjbox.lua)

The authoritative colorscheme entry point remains:

- [modules/features/wrappedPrograms/neovim/lua/opts.lua](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/lua/opts.lua)

The important decision here was to avoid letting theme plugins override the local gruvbox-like palette.

That meant removing forced colorscheme switches from theme plugin specs and leaving the custom theme as the final word.

## Early Validation

Before chasing runtime errors, the config was checked in a headless Neovim session.

That helped distinguish:

- syntax errors in Lua files
- missing plugins on packpath
- module load failures inside `after` hooks

This matters because `lz.n` can fail for different reasons at different phases.

## Runtime Error Pattern

The most common failure mode was:

- `Vim:E919: Directory not found in 'packpath'`

That usually meant the plugin ID in the Lua spec did not match the actual Nix package name.

Another common failure mode was:

- `module 'X' not found`

That usually meant the plugin was present, but the Lua module path was wrong or the dependency was optional and missing.

## Plugin ID Mismatch Fixes

Several plugins loaded through `lz.n` had the wrong ID string.

The fix was to make the plugin spec name match the Nix package name exactly.

Examples of this kind of fix included:

- `vimtex` package naming alignment
- `dashboard-nvim` package naming alignment
- `molten-nvim` package naming alignment

The lesson was simple:

- GitHub repository names are not always the same as the packpath directory name used by the wrapper

## Dashboard Migration

The dashboard spec was one of the larger conversions.

It originally carried a lot of Telescope-based launcher logic.

That created several problems:

- direct Telescope dependencies remained in a Snacks-oriented stack
- help and picker features were still wired through Telescope internals
- the dashboard code became a runtime liability when Telescope was not installed

The cleanup strategy was:

- replace Telescope file launchers with Snacks pickers
- replace recent-file actions with Snacks recent pickers
- replace explorer-like actions with Snacks explorer
- keep the custom dashboard layout and key bindings

The result was a dashboard that kept the original workflow but no longer depended on Telescope.

## Trouble Integration Update

The Trouble plugin also had Telescope-specific integration.

That was removed and replaced with Snacks integration so the plugin could still cooperate with file picking without requiring Telescope.

The important part was to keep the Trouble workflow while deleting the old picker backend.

## Snacks Migration

Snacks became the common replacement for the Telescope-like functions in the wrapper.

Useful picker calls included:

- `Snacks.picker.files()`
- `Snacks.picker.recent()`
- `Snacks.picker.grep()`
- `Snacks.picker.help()`
- `Snacks.explorer()`

The Snacks setup lives in:

- [modules/features/wrappedPrograms/neovim/lua/plugins/snacks.lua](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/lua/plugins/snacks.lua)

One key decision was to enable the picker and explorer features in Snacks so the replacement calls were actually available.

## KMonad Issue

The KMonad plugin failed because the config treated it like a Lua module.

The installed package was just a syntax plugin.

It did not expose a `setup()` module the config could require.

The fix was to remove the `after` hook entirely and keep the plugin as a plain package reference.

That eliminated the `module 'kmonad/kmonad-vim' not found` error.

## Kanso Issue

The Kanso theme plugin produced a packpath failure because `lz.n` tried to load a package directory that did not exist.

The config already had a stable local theme, so Kanso was not needed.

The fix was to remove the stale plugin spec entirely.

That stopped `lz.n` from trying to load `pack/*/opt/kanso.nvim`.

## Catppuccin Issue

Catppuccin caused the same kind of failure.

It was still present as a plugin spec, but it was no longer part of the intended theme stack.

The local gruvbox-like colorscheme was already authoritative.

The fix was to delete the stale Catppuccin plugin spec.

That removed the `pack/*/opt/catppuccin.nvim` error.

## Molten Issue

Molten also triggered a packpath failure.

At first it looked like a missing dependency, but the real issue was the lz.n ID.

The spec used a name that did not match the installed package layout.

After correcting the ID, the runtime issue was gone for a while.

Later it became clear that the plugin was still a stale dependency in the current wrapper stack.

Since there was no active replacement workflow using it, the spec was removed entirely.

That eliminated the `pack/*/opt/molten.nvim` failure.

## Image.nvim Relationship

The Molten config had an optional relationship with image rendering.

The wrapper already included:

- [modules/features/wrappedPrograms/neovim/lua/plugins/image-nvim.lua](/home/abosafiya/dev/irix/modules/features/wrappedPrograms/neovim/lua/plugins/image-nvim.lua)

Molten checked for `image.nvim` and switched providers when it was available.

That was not enough to justify keeping Molten if the plugin itself was otherwise stale.

## Treesitter Issue

Treesitter failed because the config required `nvim-treesitter.configs` unconditionally.

The failure presented as a module load error in the plugin `after` hook.

The fix was to guard the require with `pcall` and only call `setup()` if the module was available.

That turned a hard startup failure into a safe no-op when the module was missing.

## Schemastore Issue

The JSON LSP setup required `schemastore` unconditionally.

This caused the `nvim-lspconfig` `after` hook to fail when the optional dependency was not installed.

The fix was to make the dependency optional:

- try `require("schemastore")`
- if it exists, use its JSON schemas
- otherwise fall back to an empty schema list

That kept JSON LSP alive even without the extra schema package.

## LSP Capability Handling

The LSP setup also needed capability handling that fit the new wrapper.

The preferred capability source became `blink.cmp`.

The config still retained compatibility logic for older setups that might use `cmp_nvim_lsp`.

This made the LSP setup more resilient and reduced coupling to the old completion stack.

## Harpoon Issue

Harpoon caused JSON serialization errors during buffer leave.

The root cause was that the config shape and call style were not aligned with the legacy Harpoon package that was actually installed.

The fix was to match the legacy `setup(config)` behavior and avoid injecting function-valued data into persisted config.

This removed the `attempt to dump function reference` problem.

## Todo Comments Issue

`todo-comments` failed because one keyword used a color name that did not exist in the available palette.

The fix was to replace that invalid color key with a built-in one.

This kept keyword highlighting working and avoided runtime validation failure.

## Lualine Theme Cleanup

`lualine` was adjusted to match the local colorscheme rather than expecting a theme plugin to provide its palette.

That kept the statusline visually aligned with `gxvjbox`.

It also reduced cross-plugin coupling.

## Dashboard and Picker Cleanup

The user explicitly wanted leftover Telescope usage removed in favor of Snacks.

That resulted in a sweep through dashboard and Trouble integrations.

The end state was:

- no live Telescope imports in the wrapper Lua tree
- picker actions routed through Snacks
- explorer-like actions routed through Snacks

## Validation Strategy

Each fix was validated in two ways:

- headless Neovim startup
- direct `dofile()` parsing of the edited plugin spec

This helped catch both syntax mistakes and runtime module failures.

When a file parsed but startup still failed, the issue was usually a missing packpath entry or a bad `require(...)` call inside an `after` hook.

## Headless Smoke Tests

The following check was used repeatedly:

- `nvim --headless '+qa'`

That confirmed the configured wrapper could start without immediate fatal errors.

For plugin-specific validation, the edited file was loaded through `dofile()` inside a minimal headless session.

## What Got Removed

The following stale plugin specs were removed because they were no longer needed or were actively causing runtime failures:

- Kanso
- Catppuccin
- Molten
- Evil Lualine

The common reason was that the wrapper already had a clearer source of truth for that feature, or the plugin was not being used anymore.

## What Got Kept

The following core pieces remained in place:

- custom gruvbox-like colorscheme
- Snacks as the picker/explorer stack
- wrapper-based plugin loading through `lz.n`
- LSP configuration through `nvim-lspconfig`
- editor features like Trouble, bufferline, which-key, and lualine

## Current State

At the time of writing, the Neovim wrapper starts cleanly in headless mode.

The major packpath failures have been removed.

The old Telescope dependency paths have been replaced where they mattered.

Optional dependencies are guarded instead of crashing startup.

## Lessons Learned

- `lz.n` plugin IDs must match the installed package layout.
- Optional dependencies should be guarded with `pcall` when they are not guaranteed by Nix.
- Stale theme plugins are better removed than left as no-op specs.
- A wrapper migration is easiest when one theme and one picker stack are treated as authoritative.
- Runtime errors often come from the `after` hook, not from the plugin spec structure itself.

## Verification History

Repeated validation showed the following kinds of checks were useful:

- start Neovim headless
- parse individual plugin specs with `dofile()`
- search for leftover references in the wrapper tree
- confirm no errors in the edited file itself

Those checks were enough to identify the root causes instead of chasing symptoms.

## Residual Risk

There may still be plugins whose behavior is sensitive to optional runtime packages outside the wrapper tree.

Those would show up as future `module not found` or packpath errors the same way the current ones did.

If that happens, the right response is usually the same:

- decide whether the plugin is still needed
- if yes, install or guard the dependency
- if no, remove the stale spec

## Short Summary

The migration work did three things well:

- moved the config toward wrapper-native `lz.n` specs
- preserved the custom Neovim theme
- removed or guarded the plugin references that were breaking startup

The main failures encountered were stale plugin IDs, missing optional modules, and old Telescope/theme assumptions.

The fixes were mostly straightforward once each failure was tied back to the exact plugin spec and package path.