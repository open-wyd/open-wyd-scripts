# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **Open WYD Scripts** — the server-side scripting layer for an Open WYD MMORPG server. Scripts are written in **Lua 5.3** and wired to the game engine via **XML binding files**. There is no build system or test runner; scripts are loaded directly by the game server at runtime.

Only the following Lua standard library modules are available: `string`, `table`, `math`. There is no `io`, `os`, `coroutine`, etc.

## Module Pattern

Every module follows the same three-part structure:

```
<Module>/
  <Module>.xml      # Binds game events/items/merchants/teleports → scripts
  lib/              # Shared Lua loaded as module-wide global context
  scripts/          # Individual Lua scripts executed per trigger
```

| Module | XML Binding Element | Script Entry Point |
|--------|--------------------|--------------------|
| `Events/` | `<event name="..." script="..."/>` | `EVENT_TASK_*` callbacks via `ScriptEvent` |
| `Itens/` | `<volatile id="..."/>`, `<volatilelist idList="..."/>`, `<volatilerange fromId="" toId=""/>` | `OnUse(npc, player, confirm)` |
| `Merchants/` | `<merchant eventid="..." script="..."/>` | `OnUse(npc, player, confirm)` |
| `Teleports/` | `<teleport fromx="" fromy="" tox="" toy="" script="..."/>` | per-script entry |
| `Conditions/` | `<Condition ticktype="..." script="..."/>` | per-tick callback |
| `Promotions/` | `<promotion id="" script="" explist="..."/>` | per-script entry |

The `eventid` in `Merchants.xml` must match the `merchant` attribute on the creature XML in `Data/Creatures/`.

## Global Context

**`global.lua`** is always in scope and defines:
- `TRUE`/`FALSE`/`LUA_ERROR`/`LUA_NO_ERROR` constants
- `ms` table for time conversions: `ms.sec(n)`, `ms.min(n)`, `ms.hour(n)`
- `params.find.flag` — FindItem flags (`T_ID`, `T_ADD1..3`, `T_VAL1..3`, etc.)
- `params.slot.flag` — slot type flags (`SLOT_EQUIP`, `SLOT_CARRY`, `SLOT_CARGO`)
- `params.conditions` — named condition IDs (e.g. `params.conditions.CONDITION_SLOWNESS`)
- `params.eventTask` — event task types (`EXECUTE`, `LOAD`, `START`, `STOP`, `FINALLY`)
- `params.skills.SoulLimit`
- `global_OWS` — game-wide constants: map zone IDs, environment IDs, opcode values, quest bit flags
- Item effect IDs: `EF_LEVEL`, `EF_HP`, `EF_MP`, `EF_VOLATILE`, `EF_SANC`, `EF_AMOUNT`, etc.

**`language.lua`** provides localized string helpers.

## Platform API (engine-provided globals)

These are injected by the game engine — not Lua standard library:

- **`iGameServer`** — world manipulation: `DoTeleport`, `CreateMob`, `PutItem`, `DeleteMob`, `ClearArea`, `TryLevelUpWithEffects`, `GetMapAttribute`, etc.
- **`iSend`** — network sends to clients: `Say`, `ClientMessage`, `Notice`, `Item`, `Score`, `Etc`, `Carry`, `SetHpMp`, `Chat`, etc.
- **`iItems`** — item data lookup: `GetItemById`, `GetItemAbility`, `SetItemBonus`, `SetItemSanc`, `GetItemSanc`, etc.
- **`FindItem(player)`** — inventory search/replace: `findItem`, `findItemId`, `replaceItemId`, `amount`, `getSlot`, `clearItems`
- **`CItem`** — item instance: `getId`, `setId`, `getAddValue`, `setAddValue`, `getMountHp`, etc.
- **`CPosition`** — map coordinate: `CPosition(x, y)`, `.x`, `.y`, `isBetween`, `validate`
- **`Creature` / `Player` / `Npc`** — entity types; `Player` extends `Creature`. Key methods: `getCoin/setCoin`, `getExp/addExp`, `getHp/setHp`, `getName`, `getLevel`, `getClass`, `getClan`, `getMount`, `getQuest/addQuest/hasQuest`, `getEnvI64/setEnvI64`, `addCondition`, `doBuildCurrentScore`
- **`SpawnManager`** / **`SpawnBuilder`** — runtime spawn control
- **`iLog(string)`** — server-side logging

## Creature XML (`Data/Creatures/`)

Each file defines one creature with this structure:

```xml
<creature name="..." level="..." merchant="..." clan="..." class="..." experience="..." gold="...">
  <health now="..." max="..." regen="..." />
  <status str="..." dex="..." int="..." con="..." />
  <special special1="..." special2="..." special3="..." special4="..." />
  <strategy damage="..." magic="..." critical="..." attack_speed="..." move_speed="..." defense="..."/>
  <look>
    <corpse id="..." brightness="..." />
    <!-- helmet, armor, pants, glove, boots -->
  </look>
  <shopItems> <!-- optional, for merchants -->
    <item pos="..." id="...">
      <effect id="..." value="..."/>
    </item>
  </shopItems>
</creature>
```

The `name` attribute must match the `leader`/`follower` values in `Data/spawns.xml`.

## Spawns (`Data/spawns.xml`)

Large file (~7400 lines) binding creature names to world positions. Each `<spawn>` references creature names that must exist in `Data/Creatures/`. Walk routes use `<walk segment="..." .../>` child elements.
