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
