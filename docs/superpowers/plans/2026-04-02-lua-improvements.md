# Lua Code Improvements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Corrigir bugs críticos de runtime e melhorar a manutenibilidade do codebase Lua, eliminando duplicação massiva e magic numbers.

**Architecture:** Fix-first then refactor — bugs isolados num commit cirúrgico, depois melhorias estruturais independentes em sequência. Sem test runner; verificação é manual via inspeção de código.

**Tech Stack:** Lua 5.3, XML binding, engine globals (`iGameServer`, `iSend`, `iItems`, `iLog`, `doTeleport`)

---

## Mapa de Arquivos

| Fase | Ação | Arquivo |
|------|------|---------|
| 1 | Modify | `Merchants/scripts/Trainer_of_Newbie.lua` |
| 1 | Modify | `Promotions/lib/Promotions.lua` |
| 2 | Modify | `Teleports/lib/Teleports.lua` |
| 2 | Modify | 57 scripts em `Teleports/scripts/**/*.lua` (exceto os 2 com lógica customizada) |
| 3 | Modify | `global.lua` |
| 3 | Modify | `Merchants/scripts/Trainer_of_Newbie.lua` |
| 3 | Modify | `Itens/scripts/essence_of_pet.lua` |
| 3 | Modify | `Events/scripts/nightmare.lua` |
| 4 | Modify | `Promotions/scripts/mortal.lua` |
| 4 | Modify | `Promotions/scripts/arch.lua` |
| 5 | Modify | `Itens/lib/Itens.lua` |
| 5 | Modify | `Events/scripts/nightmare.lua` |
| 5 | Modify | `Events/scripts/duel_letter.lua` |
| 5 | Modify | `Conditions/lib/Conditions.lua` |
| 5 | Modify | `Merchants/lib/Merchants.lua` |
| 5 | Modify | `Itens/scripts/molar-do-gargula.lua` |

---

## Task 1: Bug Fix — `Ilog` typo em Trainer_of_Newbie

**Files:**
- Modify: `Merchants/scripts/Trainer_of_Newbie.lua:177`

- [ ] **Step 1: Localizar e corrigir o typo**

Em `Merchants/scripts/Trainer_of_Newbie.lua`, linha 177, alterar:
```lua
-- antes
		Ilog("wrong trainer ruleId "..npc:getMerchant());
-- depois
		iLog("wrong trainer ruleId "..npc:getMerchant());
```

- [ ] **Step 2: Verificar que não há outras ocorrências de `Ilog`**

Buscar no projeto inteiro:
```
grep -r "Ilog" --include="*.lua" .
```
Resultado esperado: nenhuma ocorrência.

---

## Task 2: Bug Fix — `MobTypesARCH` variável inválida em Promotions

**Files:**
- Modify: `Promotions/lib/Promotions.lua:101`

- [ ] **Step 1: Corrigir o acesso à tabela**

Em `Promotions/lib/Promotions.lua`, linha 101, alterar:
```lua
-- antes
    elseif (itemMobType == MobTypes.CELESTIAL and (playerMobType == MobTypes.MORTAL or playerMobType == MobTypesARCH)) then
-- depois
    elseif (itemMobType == MobTypes.CELESTIAL and (playerMobType == MobTypes.MORTAL or playerMobType == MobTypes.ARCH)) then
```

- [ ] **Step 2: Verificar que `MobTypes` é uma local no mesmo arquivo**

Confirmar que `local MobTypes = { ARCH = 1, ... }` está definido em `Promotions/lib/Promotions.lua:21`. Resultado esperado: está na linha 21.

---

## Task 3: Bug Fix — Lógica booleana invertida em Promotions

**Files:**
- Modify: `Promotions/lib/Promotions.lua:144-148`

- [ ] **Step 1: Entender o que `result` representa**

Ler `Promotions/lib/Promotions.lua:136-142`. O `result` é:
```lua
local result = (
        lvl < player:getLevel() or
        str < player:getBaseStr() or
        spt < player:getBaseInt() or
        agi < player:getBaseDex() or
        con < player:getBaseCon()
    );
```
`result` é `true` quando o jogador PODE equipar (atributos suficientes). `false` quando não pode.

- [ ] **Step 2: Simplificar o retorno**

Em `Promotions/lib/Promotions.lua:144-148`, alterar:
```lua
-- antes
    if (result == false) then
        return FALSE;
    end

    return TRUE;
-- depois
    return result;
```

**Nota:** `result` aqui é um boolean Lua nativo (`true`/`false`), não `TRUE`/`FALSE` (que são `1`/`0`). Verificar se a função chamadora (`OnEquipItem` em `mortal.lua:45`) usa o retorno como boolean ou como inteiro. Se o engine espera `1`/`0`, manter a lógica explícita. Ajustar conforme necessário:

Se o engine aceita boolean nativo:
```lua
    return result;
```

Se o engine requer `TRUE`/`FALSE` (inteiro):
```lua
    if result then return TRUE; end
    return FALSE;
```

- [ ] **Step 3: Commit das 3 correções de bug**

```bash
git add Merchants/scripts/Trainer_of_Newbie.lua Promotions/lib/Promotions.lua
git commit -m "fix: correct critical runtime bugs in Promotions and Trainer_of_Newbie"
```

---

## Task 4: Consolidação dos Teleportes — Route Table em lib

**Context:** 57 scripts de teleporte simples (todos exceto `HallofKefraToQuest.lua` e `Kefra4ToHallOfKefra.lua`) seguem o padrão idêntico de 3 linhas. A abordagem é centralizar todas as coordenadas em `Teleports/lib/Teleports.lua` com nil-check e error logging, e transformar cada script num 1-liner.

**Files:**
- Modify: `Teleports/lib/Teleports.lua`

- [ ] **Step 1: Preencher `Teleports/lib/Teleports.lua` com a tabela de rotas e dispatcher**

Substituir o conteúdo atual (1 linha vazia) pelo seguinte:

```lua
-- Tabela centralizada de rotas de teleporte.
-- Chave: nome do script (sem extensão), exatamente como aparece no caminho.
-- Valor: coordenadas de destino {x, y}.
TeleportRoutes = {
    -- Armia
    ["Armia1ToDungeom1"]      = {x = 145,  y = 3791},
    ["Armia2ToDungeom1"]      = {x = 146,  y = 3775},
    ["ArmiaToCampoArmia"]     = {x = 2587, y = 2098},
    ["ArmiaToNoaton"]         = {x = 1046, y = 1726},
    -- Arzan
    ["ArzanToCampoArzan1"]    = {x = 2248, y = 1559},
    ["ArzanToCampoArzan2"]    = {x = 1967, y = 1710},
    ["ArzanToNoaton"]         = {x = 1046, y = 1717},
    ["ArzanToSubMundo1"]      = {x = 1173, y = 4077},
    -- Dungeom
    ["Dungeom1bToDungeom2b"]  = {x = 1004, y = 4067},
    ["Dungeom1cToDungeom2c"]  = {x = 1004, y = 3995},
    ["Dungeom1dToDungeom3"]   = {x = 912,  y = 3812},
    ["Dungeom1ToArmia1"]      = {x = 2364, y = 2284},
    ["Dungeom1ToArmia2"]      = {x = 2668, y = 2157},
    ["Dungeom1ToDungeom2"]    = {x = 1006, y = 4030},
    ["Dungeom2bToDungeom1b"]  = {x = 408,  y = 4073},
    ["Dungeom2cToDungeom1c"]  = {x = 746,  y = 3817},
    ["Dungeom2dToDungeom3"]   = {x = 916,  y = 3822},
    ["Dungeom2eToDungeom3"]   = {x = 932,  y = 3822},
    ["Dungeom2ToDungeom1"]    = {x = 147,  y = 3781},
    ["Dungeom3ToDungeom1d"]   = {x = 743,  y = 3808},
    ["Dungeom3ToDungeom2d"]   = {x = 1004, y = 4067},
    ["Dungeom3ToDungeom2e"]   = {x = 876,  y = 3875},
    -- Erion
    ["ErionToCampoAzran3"]    = {x = 2049, y = 1608},
    ["ErionToNoaron"]         = {x = 1046, y = 1710},
    -- Gelo
    ["CeloCastleToGelo4"]     = {x = 3695, y = 2880},
    ["Gelo1ToGelo2"]          = {x = 3569, y = 2975},
    ["Gelo1ToGelo4"]          = {x = 3642, y = 2929},
    ["Gelo1ToGeloCity"]       = {x = 3648, y = 3092},
    ["Gelo2ToGelo1"]          = {x = 3606, y = 3000},
    ["Gelo2ToGelo3"]          = {x = 3505, y = 2929},
    ["Gelo3ToGelo2"]          = {x = 3507, y = 2961},
    ["Gelo3ToGelo4"]          = {x = 3599, y = 2879},
    ["Gelo4ToGelo5"]          = {x = 3627, y = 2799},
    ["Gelo4ToGeloAmald"]      = {x = 3673, y = 2800},
    ["Gelo4ToGeloCastle"]     = {x = 3727, y = 2883},
    ["Gelo5ToGelo4"]          = {x = 3649, y = 2832},
    ["GeloAmaldToGelo4"]      = {x = 3678, y = 2836},
    ["GeloAmonToGelCastle"]   = {x = 3793, y = 2927},
    ["GeloCastleToGeloAmon"]  = {x = 3801, y = 2952},
    ["GeloCityToGelo1"]       = {x = 3652, y = 3057},
    ["GeloCityToNoatum"]      = {x = 1053, y = 1709},
    -- Kefra (simples)
    ["Kefra1aToKefra2ab"]     = {x = 2447, y = 4066},
    ["Kefra1bToKefra2c"]      = {x = 2289, y = 4065},
    ["Kefra2aToKefra3a"]      = {x = 2474, y = 3953},
    ["Kefra2bToKefra3b"]      = {x = 2512, y = 3952},
    ["Kefra2cToKefra3c"]      = {x = 2230, y = 3950},
    ["Kefra3abToKefra4"]      = {x = 2417, y = 3867},
    ["Kefra3cToKefra4"]       = {x = 2319, y = 3867},
    ["KefraToNoaton"]         = {x = 1312, y = 1903},
    -- Noaton
    ["NoatonGuildaToCastle"]  = {x = 1107, y = 1721},
    ["NoatonToArmia"]         = {x = 2118, y = 2102},
    ["NoatonToAzran"]         = {x = 2482, y = 1717},
    ["NoatonToErion"]         = {x = 2458, y = 2018},
    ["NoatonToGelo"]          = {x = 3649, y = 3109},
    ["NoatonToKefra"]         = {x = 2365, y = 4069},
    -- SubMundo
    ["SubMundo1ToAzran"]      = {x = 1824, y = 1775},
    ["SubMundo1ToSubMundo2"]  = {x = 1304, y = 3819},
    ["SubMundo2ToSubMundo1"]  = {x = 1518, y = 3997},
}

-- Dispatcher central. Chamado por cada script de teleporte simples.
-- routeKey: chave na tabela TeleportRoutes (nome do script sem extensão).
function teleport(player, routeKey)
    local route = TeleportRoutes[routeKey]
    if route == nil then
        iLog("Teleport: rota nao encontrada para chave: " .. tostring(routeKey))
        return LUA_ERROR
    end
    doTeleport(player, route.x, route.y)
    return LUA_NO_ERROR
end
```

- [ ] **Step 2: Contar que a tabela tem 57 entradas**

```bash
grep -c "= {x =" Teleports/lib/Teleports.lua
```
Resultado esperado: `57`

---

## Task 5: Consolidação dos Teleportes — Atualizar scripts simples

**Files:**
- Modify: 57 arquivos em `Teleports/scripts/**/*.lua` (todos exceto `HallofKefraToQuest.lua` e `Kefra4ToHallOfKefra.lua`)

- [ ] **Step 1: Substituir cada script simples pelo 1-liner**

Para cada um dos 57 scripts listados abaixo, substituir o conteúdo inteiro pelo formato:
```lua
function OnUse(player) teleport(player, "NomeDoScript") end
```

Onde `NomeDoScript` é exatamente a chave correspondente na `TeleportRoutes`.

Scripts e seus novos conteúdos:

**`Teleports/scripts/Armia/Armia1ToDungeom1.lua`:**
```lua
function OnUse(player) teleport(player, "Armia1ToDungeom1") end
```

**`Teleports/scripts/Armia/Armia2ToDungeom1.lua`:**
```lua
function OnUse(player) teleport(player, "Armia2ToDungeom1") end
```

**`Teleports/scripts/Armia/ArmiaToCampoArmia.lua`:**
```lua
function OnUse(player) teleport(player, "ArmiaToCampoArmia") end
```

**`Teleports/scripts/Armia/ArmiaToNoaton.lua`:**
```lua
function OnUse(player) teleport(player, "ArmiaToNoaton") end
```

**`Teleports/scripts/Arzan/ArzanToCampoArzan1.lua`:**
```lua
function OnUse(player) teleport(player, "ArzanToCampoArzan1") end
```

**`Teleports/scripts/Arzan/ArzanToCampoArzan2.lua`:**
```lua
function OnUse(player) teleport(player, "ArzanToCampoArzan2") end
```

**`Teleports/scripts/Arzan/ArzanToNoaton.lua`:**
```lua
function OnUse(player) teleport(player, "ArzanToNoaton") end
```

**`Teleports/scripts/Arzan/ArzanToSubMundo1.lua`:**
```lua
function OnUse(player) teleport(player, "ArzanToSubMundo1") end
```

**`Teleports/scripts/Dungeom/Dungeom1bToDungeom2b.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom1bToDungeom2b") end
```

**`Teleports/scripts/Dungeom/Dungeom1cToDungeom2c.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom1cToDungeom2c") end
```

**`Teleports/scripts/Dungeom/Dungeom1dToDungeom3.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom1dToDungeom3") end
```

**`Teleports/scripts/Dungeom/Dungeom1ToArmia1.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom1ToArmia1") end
```

**`Teleports/scripts/Dungeom/Dungeom1ToArmia2.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom1ToArmia2") end
```

**`Teleports/scripts/Dungeom/Dungeom1ToDungeom2.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom1ToDungeom2") end
```

**`Teleports/scripts/Dungeom/Dungeom2bToDungeom1b.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom2bToDungeom1b") end
```

**`Teleports/scripts/Dungeom/Dungeom2cToDungeom1c.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom2cToDungeom1c") end
```

**`Teleports/scripts/Dungeom/Dungeom2dToDungeom3.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom2dToDungeom3") end
```

**`Teleports/scripts/Dungeom/Dungeom2eToDungeom3.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom2eToDungeom3") end
```

**`Teleports/scripts/Dungeom/Dungeom2ToDungeom1.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom2ToDungeom1") end
```

**`Teleports/scripts/Dungeom/Dungeom3ToDungeom1d.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom3ToDungeom1d") end
```

**`Teleports/scripts/Dungeom/Dungeom3ToDungeom2d.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom3ToDungeom2d") end
```

**`Teleports/scripts/Dungeom/Dungeom3ToDungeom2e.lua`:**
```lua
function OnUse(player) teleport(player, "Dungeom3ToDungeom2e") end
```

**`Teleports/scripts/Erion/ErionToCampoAzran3.lua`:**
```lua
function OnUse(player) teleport(player, "ErionToCampoAzran3") end
```

**`Teleports/scripts/Erion/ErionToNoaron.lua`:**
```lua
function OnUse(player) teleport(player, "ErionToNoaron") end
```

**`Teleports/scripts/Gelo/CeloCastleToGelo4.lua`:**
```lua
function OnUse(player) teleport(player, "CeloCastleToGelo4") end
```

**`Teleports/scripts/Gelo/Gelo1ToGelo2.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo1ToGelo2") end
```

**`Teleports/scripts/Gelo/Gelo1ToGelo4.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo1ToGelo4") end
```

**`Teleports/scripts/Gelo/Gelo1ToGeloCity.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo1ToGeloCity") end
```

**`Teleports/scripts/Gelo/Gelo2ToGelo1.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo2ToGelo1") end
```

**`Teleports/scripts/Gelo/Gelo2ToGelo3.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo2ToGelo3") end
```

**`Teleports/scripts/Gelo/Gelo3ToGelo2.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo3ToGelo2") end
```

**`Teleports/scripts/Gelo/Gelo3ToGelo4.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo3ToGelo4") end
```

**`Teleports/scripts/Gelo/Gelo4ToGelo5.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo4ToGelo5") end
```

**`Teleports/scripts/Gelo/Gelo4ToGeloAmald.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo4ToGeloAmald") end
```

**`Teleports/scripts/Gelo/Gelo4ToGeloCastle.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo4ToGeloCastle") end
```

**`Teleports/scripts/Gelo/Gelo5ToGelo4.lua`:**
```lua
function OnUse(player) teleport(player, "Gelo5ToGelo4") end
```

**`Teleports/scripts/Gelo/GeloAmaldToGelo4.lua`:**
```lua
function OnUse(player) teleport(player, "GeloAmaldToGelo4") end
```

**`Teleports/scripts/Gelo/GeloAmonToGelCastle.lua`:**
```lua
function OnUse(player) teleport(player, "GeloAmonToGelCastle") end
```

**`Teleports/scripts/Gelo/GeloCastleToGeloAmon.lua`:**
```lua
function OnUse(player) teleport(player, "GeloCastleToGeloAmon") end
```

**`Teleports/scripts/Gelo/GeloCityToGelo1.lua`:**
```lua
function OnUse(player) teleport(player, "GeloCityToGelo1") end
```

**`Teleports/scripts/Gelo/GeloCityToNoatum.lua`:**
```lua
function OnUse(player) teleport(player, "GeloCityToNoatum") end
```

**`Teleports/scripts/Kefra/Kefra1aToKefra2ab.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra1aToKefra2ab") end
```

**`Teleports/scripts/Kefra/Kefra1bToKefra2c.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra1bToKefra2c") end
```

**`Teleports/scripts/Kefra/Kefra2aToKefra3a.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra2aToKefra3a") end
```

**`Teleports/scripts/Kefra/Kefra2bToKefra3b.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra2bToKefra3b") end
```

**`Teleports/scripts/Kefra/Kefra2cToKefra3c.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra2cToKefra3c") end
```

**`Teleports/scripts/Kefra/Kefra3abToKefra4.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra3abToKefra4") end
```

**`Teleports/scripts/Kefra/Kefra3cToKefra4.lua`:**
```lua
function OnUse(player) teleport(player, "Kefra3cToKefra4") end
```

**`Teleports/scripts/Kefra/KefraToNoaton.lua`:**
```lua
function OnUse(player) teleport(player, "KefraToNoaton") end
```

**`Teleports/scripts/Noaton/NoatonGuildaToCastle.lua`:**
```lua
function OnUse(player) teleport(player, "NoatonGuildaToCastle") end
```

**`Teleports/scripts/Noaton/NoatonToArmia.lua`:**
```lua
function OnUse(player) teleport(player, "NoatonToArmia") end
```

**`Teleports/scripts/Noaton/NoatonToAzran.lua`:**
```lua
function OnUse(player) teleport(player, "NoatonToAzran") end
```

**`Teleports/scripts/Noaton/NoatonToErion.lua`:**
```lua
function OnUse(player) teleport(player, "NoatonToErion") end
```

**`Teleports/scripts/Noaton/NoatonToGelo.lua`:**
```lua
function OnUse(player) teleport(player, "NoatonToGelo") end
```

**`Teleports/scripts/Noaton/NoatonToKefra.lua`:**
```lua
function OnUse(player) teleport(player, "NoatonToKefra") end
```

**`Teleports/scripts/SubMundo/SubMundo1ToAzran.lua`:**
```lua
function OnUse(player) teleport(player, "SubMundo1ToAzran") end
```

**`Teleports/scripts/SubMundo/SubMundo1ToSubMundo2.lua`:**
```lua
function OnUse(player) teleport(player, "SubMundo1ToSubMundo2") end
```

**`Teleports/scripts/SubMundo/SubMundo2ToSubMundo1.lua`:**
```lua
function OnUse(player) teleport(player, "SubMundo2ToSubMundo1") end
```

- [ ] **Step 2: Verificar que `HallofKefraToQuest.lua` e `Kefra4ToHallOfKefra.lua` NÃO foram alterados**

```bash
grep -l "doTeleport\|iGetGlobalEnvInt64\|iGetEvent" Teleports/scripts/Kefra/
```
Resultado esperado: ambos os arquivos aparecem (lógica customizada intacta).

- [ ] **Step 3: Verificar que todos os outros scripts foram convertidos**

```bash
grep -r "doTeleport" Teleports/scripts/ --include="*.lua" -l
```
Resultado esperado: nenhuma linha (todos os `doTeleport` diretos foram removidos dos scripts simples).

- [ ] **Step 4: Commit**

```bash
git add Teleports/lib/Teleports.lua Teleports/scripts/
git commit -m "refactor: consolidate teleport scripts into centralized route table"
```

---

## Task 6: Magic Numbers — Constantes em `global.lua`

**Files:**
- Modify: `global.lua`

- [ ] **Step 1: Adicionar constantes de IDs de item do Trainer**

Em `global.lua`, após o bloco dos `EF_*` (linha ~107), adicionar:

```lua
-- Item IDs: recompensas do Trainer of Newbie
ITEM_ID_TRAINER_REWARD_1 = 653
ITEM_ID_TRAINER_REWARD_2 = 481
ITEM_ID_TRAINER_REWARD_3 = 400
```

- [ ] **Step 2: Verificar que os IDs estão corretos**

Conferir os valores com o uso em `Merchants/scripts/Trainer_of_Newbie.lua`:
```bash
grep -n "653\|481\|400" Merchants/scripts/Trainer_of_Newbie.lua
```
Os números 653, 481 e 400 devem aparecer no arquivo.

---

## Task 7: Magic Numbers — Constantes locais em `essence_of_pet.lua`

**Files:**
- Modify: `Itens/scripts/essence_of_pet.lua`

- [ ] **Step 1: Adicionar constantes no topo do arquivo**

Em `Itens/scripts/essence_of_pet.lua`, antes da linha 1 (`local SancRateList`), adicionar:

```lua
local MOUNT_ITEM_BASE_ID   = 2330  -- ID base dos mounts (range: 2330-2390)
local MOUNT_ITEM_YOUNG_MAX = 2360  -- Mounts jovens: 2330-2359
local MOUNT_ITEM_ADULT_MAX = 2390  -- Mounts adultos: 2360-2389
local MOUNT_MAX_LEVEL      = 120   -- Nível máximo para mounts adultos
local ESSENCE_BASE_ID      = 2390  -- ID base das essências de pet
```

- [ ] **Step 2: Substituir magic numbers no corpo do script**

Alterar linha 21:
```lua
-- antes
	if (mountItem:isBetween(2330, 2390) == false or mountItem:getMountHp() <= 0) then
-- depois
	if (mountItem:isBetween(MOUNT_ITEM_BASE_ID, MOUNT_ITEM_ADULT_MAX) == false or mountItem:getMountHp() <= 0) then
```

Alterar linha 25:
```lua
-- antes
	if (getEssencePetIdByMountId(mountItem:getId()) ~= ((pSrc.itemId - 2390) % 30)) then
-- depois
	if (getEssencePetIdByMountId(mountItem:getId()) ~= ((pSrc.itemId - ESSENCE_BASE_ID) % 30)) then
```

Alterar linha 31:
```lua
-- antes
	if (level >= 120 and mountItem:isBetween(2360, 2390)) then
-- depois
	if (level >= MOUNT_MAX_LEVEL and mountItem:isBetween(MOUNT_ITEM_YOUNG_MAX, MOUNT_ITEM_ADULT_MAX)) then
```

Alterar linha 40:
```lua
-- antes
	if (mountItem:isBetween(2360, 2390)) then
-- depois
	if (mountItem:isBetween(MOUNT_ITEM_YOUNG_MAX, MOUNT_ITEM_ADULT_MAX)) then
```

Alterar linha 71:
```lua
-- antes
	if ((level >= 25 and mountItem:getId() == 2330) or (level >= 35 and mountItem:getId() == 2331) or (level >= 100 and mountItem:isBetween(2332, 2360))) then
-- depois
	if ((level >= 25 and mountItem:getId() == MOUNT_ITEM_BASE_ID) or (level >= 35 and mountItem:getId() == MOUNT_ITEM_BASE_ID + 1) or (level >= 100 and mountItem:isBetween(MOUNT_ITEM_BASE_ID + 2, MOUNT_ITEM_YOUNG_MAX))) then
```

Alterar linha 85:
```lua
-- antes
	if (mountItem:isBetween(2330, 2360)) then
-- depois
	if (mountItem:isBetween(MOUNT_ITEM_BASE_ID, MOUNT_ITEM_YOUNG_MAX)) then
```

Alterar linha 87:
```lua
-- antes
	elseif (mountItem:isBetween(2360, 2390)) then
-- depois
	elseif (mountItem:isBetween(MOUNT_ITEM_YOUNG_MAX, MOUNT_ITEM_ADULT_MAX)) then
```

Alterar linha 4 (função `getEssencePetIdByMountId`):
```lua
-- antes
	local mountId = (mountItemId - 2330) % 30;
-- depois
	local mountId = (mountItemId - MOUNT_ITEM_BASE_ID) % 30;
```

---

## Task 8: Magic Numbers — Tempo em `nightmare.lua`

**Files:**
- Modify: `Events/scripts/nightmare.lua:91`

- [ ] **Step 1: Substituir cálculo manual pelo helper `ms.min`**

Em `Events/scripts/nightmare.lua`, linha 91, alterar:
```lua
-- antes
local initBoss = (18*(60*1000));;
-- depois
local BOSS_SPAWN_DELAY = ms.min(18)
```

- [ ] **Step 2: Atualizar qualquer referência a `initBoss` no mesmo arquivo**

```bash
grep -n "initBoss" Events/scripts/nightmare.lua
```
Para cada ocorrência encontrada, substituir `initBoss` por `BOSS_SPAWN_DELAY`.

- [ ] **Step 3: Commit das tasks 6, 7 e 8**

```bash
git add global.lua Itens/scripts/essence_of_pet.lua Events/scripts/nightmare.lua Merchants/scripts/Trainer_of_Newbie.lua
git commit -m "refactor: extract magic numbers to named constants"
```

---

## Task 9: Guard de Reentrância em `mortal.lua`

**Files:**
- Modify: `Promotions/scripts/mortal.lua`

- [ ] **Step 1: Adicionar flag de reentrância**

Em `Promotions/scripts/mortal.lua`, adicionar a flag antes da função `OnGainExp` (antes da linha 36):

```lua
local _gainExpLocked = false
```

- [ ] **Step 2: Envolver o corpo de `OnGainExp` com o guard**

Alterar a função `OnGainExp` (linhas 36-38):
```lua
-- antes
function OnGainExp(player, experience) -- TODO: Correct the potential of infinite loop (recursive use of the Creature->addExp)
	return experience;
end

-- depois
local _gainExpLocked = false

function OnGainExp(player, experience)
    if _gainExpLocked then return experience end
    _gainExpLocked = true
    local result = experience
    _gainExpLocked = false
    return result
end
```

**Nota:** O retorno é `experience` (não `LUA_NO_ERROR`) porque `OnGainExp` retorna o valor de XP a ser aplicado.

---

## Task 10: Guard de Reentrância em `arch.lua`

**Files:**
- Modify: `Promotions/scripts/arch.lua`

- [ ] **Step 1: Aplicar a mesma correção da Task 9**

Em `Promotions/scripts/arch.lua`, alterar `OnGainExp` (linha 36) com o mesmo padrão:

```lua
local _gainExpLocked = false

function OnGainExp(player, experience)
    if _gainExpLocked then return experience end
    _gainExpLocked = true
    local result = experience
    _gainExpLocked = false
    return result
end
```

- [ ] **Step 2: Commit**

```bash
git add Promotions/scripts/mortal.lua Promotions/scripts/arch.lua
git commit -m "fix: add reentrancy guard to OnGainExp in Promotions scripts"
```

---

## Task 11: Limpeza Geral

**Files:**
- Modify: `Itens/lib/Itens.lua`
- Modify: `Events/scripts/nightmare.lua`
- Modify: `Events/scripts/duel_letter.lua`
- Modify: `Conditions/lib/Conditions.lua`
- Modify: `Merchants/lib/Merchants.lua`
- Modify: `Itens/scripts/molar-do-gargula.lua`

- [ ] **Step 1: Remover `return -1` inalcançável em `Itens/lib/Itens.lua`**

Em `Itens/lib/Itens.lua`, a função `getClassIdByCorpseId` termina com um `return -1` após o bloco `else return -1; end`. Linha 41: remover o `return -1` final (inalcançável).

```lua
-- antes (linhas 37-42)
		else
			return -1;
		end
		
	else
		return -1;
	end
	
	return -1;   -- <- REMOVER esta linha
end
```

- [ ] **Step 2: Remover double semicolon em `nightmare.lua`**

Após a Task 8 já ter alterado a linha 91, verificar que o `;;` foi removido. O resultado deve ser:
```lua
local BOSS_SPAWN_DELAY = ms.min(18)
```
(sem ponto-e-vírgula duplo — o `;;` foi parte da linha original que já foi reescrita na Task 8).

- [ ] **Step 3: Remover bloco de debug em `duel_letter.lua`**

Em `Events/scripts/duel_letter.lua`, remover as linhas 128-131:
```lua
			-- Debug
			if(Env.owner:getLevel() > 1000) then
				iSend.Say(Env.owner, "nextEnvId: "..nextEnvId.." - envId+1: "..envId+1);
			end
```

- [ ] **Step 4: Adicionar comentário de módulo em `Conditions/lib/Conditions.lua`**

Substituir o conteúdo atual (linha vazia) por:
```lua
-- Conditions module library.
-- Adicione aqui funções utilitárias compartilhadas entre scripts de Conditions/.
```

- [ ] **Step 5: Adicionar comentário de módulo em `Merchants/lib/Merchants.lua`**

Substituir o conteúdo atual (linha vazia) por:
```lua
-- Merchants module library.
-- Adicione aqui funções utilitárias compartilhadas entre scripts de Merchants/.
```

- [ ] **Step 6: Corrigir indentação em `molar-do-gargula.lua`**

Em `Itens/scripts/molar-do-gargula.lua`, linha 1, remover o tab antes de `function`:
```lua
-- antes
	function OnUse(player, pSrc, pNumber, pDest)
-- depois
function OnUse(player, pSrc, pNumber, pDest)
```

- [ ] **Step 7: Commit final**

```bash
git add Itens/lib/Itens.lua Events/scripts/duel_letter.lua Conditions/lib/Conditions.lua Merchants/lib/Merchants.lua Itens/scripts/molar-do-gargula.lua
git commit -m "chore: remove dead code, debug artifacts, and whitespace issues"
```
