-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = require(game.ReplicatedStorage.MapScripts.Map)
script.Main.Parent = game.Players.LocalPlayer.PlayerGui
script.MapTest.Parent = game.Players.LocalPlayer.PlayerGui
script.SpawnPlane.Parent = game.Players.LocalPlayer.PlayerGui
script.WorldMap.Parent = game.Players.LocalPlayer.PlayerGui
script.AircraftSel.Parent = game.Players.LocalPlayer.PlayerGui
script.ThumbTaker.Parent = game.Players.LocalPlayer.PlayerGui
local u2 = v1.new({ 14, 12 }, script.BaseLat.Value, script.BaseLon.Value)
spawn(function() --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    while true do
        u2:RefreshNearestTile()
        u2:RefreshCamVel()
        wait(0.1)
    end
end)
local u3 = {
    ["UnloadThreads"] = {},
    ["DataThreads"] = {},
    ["BuildThreads"] = {},
    ["UpdateLODThreads"] = {}
}
function UpdateProcess(p4, p5, p6, p7)
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if not u3[p4][p5] then
        u3[p4][p5] = {}
    end
    u3[p4][p5][p6] = p7
    u2.ProcessesStopped = true
    for _, v8 in pairs(u3) do
        for _, v9 in pairs(v8) do
            for _, v10 in pairs(v9) do
                if v10 == true then
                    u2.ProcessesStopped = false
                end
            end
        end
    end
end
local v11 = {
    ["Terrain"] = { 12 },
    ["Roads"] = { 14 },
    ["Buildings"] = { 14 },
    ["Airports"] = { 14 },
    ["Earth"] = { 12 },
    ["POIs"] = { 14 }
}
local v12 = {
    ["Terrain"] = { 12 },
    ["Roads"] = { 14 },
    ["Buildings"] = { 14 },
    ["Airports"] = { 14 },
    ["Earth"] = { 12 }
}
local v13 = {
    ["Terrain"] = { 12, 12, 12 }
}
for u14, u15 in pairs({
    ["Terrain"] = { 12 },
    ["Roads"] = { 14 },
    ["Buildings"] = { 14 },
    ["Airports"] = { 14 },
    ["POIs"] = { 14 }
}) do
    for u16 = 1, #u15 do
        spawn(function() --[[ Line: 174 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u14
                [3] = u15
                [4] = u16
            --]]
            while true do
                while true do
                    wait()
                    if u2.Recentering == false then
                        break
                    end
                    UpdateProcess("UnloadThreads", u14, u15[u16], false)
                    wait()
                end
                UpdateProcess("UnloadThreads", u14, u15[u16], true)
                local v17, v18 = pcall(function() --[[ Line: 179 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u15
                        [3] = u16
                        [4] = u14
                    --]]
                    u2:UnloadType(u15[u16], u14)
                end)
                if not v17 then
                    warn("UnloadTypeFAIL", v18)
                    wait()
                end
            end
        end)
    end
end
for u19, u20 in pairs(v11) do
    for u21 = 1, #u20 do
        spawn(function() --[[ Line: 197 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u19
                [3] = u20
                [4] = u21
            --]]
            while true do
                while true do
                    wait()
                    if u2.Recentering == false then
                        break
                    end
                    UpdateProcess("DataThreads", u19, u20[u21], false)
                    wait()
                end
                UpdateProcess("DataThreads", u19, u20[u21], true)
                local v22, v23 = pcall(function() --[[ Line: 202 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u20
                        [3] = u21
                        [4] = u19
                    --]]
                    u2:GrabData(u20[u21], u19)
                end)
                if not v22 then
                    warn("GrabDataFAIL", v23)
                    wait()
                end
            end
        end)
    end
end
for u24, u25 in pairs(v12) do
    for u26 = 1, #u25 do
        spawn(function() --[[ Line: 220 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u24
                [3] = u25
                [4] = u26
            --]]
            while true do
                while true do
                    wait()
                    if u2.Recentering == false then
                        break
                    end
                    UpdateProcess("BuildThreads", u24, u25[u26], false)
                    wait()
                end
                UpdateProcess("BuildThreads", u24, u25[u26], true)
                u2:RefreshType(u25[u26], u24, false)
            end
        end)
    end
end
LODThreadHandler = { 2, 1, 1 }
for u27, u28 in pairs(v13) do
    for u29 = 1, #u28 do
        spawn(function() --[[ Line: 245 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u27
                [3] = u28
                [4] = u29
            --]]
            while true do
                while true do
                    wait()
                    if u2.Recentering == false then
                        break
                    end
                    UpdateProcess("UpdateLODThreads", u27, u28[u29], false)
                    wait()
                end
                UpdateProcess("UpdateLODThreads", u27, u28[u29], true)
                local v30, v31 = pcall(function() --[[ Line: 251 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u28
                        [3] = u29
                        [4] = u27
                    --]]
                    u2:RefreshType(u28[u29], u27, true, LODThreadHandler[u29])
                end)
                if not v30 then
                    warn("PCALLHALP2", v31)
                    wait()
                end
            end
        end)
    end
end
script.Teleport.Event:Connect(function(p32, p33) --[[ Line: 269 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2:Teleport(p32, p33)
end)