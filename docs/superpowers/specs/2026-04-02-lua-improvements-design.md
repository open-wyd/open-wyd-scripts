# Lua Code Improvements — Design Spec

**Date:** 2026-04-02  
**Branch:** feat/add-claude  
**Approach:** Fix-first, then refactor (Opção A)

---

## Contexto

O projeto Open WYD Scripts é a camada de scripting server-side do MMORPG Open WYD, escrita em Lua 5.3. Não há build system nem test runner — os scripts são carregados diretamente pelo servidor em runtime.

A análise do codebase identificou três categorias de problemas:
1. **Bugs críticos** — erros que causam falha em runtime
2. **Duplicação massiva** — 85+ scripts de teleporte idênticos
3. **Magic numbers e ruído** — dificultam manutenção e balanceamento

---

## Fase 1 — Bug Fixes Críticos

**Arquivos:** `Merchants/scripts/Trainer_of_Newbie.lua`, `Promotions/lib/Promotions.lua`  
**Commit:** único, isolado

### 1.1 Typo: `Ilog` → `iLog`

**Arquivo:** `Merchants/scripts/Trainer_of_Newbie.lua:177`

```lua
-- antes
Ilog("wrong trainer ruleId "..npc:getMerchant());

-- depois
iLog("wrong trainer ruleId "..npc:getMerchant());
```

### 1.2 Variável inválida: `MobTypesARCH` → `MobTypes.ARCH`

**Arquivo:** `Promotions/lib/Promotions.lua:101`

```lua
-- antes
elseif (itemMobType == MobTypes.CELESTIAL and (playerMobType == MobTypes.MORTAL or playerMobType == MobTypesARCH)) then

-- depois
elseif (itemMobType == MobTypes.CELESTIAL and (playerMobType == MobTypes.MORTAL or playerMobType == MobTypes.ARCH)) then
```

### 1.3 Lógica booleana invertida

**Arquivo:** `Promotions/lib/Promotions.lua:144-148`

```lua
-- antes (verbose e confuso)
if (result == false) then
    return FALSE;
end
return TRUE;

-- depois (direto)
return result;
```

---

## Fase 2 — Consolidação dos Scripts de Teleporte

**Arquivos afetados:** `Teleports/` inteiro  
**Risco:** Médio — requer atualizar o XML binding (`Teleports.xml`)

### Situação atual

85+ arquivos Lua, cada um com:
```lua
function OnUse(player)
    doTeleport(player, X, Y)
end
```

### Nova estrutura

**`Teleports/lib/Teleports.lua`** — tabela de rotas + dispatcher:

```lua
TeleportRoutes = {
    [1]  = { x = 1234, y = 5678 }, -- descrição da rota
    [2]  = { x = 2345, y = 6789 },
    -- ... todas as rotas extraídas dos 85+ scripts
}

function Teleports.dispatch(player, eventid)
    local route = TeleportRoutes[eventid]
    if route == nil then
        iLog("Teleport: rota não encontrada para eventid " .. eventid)
        return LUA_ERROR
    end
    doTeleport(player, route.x, route.y)
    return LUA_NO_ERROR
end
```

**`Teleports/scripts/dispatch.lua`** — único script referenciado por todos os bindings:

```lua
function OnUse(player, eventid)
    Teleports.dispatch(player, eventid)
end
```

**`Teleports/Teleports.xml`** — todos os `<teleport>` passam a apontar para `dispatch.lua` em vez de scripts individuais.

**Deletados:** todos os 85+ scripts individuais em `Teleports/scripts/` (exceto `dispatch.lua`).

### Benefícios

- Startup mais rápido: 1 arquivo carregado em vez de 85+
- Todas as rotas visíveis em um único lugar
- Bug fix em teleporte = 1 linha editada, não 85

---

## Fase 3 — Extração de Magic Numbers

**Arquivos afetados:** ~6 scripts  
**Commit:** único

### 3a. Constantes locais (escopo do script)

Para IDs e valores usados apenas dentro de um único script:

**`Itens/scripts/essence_of_pet.lua`:**
```lua
local MOUNT_MAX_LEVEL   = 120
local MOUNT_ITEM_ID_MIN = 2360
local MOUNT_ITEM_ID_MAX = 2390
```

### 3b. Constantes globais compartilhadas

Para IDs de item referenciados em múltiplos scripts, adicionar em `global.lua` junto com os `EF_*` existentes:

```lua
-- Recompensas do Trainer of Newbie
ITEM_ID_TRAINER_REWARD_1 = 653
ITEM_ID_TRAINER_REWARD_2 = 481
ITEM_ID_TRAINER_REWARD_3 = 400
```

### 3c. Helpers de tempo

Substituir cálculos manuais pelos helpers `ms.*` já existentes em `global.lua`:

**`Events/scripts/nightmare.lua:91`:**
```lua
-- antes
local initBoss = (18*(60*1000));;

-- depois
local BOSS_SPAWN_DELAY = ms.min(18)
```

### Fora de escopo

Coordenadas X/Y dos scripts de Events (`nightmare.lua`, `duel_letter.lua`) não são extraídas — são específicas de cada evento e já têm contexto claro no código.

---

## Fase 4 — Guard de Reentrância no `OnGainExp`

**Arquivos:** `Promotions/scripts/mortal.lua`, `Promotions/scripts/arch.lua`  
**Commit:** único

**Problema:** `OnGainExp` chama `addExp`, que pode disparar `OnGainExp` novamente — risco teórico de stack overflow documentado em TODO.

**Solução:** flag de reentrância local ao script:

```lua
local _gainExpLocked = false

function OnGainExp(player, experience)
    if _gainExpLocked then return LUA_NO_ERROR end
    _gainExpLocked = true

    -- lógica existente sem alteração

    _gainExpLocked = false
    return LUA_NO_ERROR
end
```

Remove o TODO sem alterar a lógica de progressão de XP.

---

## Fase 5 — Limpeza Geral

**Commit:** único housekeeping

| Item | Arquivo | Mudança |
|------|---------|---------|
| 5a Dead code | `Itens/lib/Itens.lua` | Remover `return -1` inalcançável após `else return -1; end` |
| 5b Double semicolon | `Events/scripts/nightmare.lua:91` | `;;` → `;` |
| 5c Debug code | `Events/scripts/duel_letter.lua:128-131` | Remover bloco `if(level > 1000)` de debug |
| 5d Libs vazias | `Conditions/lib/Conditions.lua`, `Merchants/lib/Merchants.lua` | Adicionar comentário de módulo indicando extensão futura |
| 5e Whitespace | `Itens/scripts/molar-do-gargula.lua:1` | Normalizar indentação (`\t` → espaço antes do `if`) |

---

## Resumo

| Fase | Risco | Arquivos | Commit |
|------|-------|----------|--------|
| 1 — Bug fixes críticos | Zero | 2 | `fix: correct critical runtime bugs in Promotions and Trainer` |
| 2 — Consolidação teleportes | Médio | 85+ → 3 | `refactor: consolidate teleport scripts into route table dispatcher` |
| 3 — Magic numbers | Baixo | ~6 | `refactor: extract magic numbers to named constants` |
| 4 — Guard OnGainExp | Zero | 2 | `fix: add reentrancy guard to OnGainExp in Promotions scripts` |
| 5 — Limpeza geral | Zero | ~5 | `chore: remove dead code, debug artifacts, and whitespace issues` |
