# Build Game Compatibility
Build Game is forked from Minetest Game and as such, is closely related to it and has some compatibility with it.

## Migrating a Minetest Game world
To migrate an existing Minetest Game world to Build Game, first start by making a copy of the world to do the migration, so you have an old version if anything goes wrong.

Apart from vanilla Minetest Game, Build Game has built-in support for:
- `moreblocks` (including stairs+ nodes)
- `greenscreen`
- `mywalls`

Build Game does not contain any craftitems (except for ones related to building) from Minetest Game. These will show up as unknown items and you will have to dispose of them. Chests still exist but are purely decorative and will be scrubbed by an LBM.

Then, replace the `gameid = minetest` in world.mt to `gameid = build` (**not** build_game! Minetest hardcoded junk strikes again...)

Create a file called `minetest.conf` inside of the world folder. Build Game is able to read this file for its internal configuration. Write

```conf
bldg_compat = true
```

To enable MTG compatibility.

## Texture pack compatibility
Build Game shares its texture names with Minetest Game and other mods, so any texture packs made for
