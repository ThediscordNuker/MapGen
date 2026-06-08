-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local u1 = game:GetService("HttpService")
local u2 = require(game.ReplicatedStorage.MapScripts.Tri)
local u3 = require(game.ReplicatedStorage.MapScripts.Tri2DNew)
local u4 = require(game.ReplicatedStorage.MapScripts.PolyNewNew)
local u5 = require(game.ReplicatedStorage.MapScripts.ConvertCoords)
local u6 = require(game.ReplicatedStorage.MapScripts.SplitPoly)
local u7 = require(game.ReplicatedStorage.PlayerStore)
local u8 = {}
u8.__index = u8
local u9 = game:GetService("RunService")
local u10 = CFrame.new()
function BlankData(p11)
    local v12 = {}
    for v13 = 1, #p11 do
        v12[p11[v13]] = {}
    end
    return v12
end
function Comma(p14)
    local v15, v16, v17 = string.match(p14, "^([^%d]*%d)(%d*)(.-)$")
    local v18 = v16 == nil and "" or v16
    local v19 = v17 == nil and "" or v17
    return (v15 == nil and "" or v15) .. v18:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v19
end
function CountTileTypes(p20, p21)
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v22 = {
        "Airports",
        "Roads",
        "Buildings",
        "Terrain",
        "Earth"
    }
    local v23 = 0
    local v24 = {}
    for v25 = 1, #v22 do
        local v26 = 0
        local v27 = 0
        for _, v28 in pairs(p20) do
            for _, v29 in pairs(v28) do
                if typeof(v29) == "table" and v29[v22[v25]] then
                    v26 = v26 + 1
                    v27 = v27 + #u1:JSONEncode(v29[v22[v25]])
                end
            end
        end
        v23 = v23 + v27
        v24[v22[v25]] = {
            ["DataAmmount"] = v27,
            ["Count"] = v26
        }
    end
    print("     ------ Count: ", p21, " ------")
    for v30, v31 in pairs(v24) do
        local v32 = print
        local v33 = Comma(v31.Count)
        local v34 = Comma(v31.DataAmmount)
        local v35 = v31.DataAmmount / v23 * 100
        v32("     TYPE:", v30, "COUNT:", v33, "DATA:", v34, "[" .. math.floor(v35) .. "%]")
    end
    print("     TOTAL DATA", Comma(v23))
    print("     ----------------------------")
end
function u8.new(p36, p37, p38) --[[ Line: 77 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
        [3] = u8
    --]]
    local v39, v40 = u5:ConvertLatLongToPixA(-p37, p38, 12)
    local v41, v42 = u5:ConvertLatLongToTile(-p37, p38, 12)
    local v43 = script.RecenterDisplay:Clone()
    v43.Parent = game.Players.LocalPlayer.PlayerGui
    while not u7.LoadedSettings do
        wait()
    end
    if game:GetService("RunService"):IsStudio() then
        u7.PlayerData.SettingsData.GraphicsProfiles[u7.PlayerData.SettingsData.CurrentGraphicsProfile].MaxLuaHeapMemory = 1000000
        u7:LoadSettings()
    end
    print("GridSize", 2621.4400000000005)
    local v44 = {
        ["Recentering"] = false,
        ["ProcessesStopped"] = false,
        ["Stopped"] = false,
        ["NearestTile"] = nil,
        ["LastPitch"] = 0,
        ["LastYaw"] = 0,
        ["UI"] = v43,
        ["Lat"] = tonumber(p37),
        ["Lon"] = tonumber(p38),
        ["TerrainOffsetX"] = (v41 - v39 / 512) * 2621.4400000000005 - 24,
        ["TerrainOffsetY"] = (v42 - v40 / 512) * 2621.4400000000005 - 24,
        ["NearestTiles"] = BlankData(p36),
        ["NearestCheckTiles"] = BlankData(p36),
        ["FetchingData"] = BlankData(p36),
        ["LoadingTiles"] = BlankData(p36),
        ["UnloadingTiles"] = BlankData(p36),
        ["NearestTerrainTiles"] = BlankData(p36),
        ["AirportsLoaded"] = {},
        ["LODTerrainMemory"] = {},
        ["EleTerrainMemory"] = {},
        ["TerrainLoaded"] = {},
        ["Tickers"] = {
            ["TerrainLoad"] = 0,
            ["TerrainUnload"] = 0,
            ["RoadsLoad"] = 0,
            ["RoadsUnload"] = 0,
            ["BuildingsLoad"] = 0,
            ["BuildingsUnload"] = 0,
            ["EarthLoad"] = 0,
            ["EarthUnload"] = 0,
            ["TerrainParts"] = 0,
            ["BuildingParts"] = 0,
            ["RoadParts"] = 0,
            ["TreeParts"] = 0,
            ["EarthParts"] = 0,
            ["MemTerrainTiles"] = 0,
            ["MemDetailsTiles"] = 0
        },
        ["ZoomLevels"] = p36,
        ["RenderSettings"] = u7.LoadedSettings.GraphicsSettings,
        ["Memory"] = BlankData(p36),
        ["MemoryLastUsed"] = BlankData(p36),
        ["TileModels"] = BlankData(p36),
        ["CamVel"] = Vector3.new(),
        ["AllBuildings"] = {},
        ["AllPOIs"] = {}
    }
    local v45 = u8
    local v46 = setmetatable(v44, v45)
    if v46.RenderSettings.PostProcessing ~= "On" then
        local _ = v46.RenderSettings.PostProcessing == "Off"
    end
    if v46.RenderSettings.GloalShadows ~= "On" then
        local _ = v46.RenderSettings.GloalShadows == "Off"
    end
    u8.CurrentMap = v46
    return v46
end
function LatLongToImagePos(p47, p48)
    local v49 = tonumber(p47) or 0
    local v50 = ((tonumber(p48) or 0) + 180) * 0.002777777777777778
    local v51 = 0.7853981633974483 + v49 * 3.141592653589793 / 180 / 2
    local v52 = math.tan(v51)
    local v53 = 0.5 - math.log(v52) * 1 / 6.283185307179586
    return UDim2.new(v50, 0, v53, 0)
end
function LatLongToWorldPos(p54, p55)
    local v56 = tonumber(p54) or 0
    local v57 = ((tonumber(p55) or 0) + 180) * 0.002777777777777778
    local v58 = 0.7853981633974483 + v56 * 3.141592653589793 / 180 / 2
    local v59 = math.tan(v58)
    return v57, 0.5 - math.log(v59) * 1 / 6.283185307179586
end
function ImagePosToLatLong(p60, p61)
    local v62 = p60 / 1 * 360 - 180
    local v63 = (p61 - 0.5) * 2 * 180 * 3.141592653589793 / 180
    local v64 = math.exp(v63)
    return v62, 57.29577951308232 * (math.atan(v64) * 2 - 1.5707963267948966)
end
function GetPlayerAircraft()
    local v65 = workspace.Aircraft:GetChildren()
    for v66 = 1, #v65 do
        if v65[v66].Stats.Owner.Value == game.Players.LocalPlayer then
            return v65[v66]
        end
    end
end
function u8.Recenter(p67) --[[ Line: 263 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    print("Recenter()")
    local v68 = GetPlayerAircraft()
    if p67.Recentering == false and v68 then
        p67.UI.Notify.Visible = true
        p67.UI.Notify.Size = UDim2.new(0, 0, 0, 40)
        p67.UI.Notify.ImageColor3 = Color3.fromRGB(220, 220, 100)
        p67.UI.Notify:TweenSize(UDim2.new(0, 200, 0, 40), 1, 4, 0.2, true)
        p67.UI.Notify.TextLabel.Text = "Preparing to recenter..."
        p67.Recentering = true
        wait(0.2)
        while not p67.ProcessesStopped do
            wait(0.2)
        end
        p67.UI.Notify.ImageColor3 = Color3.fromRGB(220, 100, 100)
        p67.UI.Notify.TextLabel.Text = "Recentering..."
        wait(0.2)
        local v69, v70 = LatLongToWorldPos(p67.Lat, p67.Lon)
        local v71 = v68.PrimaryPart.CFrame.p
        local v72, v73 = ImagePosToLatLong(v69 + v71.X / 10737418.24, v70 + v71.Z / 10737418.24)
        local v74 = -v73
        p67.Lat = tonumber(v74)
        p67.Lon = tonumber(v72)
        game.Players.LocalPlayer.PlayerScripts.MapClient.BaseLat.Value = -v73
        game.Players.LocalPlayer.PlayerScripts.MapClient.BaseLon.Value = v72
        local v75, v76 = u5:ConvertLatLongToPixA(v73, v72, 12)
        local v77, v78 = u5:ConvertLatLongToTile(v73, v72, 12)
        p67.TerrainOffsetX = (v77 - v75 / 512) * 2621.4400000000005 - 24
        p67.TerrainOffsetY = (v78 - v76 / 512) * 2621.4400000000005 - 24
        local _, _, _, v79, v80, v81, v82, v83, v84, v85, v86, v87 = v68.PrimaryPart.CFrame:components()
        local v88 = CFrame.new(0, v68.PrimaryPart.Position.Y, 0, v79, v80, v81, v82, v83, v84, v85, v86, v87)
        local v89 = v68.PrimaryPart.Velocity
        v68.PrimaryPart.Anchored = true
        local v90 = workspace.Map
        local v91 = CFrame.new
        local v92 = -v71.X
        local v93 = -v71.Z
        v90:SetPrimaryPartCFrame(v91((Vector3.new(v92, 0, v93))))
        v68:SetPrimaryPartCFrame(v88)
        local v94 = game.ReplicatedStorage.AircraftRemotes.RecenterUpdate
        local v95 = p67.Lat
        local v96 = tostring(v95)
        local v97 = p67.Lon
        v94:FireServer(v68, v96, (tostring(v97)))
        workspace.Map.PrimaryPart.CFrame = CFrame.new()
        v68.PrimaryPart.Velocity = v89
        v68.PrimaryPart.Anchored = false
        p67.UI.Notify.ImageColor3 = Color3.fromRGB(100, 220, 100)
        p67.UI.Notify.TextLabel.Text = "Recovering..."
        wait(5)
        p67.UI.Notify:TweenSize(UDim2.new(0, 0, 0, 40), 1, 4, 0.2, true)
        wait(0.2)
        p67.UI.Notify.Visible = false
        p67.Recentering = false
    end
end
function u8.Reset(p98) --[[ Line: 346 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    p98.Stopped = true
    if game:GetService("RunService"):IsStudio() then
        u7.PlayerData.SettingsData.GraphicsProfiles[u7.PlayerData.SettingsData.CurrentGraphicsProfile].MaxLuaHeapMemory = 1000000
        u7:LoadSettings()
    end
    p98.RenderSettings = u7.LoadedSettings.GraphicsSettings
    if p98.RenderSettings.PostProcessing ~= "On" then
        local _ = p98.RenderSettings.PostProcessing == "Off"
    end
    if p98.RenderSettings.GloalShadows ~= "On" then
        local _ = p98.RenderSettings.GloalShadows == "Off"
    end
    local v99 = workspace.Map:GetChildren()
    for v100 = 1, #v99 do
        if v99[v100].Name ~= "Terrain" and v99[v100].Name ~= "Mover" then
            v99[v100]:Destroy()
        end
    end
    local v101 = workspace.MapBuffers:GetChildren()
    for v102 = 1, #v101 do
        if v101[v102].Name == "Buffer" then
            v101[v102]:Destroy()
        end
    end
    local v103 = workspace.Map.Terrain:GetChildren()
    for v104 = 1, #v103 do
        v103[v104]:Destroy()
    end
    p98.Memory = BlankData(p98.ZoomLevels)
    p98.MemoryLastUsed = BlankData(p98.ZoomLevels)
    p98.FetchingData = BlankData(p98.ZoomLevels)
    p98.LoadingTiles = BlankData(p98.ZoomLevels)
    p98.UnloadingTiles = BlankData(p98.ZoomLevels)
    p98.LODTerrainMemory = {}
    p98.AirportsLoaded = {}
    p98.EleTerrainMemory = {}
    p98.TerrainLoaded = {}
    p98.AllBuildings = {}
    p98.AllPOIs = {}
    p98.TileModels = BlankData(p98.ZoomLevels)
    wait(1)
    p98.Tickers = {
        ["TerrainLoad"] = 0,
        ["TerrainUnload"] = 0,
        ["RoadsLoad"] = 0,
        ["RoadsUnload"] = 0,
        ["BuildingsLoad"] = 0,
        ["BuildingsUnload"] = 0,
        ["EarthLoad"] = 0,
        ["EarthUnload"] = 0,
        ["TerrainParts"] = 0,
        ["BuildingParts"] = 0,
        ["RoadParts"] = 0,
        ["TreeParts"] = 0,
        ["EarthParts"] = 0,
        ["MemDetailsTiles"] = 0,
        ["MemTerrainTiles"] = 0
    }
    p98.Stopped = false
end
function u8.Teleport(p105, p106, p107) --[[ Line: 426 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    warn("Teleport", p106, p107)
    if p105.Recentering == false then
        game.Players.LocalPlayer.PlayerScripts.MapClient.BaseLat.Value = p106
        game.Players.LocalPlayer.PlayerScripts.MapClient.BaseLon.Value = p107
        p105.Recentering = true
        p105.Lat = tonumber(p106)
        p105.Lon = tonumber(p107)
        local v108, v109 = u5:ConvertLatLongToPixA(-p106, p107, 12)
        local v110, v111 = u5:ConvertLatLongToTile(-p106, p107, 12)
        p105.TerrainOffsetX = (v110 - v108 / 512) * 2621.4400000000005 - 24
        p105.TerrainOffsetY = (v111 - v109 / 512) * 2621.4400000000005 - 24
        local v112 = GetPlayerAircraft()
        if v112 then
            local _, _, _, v113, v114, v115, v116, v117, v118, v119, v120, v121 = v112.PrimaryPart.CFrame:components()
            local v122 = CFrame.new(0, v112.PrimaryPart.Position.Y, 0, v113, v114, v115, v116, v117, v118, v119, v120, v121)
            local v123 = v112.PrimaryPart.Velocity
            v112.PrimaryPart.Anchored = true
            v112:SetPrimaryPartCFrame(v122)
            local v124 = game.ReplicatedStorage.AircraftRemotes.RecenterUpdate
            local v125 = p105.Lat
            local v126 = tostring(v125)
            local v127 = p105.Lon
            v124:FireServer(v112, v126, tostring(v127), true)
            wait(0.1)
            v112.PrimaryPart.Velocity = v123
            v112.PrimaryPart.Anchored = false
        end
        p105:Reset()
        p105.Recentering = false
    end
end
function u8.RefreshNearestTile(p128) --[[ Line: 467 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v129 = workspace.CurrentCamera.CFrame
    local _ = p128.Recentering == true
    local _, _, _, _, _, v130, _, _, v131, _, _, v132 = v129:components()
    local v133 = math.atan2(v130, v132)
    local v134 = -math.deg(v133) - 90
    local v135 = -v131
    local v136 = math.asin(v135)
    local v137 = math.deg(v136)
    local v138 = (p128.LastYaw + 180 - v134) % 360 - 180
    local v139 = math.abs(v138)
    local v140 = v129.p
    local v141 = p128.TerrainOffsetX * 1
    local v142 = p128.TerrainOffsetY * 1
    local v143 = v140 - Vector3.new(v141, 0, v142) + p128.CamVel
    local v144, v145 = u5:ConvertLatLongToTile(-p128.Lat, p128.Lon, 12)
    local v146 = Vector2.new
    local v147 = v143.X / 2621.4400000000005
    local v148 = v144 + math.floor(v147)
    local v149 = v143.Z / 2621.4400000000005
    local v150 = v146(v148, v145 + math.floor(v149))
    if v150 ~= p128.NearestTile or v139 > 20 then
        p128.LastYaw = v134
        p128.LastPitch = v137
        for v151 = 1, #p128.ZoomLevels do
            p128:GetViewportTiles(p128.ZoomLevels[v151])
        end
        p128.NearestTile = v150
    end
end
function CheckSquare(p152)
    local v153 = (Vector2.new(p152[1].x, p152[1].y) - Vector2.new(p152[2].x, p152[2].y)).magnitude
    local v154 = (Vector2.new(p152[2].x, p152[2].y) - Vector2.new(p152[3].x, p152[3].y)).magnitude
    local v155 = (Vector2.new(p152[3].x, p152[3].y) - Vector2.new(p152[4].x, p152[4].y)).magnitude
    local v156 = (Vector2.new(p152[4].x, p152[4].y) - Vector2.new(p152[1].x, p152[1].y)).magnitude
    return math.min(v153, v154, v155, v156) / math.max(v153, v154, v155, v156) > 0.9
end
function PartBuilding(p157, p158, p159, p160, p161, p162, p163, p164, p165)
    if p161 == 0 then
        local v166 = 0.4
        local v167 = script.FlatPlane:Clone()
        v167.Transparency = 0
        local v168 = (Vector2.new(p157[1].x, p157[1].y) - Vector2.new(p157[2].x, p157[2].y)).magnitude
        v167.Size = Vector3.new(v166, v168, v168)
        v167.Color = p159
        local v169 = (p157[1].x + p157[2].x + p157[3].x + p157[4].x) / 4
        local v170 = p158 + v166 / 2
        local v171 = (p157[1].y + p157[2].y + p157[3].y + p157[4].y) / 4
        local v172 = Vector3.new(v169, v170, v171)
        local v173 = CFrame.new(v172)
        local v174 = CFrame.Angles
        local v175 = p157[1].x - p157[2].x
        local v176 = p157[1].y - p157[2].y
        v167.CFrame = v173 * v174(0, math.atan2(v175, v176), 0) * CFrame.Angles(0, 0, 1.5707963267948966)
        if p163 ~= Enum.Material.Grass then
            v167.Material = p163
        end
        v167.Parent = p160
    else
        local v177 = script.Grass:Clone()
        if p163 ~= Enum.Material.Grass then
            v177.Material = p163
        end
        local v178 = (Vector2.new(p157[1].x, p157[1].y) - Vector2.new(p157[2].x, p157[2].y)).magnitude
        local v179 = p161 + 10
        v177.Size = Vector3.new(v178, v179, v178)
        v177.Color = p159
        local v180 = (p157[1].x + p157[2].x + p157[3].x + p157[4].x) / 4
        local v181 = p158 + p161 / 2 - 5
        local v182 = (p157[1].y + p157[2].y + p157[3].y + p157[4].y) / 4
        local v183 = Vector3.new(v180, v181, v182)
        local v184 = CFrame.new(v183)
        local v185 = CFrame.Angles
        local v186 = p157[1].x - p157[2].x
        local v187 = p157[1].y - p157[2].y
        v177.CFrame = v184 * v185(0, math.atan2(v186, v187), 0)
        if p162 then
            v177.CastShadow = true
        end
        if p164 then
            v177.Transparency = 1
            local v188 = p164:Clone()
            v188.Parent = v177
            v188.Face = Enum.NormalId.Left
            local v189 = p164:Clone()
            v189.Parent = v177
            v189.Face = Enum.NormalId.Right
            local v190 = p164:Clone()
            v190.Parent = v177
            v190.Face = Enum.NormalId.Front
            local v191 = p164:Clone()
            v191.Parent = v177
            v191.Face = Enum.NormalId.Back
        end
        if p165 then
            local v192 = p165:Clone()
            v192.Parent = v177
            v192.Face = Enum.NormalId.Top
        end
        v177.Parent = p160
    end
end
function FindEdge(p193, p194, p195, p196, p197)
    for v198 = 1, #p197 - 1 do
        if p193 == p197[v198].x and (p194 == p197[v198].y and (p195 == p197[v198 + 1].x and p196 == p197[v198 + 1].y)) then
            return true
        end
        if p195 == p197[v198].x and (p196 == p197[v198].y and (p193 == p197[v198 + 1].x and p194 == p197[v198 + 1].y)) then
            return true
        end
    end
    return p193 == p197[#p197].x and (p194 == p197[#p197].y and (p195 == p197[1].x and p196 == p197[1].y)) and true or p195 == p197[#p197].x and (p196 == p197[#p197].y and (p193 == p197[1].x and p194 == p197[1].y))
end
function CreateFlatSide(p199, p200, p201, p202, p203, p204, p205, p206)
    local v207 = (p199 - p200).magnitude
    local v208 = script.FlatPlane:Clone()
    local v209 = p201 + 10
    v208.Size = Vector3.new(1, v209, v207)
    local v210 = CFrame.new
    local v211 = p199.x
    local v212 = p202 + p201 / 2 - 5
    local v213 = p199.y
    local v214 = Vector3.new(v211, v212, v213)
    local v215 = p200.x
    local v216 = p202 + p201 / 2 - 5
    local v217 = p200.y
    v208.CFrame = v210(v214, (Vector3.new(v215, v216, v217))) * CFrame.new(0, 0, -v207 / 2) * CFrame.new(-0.5, 0, 0)
    v208.Color = p205
    if p206 ~= Enum.Material.Grass then
        v208.Material = p206
    end
    if p204 then
        local v218 = p204:Clone()
        v218.Face = Enum.NormalId.Right
        v218.Parent = v208
    else
        v208.Transparency = 0
    end
    v208.Parent = p203
end
function u8.ShiftTerrainColor(p219, p220) --[[ Line: 623 ]]
    local v221, v222, v223 = p220:ToHSV()
    if p219.RenderSettings.TerrainTextures == "Off" then
        v223 = v223 - 0.1
    end
    local v224 = Color3.fromHSV
    local v225 = (v221 + 0.05 + p219.RenderSettings.TerrainHueShift / 100) % 1
    local v226 = math.clamp(v225, 0, 1)
    local v227 = v222 + 0.2 + p219.RenderSettings.TerrainSaturationShift / 100
    local v228 = math.clamp(v227, 0, 1)
    local v229 = v223 - 0.05 + p219.RenderSettings.TerrainBrightnessShift / 100
    return v224(v226, v228, (math.clamp(v229, 0, 1)))
end
function u8.CreatePolygon(u230, p231, p232, p233, u234, u235, u236, u237, p238, _, p239, p240, p241, u242, u243) --[[ Line: 635 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u10
        [3] = u9
        [4] = u4
    --]]
    debug.profilebegin("CreatePolygon")
    local v244 = (p232 or 0) * 0.3328
    if not p241 then
        local v245 = LaserDownAtTerrain
        local v246 = p231[1][1]
        local v247 = tonumber(v246)
        local v248 = p231[1][2]
        local v249 = tonumber(v248)
        p241 = v245(Vector3.new(v247, 0, v249), p239, p240)
    end
    local u250 = v244 + p241
    local u251 = p233 or 4
    if u234 == "Building" then
        u251 = u251 + math.random(-100, 100) / 100
    end
    local v252 = FixTable(p231)
    local u253 = {}
    for v254 = 1, #v252 do
        local v255 = {}
        local v256 = v252[v254][1]
        v255.x = tonumber(v256)
        local v257 = v252[v254][2]
        v255.y = tonumber(v257)
        table.insert(u253, v255)
    end
    BParts = 0
    if #u253 >= 3 then
        if #u253 == 3 then
            local v258 = Instance.new("Model")
            v258.Name = u234
            if u234 == "Earth" then
                u236 = u230:ShiftTerrainColor(u236)
            end
            local v259 = u3:Triangle((u10 * CFrame.new(u253[1].x, u250, u253[1].y)).p, (u10 * CFrame.new(u253[2].x, u250, u253[2].y)).p, (u10 * CFrame.new(u253[3].x, u250, u253[3].y)).p, u236, v258, u251 * 0.3328, u237, u243)
            if u234 == "Earth" then
                u230.Tickers.EarthParts = u230.Tickers.EarthParts + v259
                u230.Tickers.EarthLoad = u230.Tickers.EarthLoad + 1
                if u230.Tickers.EarthLoad > u230.RenderSettings.LoadSpeedEarth then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("CreatePolygon")
                    u230.Tickers.EarthLoad = 0
                end
            else
                if u234 == "Building" then
                    BParts = BParts + v259
                    u230.Tickers.BuildingParts = u230.Tickers.BuildingParts + v259
                end
                u230.Tickers.BuildingsLoad = u230.Tickers.BuildingsLoad + 1
                if u230.Tickers.BuildingsLoad > u230.RenderSettings.LoadSpeedBuildings then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("CreatePolygon")
                    u230.Tickers.BuildingsLoad = 0
                end
            end
            v258.Parent = u235
        elseif #u253 == 4 and CheckSquare(u253) then
            local v260 = Instance.new("Model")
            v260.Name = u234
            if u234 == "Earth" then
                u236 = u230:ShiftTerrainColor(u236)
            end
            PartBuilding(u253, u250, u236, v260, u251 * 0.3328, p238, u237, u242, u243)
            v260.Parent = u235
            if u234 == "Earth" then
                u230.Tickers.EarthParts = u230.Tickers.EarthParts + 1
                u230.Tickers.EarthLoad = u230.Tickers.EarthLoad + 1
                if u230.Tickers.EarthLoad > u230.RenderSettings.LoadSpeedEarth then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("CreatePolygon")
                    u230.Tickers.EarthLoad = 0
                end
            else
                if u234 == "Building" then
                    BParts = BParts + 1
                    u230.Tickers.BuildingParts = u230.Tickers.BuildingParts + 1
                end
                u230.Tickers.BuildingsLoad = u230.Tickers.BuildingsLoad + 1
                if u230.Tickers.BuildingsLoad > u230.RenderSettings.LoadSpeedBuildings then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("CreatePolygon")
                    u230.Tickers.BuildingsLoad = 0
                end
            end
        elseif #u253 >= 4 then
            local v277, v278 = pcall(function() --[[ Line: 746 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u253
                    [3] = u234
                    [4] = u251
                    [5] = u250
                    [6] = u242
                    [7] = u236
                    [8] = u237
                    [9] = u230
                    [10] = u3
                    [11] = u10
                    [12] = u243
                    [13] = u9
                    [14] = u235
                --]]
                local v261 = {
                    ["poly"] = u4()
                }
                for v262 = 1, #u253 do
                    v261.poly:push_coord(u253[v262].x, u253[v262].y)
                end
                v261.poly:close()
                v261.triangles = v261.poly:get_triangles()
                if v261.triangles then
                    local v263 = Instance.new("Model")
                    v263.Name = u234
                    for _, v264 in ipairs(v261.triangles) do
                        local v265, v266 = v261.poly:get_coord(v264[1])
                        local v267, v268 = v261.poly:get_coord(v264[2])
                        local v269, v270 = v261.poly:get_coord(v264[3])
                        local v271 = FindEdge(v265, v266, v267, v268, u253)
                        local v272 = FindEdge(v267, v268, v269, v270, u253)
                        local v273 = FindEdge(v269, v270, v265, v266, u253)
                        local v274 = 0
                        if v271 and u251 > 0 then
                            CreateFlatSide(Vector2.new(v265, v266), Vector2.new(v267, v268), u251 * 0.3328, u250, v263, u242, u236, u237)
                            v274 = v274 + 1
                        end
                        if v272 and u251 > 0 then
                            CreateFlatSide(Vector2.new(v267, v268), Vector2.new(v269, v270), u251 * 0.3328, u250, v263, u242, u236, u237)
                            v274 = v274 + 1
                        end
                        if v273 and u251 > 0 then
                            CreateFlatSide(Vector2.new(v269, v270), Vector2.new(v265, v266), u251 * 0.3328, u250, v263, u242, u236, u237)
                            v274 = v274 + 1
                        end
                        local v275 = u236
                        if u234 == "Earth" then
                            v275 = u230:ShiftTerrainColor(u236)
                        end
                        local v276 = u3:Triangle((u10 * CFrame.new(v265, u250, v266)).p, (u10 * CFrame.new(v267, u250, v268)).p, (u10 * CFrame.new(v269, u250, v270)).p, v275, v263, u251 * 0.3328, u237, u243) + v274
                        if u234 == "Earth" then
                            u230.Tickers.EarthParts = u230.Tickers.EarthParts + v276
                            u230.Tickers.EarthLoad = u230.Tickers.EarthLoad + 1
                            if u230.Tickers.EarthLoad > u230.RenderSettings.LoadSpeedEarth then
                                debug.profileend()
                                u9.Stepped:wait()
                                debug.profilebegin("CreatePolygon")
                                u230.Tickers.EarthLoad = 0
                            end
                        else
                            u230.Tickers.BuildingsLoad = u230.Tickers.BuildingsLoad + 1
                            if u234 == "Building" then
                                BParts = BParts + v276
                                u230.Tickers.BuildingParts = u230.Tickers.BuildingParts + v276
                            end
                            if u230.Tickers.BuildingsLoad > u230.RenderSettings.LoadSpeedBuildings then
                                debug.profileend()
                                u9.Stepped:wait()
                                debug.profilebegin("CreatePolygon")
                                u230.Tickers.BuildingsLoad = 0
                            end
                        end
                    end
                    v263.Parent = u235
                end
                v261.poly = nil
            end)
            if v277 == false and u234 == "Earth" then
                warn("OOOOF", v277, v278)
            end
        end
    end
    debug.profileend()
    return BParts
end
function CreateGUID(p279)
    local v280 = "N" .. math.random(1, 100000)
    while p279[v280] ~= nil do
        v280 = "N" .. math.random(1, 100000)
    end
    return v280
end
local u281 = 0
function u8.CheckAllBuildings(p282, p283) --[[ Line: 853 ]]
    --[[
    Upvalues:
        [1] = u281
        [2] = u9
    --]]
    debug.profilebegin("CheckAllBuildings")
    for _, v284 in pairs(p282.AllBuildings) do
        u281 = u281 + 1
        if u281 % 8000 == 0 then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("CheckAllBuildings")
        end
        if v284[1][1] == p283[1][1] and v284[1][2] == p283[1][2] or v284[#v284][1] == p283[1][1] and v284[#v284][2] == p283[1][2] then
            debug.profileend()
            return false
        end
    end
    debug.profileend()
    return true
end
function u8.BuildBuildings(p285, p286, p287, p288, p289, p290) --[[ Line: 882 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v291, v292 = u5:ConvertLatLongToPix(p285.Lat, p285.Lon, p288)
    local v293 = Vector2.new(v291, v292)
    local v294 = 0
    local v295 = p286.Buildings
    debug.profilebegin("BuildBuildings")
    if v295 and #v295 > 0 then
        for v296 = 1, #v295 do
            if v295[v296] and v295[v296].p then
                local v297 = v295[v296].g
                local v298 = (p285.RenderSettings.BuildingShadows == "Only Tall" and (v295[v296].p.h and v295[v296].p.h > 50) or p285.RenderSettings.BuildingShadows == "All") and true or false
                local v299 = Instance.new("Model")
                debug.profileend()
                local v300 = 0
                for v301 = 1, #v297 do
                    local v302 = v297[v301]
                    for v303 = 1, #v302 do
                        local v304 = {}
                        local v305 = ((v302[v303][1] + p286.LowestX) / 10 - v293.X) * 0.32 * 100
                        local v306 = math.floor(v305) / 100
                        local v307 = ((v302[v303][2] + p286.LowestY) / 10 - v293.Y) * -0.32 * 100
                        __set_list(v304, 1, {v306, math.floor(v307) / 100})
                        v302[v303] = v304
                    end
                    if p285:CheckAllBuildings(v302) and v294 < p285.RenderSettings.MaxBuildingPartsPerTile then
                        local _ = #v302 > 10
                        local v308 = CreateGUID(p285.AllBuildings)
                        p285.AllBuildings[v308] = v302
                        local v309, v310
                        if p285.RenderSettings.BuildingTextures == "Off" then
                            v309 = nil
                            v310 = nil
                        else
                            local v311 = script.BuildingTextures:GetChildren()
                            v309 = v311[math.random(1, #v311)]
                            v309.Color3 = Color3.fromHSV(math.random(0, 100) / 100, math.random(0, 5) / 100, math.random(40, 100) / 100)
                            local v312 = script.RoofTextures:GetChildren()
                            v310 = v312[math.random(1, #v312)]
                            v310.Color3 = Color3.fromHSV(math.random(0, 100) / 100, math.random(0, 5) / 100, math.random(40, 100) / 100)
                        end
                        local v313 = Color3.fromHSV(math.random(0, 100) / 100, 0.1, math.random(20, 75) / 100)
                        if v295[v296].p.h and v295[v296].p.h > 50 then
                            v313 = Color3.fromRGB(100, 100, 140)
                        end
                        v294 = v294 + p285:CreatePolygon(v302, v295[v296].p.mh, v295[v296].p.h, "Building", v299, v313, Enum.Material.SmoothPlastic, v298, p288, p289, p290, nil, v309, v310)
                        v300 = v300 + 1
                        if v300 % 10 == 0 then
                            debug.profilebegin("NewChunk_Buildings")
                            v299.Parent = p287
                            debug.profileend()
                            v299 = Instance.new("Model")
                        end
                    end
                end
                debug.profilebegin("BuildBuildings")
                debug.profilebegin("NewChunk_Buildings")
                v299.Parent = p287
                debug.profileend()
            end
        end
    end
    debug.profileend()
end
function FixTable(p314)
    for v315 = 1, #p314 do
        for v316 = 1, #p314 do
            if p314[v315] and (p314[v316] and ((Vector2.new(p314[v315][1], p314[v315][2]) - Vector2.new(p314[v316][1], p314[v316][2])).magnitude == 0 and v315 ~= v316)) then
                table.remove(p314, (math.min(v315, v316)))
                return p314
            end
        end
    end
    return p314
end
function FixTbl(p317)
    local v318 = {}
    for v319 = 1, #p317 do
        v318[v319] = { p317[v319].x, p317[v319].y }
    end
    return v318
end
function SideOfLine(p320, p321, p322)
    local v323 = (p321.x - p320.x) * (p322.Y - p320.y) - (p321.y - p320.y) * (p322.X - p320.x)
    return math.sign(v323)
end
function DoPolygonSlices(p324, p325, p326, p327)
    local v328 = {}
    if p327 then
        v328 = p324
    else
        for v329 = 1, #p324 do
            v328[v329] = FixTbl(p324[v329])
        end
    end
    local v330 = {}
    local v331 = {}
    for v332 = 1, #v328 do
        local v333 = Vector2.new()
        for v334 = 1, #v328[v332] do
            v333 = v333 + Vector2.new(v328[v332][v334][1], v328[v332][v334][2])
        end
        local v335 = v333 / #v328[v332]
        if SideOfLine(p325, p326, v335) == -1 then
            local v336 = v328[v332]
            table.insert(v331, v336)
        else
            local v337 = v328[v332]
            table.insert(v330, v337)
        end
    end
    return v330, v331
end
local u338 = 0
function u8.DoPolygon(p339, p340, p341, p342, p343, p344, p345, p346, p347) --[[ Line: 1056 ]]
    --[[
    Upvalues:
        [1] = u338
        [2] = u9
    --]]
    local v348 = {}
    if p347 then
        v348 = p340
    else
        for v349 = 1, #p340 do
            v348[v349] = FixTbl(p340[v349])
        end
    end
    local v350 = {}
    for v351 = 1, #v348 do
        local v352 = Vector2.new()
        for v353 = 1, #v348[v351] do
            v352 = v352 + Vector2.new(v348[v351][v353][1], v348[v351][v353][2])
        end
        local v354 = v352 / #v348[v351]
        if SideOfLine(p341, p342, v354) == 1 then
            local v355 = v348[v351]
            table.insert(v350, v355)
        elseif RecreateElement2(p345, p346, 1) < 30 then
            local v356 = Enum.Material.Grass
            if p339.RenderSettings.TerrainTextures == "Off" then
                v356 = Enum.Material.SmoothPlastic
            end
            p339:CreatePolygon(v348[v351], nil, 0, "Earth", p343, Color3.fromRGB(RecreateElement2(p345, p346, 2), RecreateElement2(p345, p346, 3), RecreateElement2(p345, p346, 4)), v356, false, p344, nil, nil, -0.1)
        else
            u338 = u338 + 1
            if u338 % 50 == 0 then
                u338 = 0
                u9.Stepped:wait()
            end
        end
    end
    return v350
end
function DrawRoad2(p357, p358)
    local v359 = (p357 - p358).magnitude
    Instance.new("Part").Anchored = true
    local v360 = script.Road2:Clone()
    v360.Size = Vector3.new(0.6, 0.1, v359)
    local v361 = CFrame.new
    local v362 = p357.x
    local v363 = p357.y
    local v364 = Vector3.new(v362, 0, v363)
    local v365 = p358.x
    local v366 = p358.y
    v360.CFrame = v361(v364, (Vector3.new(v365, 0, v366))) * CFrame.new(0, 0, -v359 / 2)
    v360.Parent = workspace.Debug
end
function u8.DoHorSlices(p367, p368, p369, p370, p371, p372, p373) --[[ Line: 1109 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    for v374 = 1, #p369 do
        local v375 = (p373 - 1) * 64 + v374
        local v376 = Vector2.new(p369[v374][1], p369[v374][2])
        local v377 = Vector2.new(p369[v374][3], p369[v374][4])
        local v378 = {}
        for v379 = 1, #p368 do
            local v380 = u6:dissect(p368[v379], v376, v377)
            if #v380 > 0 then
                local v381 = p367:DoPolygon(v380, v376, v377, p370, p371, p372, v375)
                for v382 = 1, #v381 do
                    local v383 = v381[v382]
                    table.insert(v378, v383)
                end
            else
                local v384 = p367:DoPolygon({ p368[v379] }, v376, v377, p370, p371, p372, v375, true)
                for v385 = 1, #v384 do
                    local v386 = v384[v385]
                    table.insert(v378, v386)
                end
            end
        end
        if #v378 > 0 then
            p368 = v378
        else
            p368 = {}
        end
    end
end
function u8.BuildEarth(p387, p388, p389, p390, p391) --[[ Line: 1142 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
    --]]
    local v392 = p388.Earth
    local v393 = string.split(p390, "_")
    local v394 = math.pow(2, p391) / 4096
    local v395, v396 = u5:ConvertLatLongToPix(p387.Lat, p387.Lon, p391)
    local v397 = Vector2.new(v395, v396)
    local v398 = v393[1] / v394
    local v399 = math.floor(v398)
    local v400 = v393[2] / v394
    local v401 = v399 .. "_" .. math.floor(v400)
    local v402 = RecreateTile(p387.Memory[12][v401].Terrain)
    local v403 = {}
    for v404 = 1, 64 do
        for v405 = 1, 64 do
            local v406 = RecreateElement2
            local v407 = (v405 - 1) * 64 + v404
            table.insert(v403, v406(v402, v407, 1))
            local v408 = RecreateElement2
            local v409 = (v405 - 1) * 64 + v404
            table.insert(v403, v408(v402, v409, 2))
            local v410 = RecreateElement2
            local v411 = (v405 - 1) * 64 + v404
            table.insert(v403, v410(v402, v411, 3))
            local v412 = RecreateElement2
            local v413 = (v405 - 1) * 64 + v404
            table.insert(v403, v412(v402, v413, 4))
        end
    end
    if v392 and #v392 > 0 then
        for v414 = 1, #v392 do
            if v392[v414] and v392[v414].p then
                local _ = v392[v414].p.i
                local v415 = {}
                for v416 = 1, #v392[v414].g do
                    local v417 = {}
                    for v418 = 1, #v392[v414].g[v416] do
                        local v419 = { ((v392[v414].g[v416][v418][1] + p388.LowestX) / 10 - v397.X) * 0.32, ((v392[v414].g[v416][v418][2] + p388.LowestY) / 10 - v397.Y) * -0.32 }
                        table.insert(v417, v419)
                    end
                    table.insert(v415, v417)
                end
                local v420, v421 = u5:ConvertLatLongToTile(-p387.Lat, p387.Lon, p391)
                local v422 = (v393[1] - v420) * 2621.4400000000005 + 1310.7200000000003
                local v423 = (v393[2] - v421) * 2621.4400000000005 + 1310.7200000000003
                local v424 = Vector3.new(v422, 10, v423)
                local v425 = p387.TerrainOffsetX / 40.96000000000001
                local v426 = math.floor(v425) * 40.96000000000001
                local v427 = p387.TerrainOffsetY / 40.96000000000001
                local v428 = math.floor(v427) * 40.96000000000001
                local v429 = v424 + Vector3.new(v426, 0, v428)
                local v430 = v429.X
                local v431 = v429.Z
                local v432 = (v430 - p387.TerrainOffsetX) / 40.96000000000001
                local v433 = math.floor(v432) * 40.96000000000001 + p387.TerrainOffsetX
                local v434 = (v431 - p387.TerrainOffsetY) / 40.96000000000001
                local v435 = math.floor(v434) * 40.96000000000001 + p387.TerrainOffsetY
                local v436 = Vector3.new(v433, 0, v435)
                local v437 = {}
                for v438 = -30, 33 do
                    local v439 = v438 * 40.96000000000001
                    local v440 = v436 + Vector3.new(v439, 0, -2631.4400000000005)
                    local v441 = v438 * 40.96000000000001
                    local v442 = v436 + Vector3.new(v441, 0, 2631.4400000000005)
                    local v443 = {
                        v440.X,
                        v440.Z,
                        v442.X,
                        v442.Z
                    }
                    table.insert(v437, v443)
                end
                local v444 = {}
                for v445 = -30, 33 do
                    local v446 = v445 * 40.96000000000001
                    local v447 = v436 + Vector3.new(-2631.4400000000005, 0, v446)
                    local v448 = v445 * 40.96000000000001
                    local v449 = v436 + Vector3.new(2631.4400000000005, 0, v448)
                    local v450 = {
                        v447.X,
                        v447.Z,
                        v449.X,
                        v449.Z
                    }
                    table.insert(v444, v450)
                end
                for v451 = 1, #v437 do
                    local v452 = Vector2.new(v437[v451][1], v437[v451][2])
                    local v453 = Vector2.new(v437[v451][3], v437[v451][4])
                    local v454 = {}
                    for v455 = 1, #v415 do
                        local v456 = u6:dissect(v415[v455], v452, v453)
                        if #v456 > 0 then
                            local v457, v458 = DoPolygonSlices(v456, v452, v453)
                            for v459 = 1, #v457 do
                                p387:DoHorSlices({ v457[v459] }, v444, p389, p391, v403, v451)
                            end
                            if #v458 > 0 then
                                for v460 = 1, #v458 do
                                    local v461 = v458[v460]
                                    table.insert(v454, v461)
                                end
                            end
                        else
                            local v462, v463 = DoPolygonSlices({ v415[v455] }, v452, v453, true)
                            for v464 = 1, #v462 do
                                p387:DoHorSlices({ v462[v464] }, v444, p389, p391, v403, v451)
                            end
                            if #v463 > 0 then
                                for v465 = 1, #v463 do
                                    local v466 = v463[v465]
                                    table.insert(v454, v466)
                                end
                            end
                        end
                    end
                    if #v454 > 0 then
                        v415 = v454
                    else
                        v415 = {}
                    end
                end
            end
        end
    end
end
function findIntersection(p467, p468, p469, p470, p471, p472, p473, p474)
    return ((p467 * p470 - p468 * p469) * (p471 - p473) - (p467 - p469) * (p471 * p474 - p472 * p473)) / ((p467 - p469) * (p472 - p474) - (p468 - p470) * (p471 - p473)), ((p467 * p470 - p468 * p469) * (p472 - p474) - (p468 - p470) * (p471 * p474 - p472 * p473)) / ((p467 - p469) * (p472 - p474) - (p468 - p470) * (p471 - p473))
end
function LaserDownAtTerrain(p475, p476, p477)
    local v478 = (p477 - p476) * 0.3328 + 1
    local v479 = math.min(v478, 1000)
    local v480 = p475.X + 0.06
    local v481 = p477 * 0.3328
    local v482 = p475.Z + 0.06
    local v483 = Vector3.new(v480, v481, v482)
    local v484 = Ray.new
    local v485 = -v479
    local v486 = v484(v483, (Vector3.new(0, v485, 0)))
    local v487, v488, _ = workspace:FindPartOnRayWithWhitelist(v486, { workspace.Map.Terrain })
    if not (v487 and v488) then
        return 0.3
    end
    local v489 = v488.Y
    return math.max(v489, 1), v487.Color
end
function u8.ReturnGridIntersections(p490, p491, p492, p493, p494) --[[ Line: 1310 ]]
    local v495 = p491.X
    local v496 = p492.X
    local v497 = math.min(v495, v496)
    local v498 = p491.Z
    local v499 = p492.Z
    local v500 = math.min(v498, v499)
    local v501 = p491.X
    local v502 = p492.X
    local v503 = math.max(v501, v502)
    local v504 = p491.Z
    local v505 = p492.Z
    local v506 = math.max(v504, v505)
    local v507 = (v497 - p490.TerrainOffsetX) % 40.96000000000001
    local v508 = (v500 - p490.TerrainOffsetY) % 40.96000000000001
    local v509 = v503 - v497 + v507
    local v510 = v506 - v500 + v508
    local v511 = v509 / 40.96000000000001
    local v512 = math.floor(v511)
    local v513 = v510 / 40.96000000000001
    local v514 = math.floor(v513)
    local v515 = (v497 - p490.TerrainOffsetX) / 40.96000000000001
    local v516 = math.floor(v515) * 40.96000000000001 + p490.TerrainOffsetX
    local v517 = (v500 - p490.TerrainOffsetY) / 40.96000000000001
    local v518 = math.floor(v517) * 40.96000000000001 + p490.TerrainOffsetY
    local v519 = Vector3.new(v516, 0, v518)
    local v520 = v509 * v509 + v510 * v510
    local v521 = math.sqrt(v520)
    local v522 = {}
    for v523 = 1, v512 do
        local v524 = v523 * 40.96000000000001
        local v525 = -v521
        local v526 = v519 + Vector3.new(v524, 0, v525)
        local v527 = v523 * 40.96000000000001
        local v528 = v519 + Vector3.new(v527, 0, v521)
        local v529 = {
            v526.X,
            v526.Z,
            v528.X,
            v528.Z
        }
        table.insert(v522, v529)
    end
    for v530 = 1, v514 do
        local v531 = -v521
        local v532 = v530 * 40.96000000000001
        local v533 = v519 + Vector3.new(v531, 0, v532)
        local v534 = v530 * 40.96000000000001
        local v535 = v519 + Vector3.new(v521, 0, v534)
        local v536 = {
            v533.X,
            v533.Z,
            v535.X,
            v535.Z
        }
        table.insert(v522, v536)
    end
    local v537 = v509 / 40.96000000000001
    local v538 = math.ceil(v537) * 40.96000000000001
    for v539 = 1, v514 do
        local v540 = -v521 + v538
        local v541 = v521 + v539 * 40.96000000000001
        local v542 = v519 + Vector3.new(v540, 0, v541)
        local v543 = v521 + v538
        local v544 = -v521 + v539 * 40.96000000000001
        local v545 = v519 + Vector3.new(v543, 0, v544)
        local v546 = {
            v542.X,
            v542.Z,
            v545.X,
            v545.Z
        }
        table.insert(v522, v546)
    end
    for v547 = 0, v512 do
        local v548 = -v521 - v547 * 40.96000000000001 + v538
        local v549 = v519 + Vector3.new(v548, 0, v521)
        local v550 = v521 - v547 * 40.96000000000001 + v538
        local v551 = -v521
        local v552 = v519 + Vector3.new(v550, 0, v551)
        local v553 = {
            v549.X,
            v549.Z,
            v552.X,
            v552.Z
        }
        table.insert(v522, v553)
    end
    local v554 = {}
    for v555 = 1, #v522 do
        local v556, v557 = findIntersection(v522[v555][1], v522[v555][2], v522[v555][3], v522[v555][4], p491.X, p491.Z, p492.X, p492.Z)
        if v556 and (v557 and (v497 <= v556 and (v556 <= v503 and (v500 <= v557 and v557 <= v506)))) then
            local v558 = LaserDownAtTerrain(Vector3.new(v556, 0, v557), p493, p494)
            local v559 = Vector3.new(v556, v558, v557)
            table.insert(v554, v559)
        end
    end
    local u560 = Vector2.new(p491.X, p491.Z)
    table.sort(v554, function(p561, p562) --[[ Line: 1368 ]]
        --[[
        Upvalues:
            [1] = u560
        --]]
        return (u560 - Vector2.new(p561.X, p561.Z)).magnitude < (u560 - Vector2.new(p562.X, p562.Z)).magnitude
    end)
    return v554
end
function u8.DrawRoad(p563, p564, p565, p566, p567, p568, p569, p570) --[[ Line: 1376 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("DrawRoad")
    local v571 = p569 or 0
    local v572 = p570 or 0
    local v573 = p564 + Vector3.new(0, v571, 0)
    local v574 = p565 + Vector3.new(0, v572, 0)
    local v575 = (v573 - v574).magnitude
    local v576 = nil
    if p567 == "Small Road" then
        v576 = script.Road:Clone()
        v576.Size = Vector3.new(2.6, 0.1, v575)
    elseif p567 == "Large Road" then
        v576 = script.LRoad:Clone()
        v576.Size = Vector3.new(3, 0.15, v575)
    elseif p567 == "Highway" then
        v576 = script.Highway:Clone()
        v576.Size = Vector3.new(5, 0.2, v575)
    end
    if v571 > 0 or v572 > 0 then
        v576.Transparency = 0
    end
    if p563.RenderSettings.RoadTextures == "Off" then
        v576.Texture:Destroy()
        v576.Transparency = 0
    end
    if p568 then
        v576.Color = p568
    end
    v576.CFrame = CFrame.new(v573, v574) * CFrame.new(0, 0, -v575 / 2)
    v576.Parent = p566
    p563.Tickers.RoadsLoad = p563.Tickers.RoadsLoad + 1
    p563.Tickers.RoadParts = p563.Tickers.RoadParts + 1
    if p563.Tickers.RoadsLoad > p563.RenderSettings.LoadSpeedRoads then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("DrawRoad")
        p563.Tickers.RoadsLoad = 0
    end
    debug.profileend()
end
function u8.RenderRoad(p577, p578, p579, p580, p581, p582, p583, p584) --[[ Line: 1430 ]]
    debug.profilebegin("RenderRoad")
    local v585 = 0
    local v586 = p578.X
    local v587 = LaserDownAtTerrain
    local v588 = p578.X
    local v589 = p578.Z
    local v590 = v587(Vector3.new(v588, 0, v589), p582, p583)
    local v591 = p578.Z
    local v592 = Vector3.new(v586, v590, v591)
    local v593 = p579.X
    local v594 = LaserDownAtTerrain
    local v595 = p579.X
    local v596 = p579.Z
    local v597 = v594(Vector3.new(v595, 0, v596), p582, p583)
    local v598 = p579.Z
    local v599 = Vector3.new(v593, v597, v598)
    local v600 = p577:ReturnGridIntersections(v592, v599, p582, p583)
    if #v600 == 0 then
        debug.profileend()
        p577:DrawRoad(v592, v599, p580, p581, nil)
        debug.profilebegin("RenderRoad")
    else
        debug.profileend()
        local v601 = 0
        local v602 = 0
        for v603 = 1, #v600 - 1 do
            v601 = v601 + (v600[v603] - v600[v603 + 1]).magnitude
        end
        local v604
        if p584 then
            local v605 = v601 / 10
            v604 = math.clamp(v605, 1, 40)
        else
            v604 = 0
        end
        local v606 = v602 + (v592 - v600[1]).magnitude
        local v607 = v606 / (v601 / 2)
        local v608 = math.clamp(v607, 0, 1)
        local v609 = (v606 - v601 / 2) / (v601 / 2)
        local v610 = ((v608 - math.clamp(v609, 0, 1)) * v604) ^ 0.8
        p577:DrawRoad(v592, v600[1], p580, p581, nil, v585, v610)
        debug.profilebegin("RenderRoad")
        for v611 = 1, #v600 - 1 do
            debug.profileend()
            v606 = v606 + (v600[v611] - v600[v611 + 1]).magnitude
            local v612 = v606 / (v601 / 2)
            local v613 = math.clamp(v612, 0, 1)
            local v614 = (v606 - v601 / 2) / (v601 / 2)
            local v615 = ((v613 - math.clamp(v614, 0, 1)) * v604) ^ 0.8
            p577:DrawRoad(v600[v611], v600[v611 + 1], p580, p581, nil, v610, v615)
            debug.profilebegin("RenderRoad")
            v610 = v615
        end
        debug.profileend()
        p577:DrawRoad(v600[#v600], v599, p580, p581, nil, v585, 0)
        debug.profilebegin("RenderRoad")
    end
    debug.profileend()
end
local u616 = require(game.ReplicatedStorage.MapScripts.RunwayMaker)
function u8.DrawAirportSegment(p617, p618, p619, p620, p621, p622, p623, p624) --[[ Line: 1507 ]]
    --[[
    Upvalues:
        [1] = u616
        [2] = u9
    --]]
    if p622 then
        p622 = nil
    end
    debug.profilebegin("DrawRoad")
    local v625 = (p618 - p619).magnitude
    local v626 = nil
    if p621 == "Runway" then
        v626 = script.Runway:Clone()
        local v627 = (p622 or 100) / 10
        v626.Size = Vector3.new(v627, 0.12, v625)
        local v628 = Instance.new("Model")
        v628.PrimaryPart = v626
        v626.CFrame = CFrame.new(p618, p619) * CFrame.new(0, 0, -v625 / 2)
        v626.Parent = v628
        u616.new(v628, {
            ["Numbers"] = true,
            ["Outline"] = true,
            ["Threshold"] = true,
            ["Markers"] = true,
            ["Stripes"] = true
        }, p624)
        v628.Parent = p620
    elseif p621 == "RunwayThres" then
        v626 = script.RunwayThres:Clone()
        local v629 = (p622 or 100) / 10
        v626.Size = Vector3.new(v629, 0.11, v625)
        local v630 = Instance.new("Model")
        v630.PrimaryPart = v626
        v626.CFrame = CFrame.new(p618, p619) * CFrame.new(0, 0, -v625 / 2)
        v626.Parent = v630
        u616.new(v630, {
            ["Outline"] = true,
            ["Arrows"] = true
        })
        v630.Parent = p620
    elseif p621 == "RunwayBlast" then
        v626 = script.RunwayBlast:Clone()
        local v631 = (p622 or 100) / 10
        v626.Size = Vector3.new(v631, 0.11, v625)
        local v632 = Instance.new("Model")
        v632.PrimaryPart = v626
        v626.CFrame = CFrame.new(p618, p619) * CFrame.new(0, 0, -v625 / 2)
        v626.Parent = v632
        u616.new(v632, {
            ["Blast"] = true
        })
        v632.Parent = p620
    elseif p621 == "Taxiway" then
        v626 = script.AirportWay:Clone()
        local v633 = (p622 or 80) / 10
        v626.Size = Vector3.new(v633, 0.1, v625)
    elseif p621 == "TaxiLine" then
        v626 = script.AirportTaxiLine:Clone()
        v626.Size = Vector3.new(0.2, 0.13, v625)
    elseif p621 == "Outline" then
        v626 = script.Outline:Clone()
        v626.Size = Vector3.new(0.2, 0.13, v625)
        v626.Color = p623
    end
    if p621 ~= "Runway" then
        v626.CFrame = CFrame.new(p618, p619) * CFrame.new(0, 0, -v625 / 2)
        v626.Parent = p620
    end
    if p621 == "Taxiway" then
        local v634 = v626.CFrame
        local v635 = math.random(-100, 0) / 100000
        v626.CFrame = v634 + Vector3.new(0, v635, 0)
    end
    p617.Tickers.RoadsLoad = p617.Tickers.RoadsLoad + 1
    if p617.Tickers.RoadsLoad > p617.RenderSettings.LoadSpeedRoads then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("DrawRoad")
        p617.Tickers.RoadsLoad = 0
    end
    return v626
end
function u8.ShiftRoad(p636, p637, p638, p639) --[[ Line: 1578 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    p637.Size = p637.Size + Vector3.new(0, 0, p639)
    p637.CFrame = p637.CFrame * CFrame.new(0, 0, p638 / 2)
    p636.Tickers.RoadsLoad = p636.Tickers.RoadsLoad + 1
    if p636.Tickers.RoadsLoad > p636.RenderSettings.LoadSpeedRoads then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("DrawRoad")
        p636.Tickers.RoadsLoad = 0
    end
end
function GetNodeInfo(p640, p641, p642)
    local v643 = p640[tostring(p641)]
    if v643 then
        local v644 = v643[1]
        local v645 = v643[2]
        return Vector3.new(v644, p642, v645)
    end
end
function FindConnectingWay(p646, p647, p648, p649)
    for v650 = 1, #p646.Ways do
        if p646.Ways[v650].p.t == p647 then
            local v651 = p646.Ways[v650].g
            for v652 = 1, #v651 do
                if v651[v652] == p648 then
                    return -1
                end
                if v651[v652] == p649 then
                    return 1
                end
            end
        end
    end
    return nil
end
function u8.BuildPOIs(p653, p654, p655, p656, p657, p658) --[[ Line: 1618 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    for v659 = 1, #p654 do
        if p654[v659].Name then
            if p653.AllPOIs[p654[v659].Name] then
                local v660 = p654[v659].Coords
                local v661 = v660[1]
                if typeof(v661) ~= "number" then
                    v660 = p654[v659].Coords[1]
                end
                local v662 = Vector2.new(p653.Lat, p653.Lon)
                local v663, v664 = u5:ConvertLatLongToPix(v662.X, v662.Y, p658)
                local v665 = Vector2.new(v663, v664)
                local v666, v667 = u5:ConvertLatLongToPix(v660[2], v660[1], p658)
                local v668 = Vector2.new((v666 - v665.X) * 0.32, (v667 - v665.Y) * -0.32)
                local v669 = LaserDownAtTerrain
                local v670 = v668.X
                local v671 = v668.Y
                local v672 = v669(Vector3.new(v670, 0, v671), p656, p657)
                local v673 = p653.AllPOIs[p654[v659].Name].AllLocations
                local v674 = v668.X
                local v675 = v672 + 100
                local v676 = v668.Y
                local v677 = Vector3.new(v674, v675, v676)
                table.insert(v673, v677)
                local v678 = Vector3.new()
                for v679 = 1, #p653.AllPOIs[p654[v659].Name].AllLocations do
                    v678 = v678 + p653.AllPOIs[p654[v659].Name].AllLocations[v679]
                end
                local v680 = v678 / #p653.AllPOIs[p654[v659].Name].AllLocations
                game:GetService("TweenService"):Create(p653.AllPOIs[p654[v659].Name].POI, TweenInfo.new(1, 0), {
                    ["CFrame"] = CFrame.new(v680)
                }):Play()
            else
                local v681 = p654[v659].Coords
                local v682 = v681[1]
                if typeof(v682) ~= "number" then
                    v681 = p654[v659].Coords[1]
                end
                local v683 = Vector2.new(p653.Lat, p653.Lon)
                local v684, v685 = u5:ConvertLatLongToPix(v683.X, v683.Y, p658)
                local v686 = Vector2.new(v684, v685)
                local v687, v688 = u5:ConvertLatLongToPix(v681[2], v681[1], p658)
                local v689 = Vector2.new((v687 - v686.X) * 0.32, (v688 - v686.Y) * -0.32)
                local v690 = LaserDownAtTerrain
                local v691 = v689.X
                local v692 = v689.Y
                local v693 = v690(Vector3.new(v691, 0, v692), p656, p657)
                local v694 = script.POI:Clone()
                if p654[v659].Type == "City" then
                    v694.BillboardGui.ImageLabel.Image = "rbxassetid://5700778165"
                    v694.BillboardGui.ImageLabel.ImageLabel.Image = "rbxassetid://5700778165"
                elseif p654[v659].Type == "Airport" then
                    v694.BillboardGui.ImageLabel.Image = "rbxassetid://5700778170"
                    v694.BillboardGui.ImageLabel.ImageLabel.Image = "rbxassetid://5700778170"
                elseif p654[v659].Type == "Bridge" then
                    v694.BillboardGui.ImageLabel.Image = "rbxassetid://5700795276"
                    v694.BillboardGui.ImageLabel.ImageLabel.Image = "rbxassetid://5700795276"
                end
                v694.BillboardGui.TextLabel.Text = p654[v659].Name
                v694.BillboardGui.TextLabel.TextLabel.Text = p654[v659].Name
                v694.CFrame = CFrame.new(v689.X, v693 + 100, v689.Y)
                v694.Parent = p655
                local v695 = p653.AllPOIs
                local v696 = p654[v659].Name
                local v697 = {
                    ["POI"] = v694
                }
                local v698 = {}
                local v699 = v689.X
                local v700 = v693 + 100
                local v701 = v689.Y
                __set_list(v698, 1, {(Vector3.new(v699, v700, v701))})
                v697.AllLocations = v698
                v695[v696] = v697
            end
        end
    end
end
local u702 = require(game.ReplicatedStorage.MapScripts.DouglasPeucker)
function u8.BuildAirports(p703, p704, p705, p706, p707, p708) --[[ Line: 1692 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u702
    --]]
    local v709, v710 = u5:ConvertLatLongToPix(p703.Lat, p703.Lon, p708)
    local v711 = Vector2.new(v709, v710)
    debug.profilebegin("BuildAirports")
    if p704 and #p704 > 0 then
        for v712 = 1, #p704 do
            warn("AIRPORT BUILD")
            local v713 = p704[v712]
            local v714 = Instance.new("Model")
            v714.Parent = p705
            v714.Name = v713.Data.ICAO
            local v715 = v713.Data.Coords
            local v716 = Vector2.new(p703.Lat, p703.Lon)
            local v717, v718 = u5:ConvertLatLongToPix(v716.X, v716.Y, p708)
            local v719 = Vector2.new(v717, v718)
            local v720, v721 = u5:ConvertLatLongToPix(v715[1], v715[2], p708)
            local v722 = Vector2.new((v720 - v719.X) * 0.32, (v721 - v719.Y) * -0.32)
            local v723 = 0
            local v724 = Vector3.new(0, 0, 0)
            local v725 = 0
            local v726 = {}
            for v727 = 1, #v713.Ways do
                local v728 = v713.Ways[v727].g
                if v713.Ways[v727].p.t == "Outline" then
                    for v729 = 1, #v728 do
                        local v730 = GetNodeInfo(v713.Nodes, v728[v729], 0)
                        local v731 = ((v730.X + v713.LowestX) / 10 - v711.X) * 0.32
                        local v732 = ((v730.Z + v713.LowestY) / 10 - v711.Y) * -0.32
                        local v733 = Vector3.new(v731, 0, v732)
                        local v734 = LaserDownAtTerrain
                        local v735 = v733.X
                        local v736 = v733.Z
                        local v737, v738 = v734(Vector3.new(v735, 0, v736), p706 - 10, p707 + 10)
                        if v737 and v738 then
                            v723 = v723 + 1
                            local v739, v740, v741 = Color3.toHSV(v738)
                            if v741 > 0.2 then
                                v724 = v724 + Vector3.new(v739, v740, v741)
                            end
                            if v725 < v737 then
                                v725 = v737
                            end
                        end
                    end
                end
            end
            local v742 = v724 / v723
            local v743 = Color3.fromHSV(v742.X, v742.Y, v742.Z)
            if v725 == 0 then
                local v744 = LaserDownAtTerrain
                local v745 = v722.X
                local v746 = v722.Y
                v725 = v744(Vector3.new(v745, 0, v746), p706, p707)
            end
            local v747 = {}
            for v748 = 1, #v713.Ways do
                local v749 = v713.Ways[v748].g
                local v750 = v713.Ways[v748].p.t
                if v750 == "Outline" or (v750 == "Grass" or (v750 == "Apron" or (v750 == "Terminal" or v750 == "Hangar"))) then
                    local v751 = {}
                    for v752 = 1, #v749 - 1 do
                        local v753 = v713.Nodes
                        local v754 = v749[v752]
                        local v755 = v753[tostring(v754)]
                        local v756 = {
                            ["x"] = ((v755[1] + v713.LowestX) / 10 - v711.X) * 0.32,
                            ["y"] = ((v755[2] + v713.LowestY) / 10 - v711.Y) * -0.32
                        }
                        table.insert(v751, v756)
                    end
                    local v757 = u702:Calc(v751, 2, false)
                    local v758 = {}
                    for v759 = 1, #v757 do
                        local v760 = { v757[v759].x, v757[v759].y }
                        table.insert(v758, v760)
                    end
                    if v750 == "Grass" then
                        p703:CreatePolygon(v758, nil, 0.725, v750, v714, Color3.fromRGB(64, 85, 41), Enum.Material.Grass, false, p708, nil, nil, v725 - 0.2)
                    elseif v750 == "Outline" then
                        p703:CreatePolygon(v758, nil, 200, v750, v714, v743, Enum.Material.Grass, false, p708, nil, nil, v725 - 66.2272 - 0.3)
                    elseif v750 == "Apron" then
                        p703:CreatePolygon(v758, nil, 0.775, v750, v714, Color3.fromRGB(96, 98, 104), Enum.Material.Concrete, false, p708, nil, nil, v725 - 0.2)
                    elseif v750 == "Terminal" then
                        p703:CreatePolygon(v758, nil, v713.Ways[v748].p.h or 10, v750, v714, Color3.fromRGB(40, 40, 40), Enum.Material.SmoothPlastic, false, p708, nil, nil, v725 - 0.2)
                    elseif v750 == "Hangar" then
                        p703:CreatePolygon(v758, nil, v713.Ways[v748].p.h or 10, v750, v714, Color3.fromRGB(60, 60, 60), Enum.Material.SmoothPlastic, false, p708, nil, nil, v725 - 0.2)
                    end
                else
                    local v761 = nil
                    local v762 = nil
                    for v763 = 1, #v749 - 1 do
                        local v764 = GetNodeInfo(v713.Nodes, v749[v763], v725)
                        local v765 = ((v764.X + v713.LowestX) / 10 - v711.X) * 0.32
                        local v766 = v764.Y
                        local v767 = ((v764.Z + v713.LowestY) / 10 - v711.Y) * -0.32
                        local v768 = Vector3.new(v765, v766, v767)
                        local v769 = GetNodeInfo(v713.Nodes, v749[v763 + 1], v725)
                        local v770 = ((v769.X + v713.LowestX) / 10 - v711.X) * 0.32
                        local v771 = v769.Y
                        local v772 = ((v769.Z + v713.LowestY) / 10 - v711.Y) * -0.32
                        local v773 = Vector3.new(v770, v771, v772)
                        local v774 = v713.Ways[v748].p.t
                        local v775 = nil
                        if v774 == "RunwayThres" then
                            v775 = FindConnectingWay(v713, "Runway", v749[v763], v749[v763 + 1])
                        elseif v774 == "RunwayBlast" then
                            v775 = FindConnectingWay(v713, "Runway", v749[v763], v749[v763 + 1]) or FindConnectingWay(v713, "RunwayThres", v749[v763], v749[v763 + 1])
                        end
                        if v775 == -1 then
                            local v776 = GetNodeInfo(v713.Nodes, v749[v763 + 1], v725)
                            local v777 = ((v776.X + v713.LowestX) / 10 - v711.X) * 0.32
                            local v778 = v776.Y
                            local v779 = ((v776.Z + v713.LowestY) / 10 - v711.Y) * -0.32
                            v768 = Vector3.new(v777, v778, v779)
                            local v780 = GetNodeInfo(v713.Nodes, v749[v763], v725)
                            local v781 = ((v780.X + v713.LowestX) / 10 - v711.X) * 0.32
                            local v782 = v780.Y
                            local v783 = ((v780.Z + v713.LowestY) / 10 - v711.Y) * -0.32
                            v773 = Vector3.new(v781, v782, v783)
                        end
                        local v784 = v713.Ways[v748].p.w
                        local v785
                        if v750 == "Outline" then
                            v785 = Color3.fromHSV(v763 / #v749, 0.5, 0.5)
                        else
                            v785 = nil
                        end
                        local v786 = p703:DrawAirportSegment(v768, v773, v714, v774, v784, v785, v715)
                        if v774 == "Runway" or v774 == "Taxiway" then
                            table.insert(v726, {
                                ["RoadPart"] = v786,
                                ["WayType"] = v774
                            })
                        end
                        local v787 = v768.X - v773.X
                        local v788 = v768.Z - v773.Z
                        local v789 = math.atan2(v787, v788)
                        local v790 = math.deg(v789)
                        if v762 then
                            local v791 = -(v790 - v762) % 360
                            local v792 = v786.Size.X / 2
                            local v793 = v791 / 2
                            local v794 = math.rad(v793)
                            local v795 = v792 / math.tan(v794)
                            local v796 = math.abs(v795)
                            local v797 = v786.Size.X
                            local v798 = math.clamp(v796, 0, v797)
                            p703:ShiftRoad(v786, v798, v798)
                            p703:ShiftRoad(v761, -v798, v798)
                        end
                        if (v774 == "Taxiway" or v774 == "TaxiLine") and (v763 == 1 or v763 == #v749 - 1) then
                            if v763 == 1 then
                                if not v747["N" .. v749[v763]] then
                                    v747["N" .. v749[v763]] = {}
                                end
                                if not v747["N" .. v749[v763]][v774] then
                                    v747["N" .. v749[v763]][v774] = {}
                                end
                                local v799 = v747["N" .. v749[v763]][v774]
                                table.insert(v799, {
                                    ["End"] = 1,
                                    ["Road"] = v786,
                                    ["Heading"] = v790
                                })
                            end
                            if v763 == #v749 - 1 then
                                if not v747["N" .. v749[v763 + 1]] then
                                    v747["N" .. v749[v763 + 1]] = {}
                                end
                                if not v747["N" .. v749[v763 + 1]][v774] then
                                    v747["N" .. v749[v763 + 1]][v774] = {}
                                end
                                local v800 = v747["N" .. v749[v763 + 1]][v774]
                                local v801 = {
                                    ["End"] = -1,
                                    ["Road"] = v786,
                                    ["Heading"] = v790 + 180
                                }
                                table.insert(v800, v801)
                            end
                        end
                        v762 = v790 + 180
                        v761 = v786
                    end
                end
            end
            for v802, v803 in pairs(v747) do
                string.sub(v802, 2, -1)
                for _, v804 in pairs(v803) do
                    for v805 = 1, #v804 do
                        local v806, v807, v808, v809, v810, v811
                        if v805 == #v804 then
                            v806 = v804[v805].Heading
                            v807 = v804[1].Heading
                            v808 = v804[v805].Road
                            v809 = v804[1].Road
                            v810 = v804[v805].End
                            v811 = v804[1].End
                        else
                            v806 = v804[v805].Heading
                            v807 = v804[v805 + 1].Heading
                            v808 = v804[v805].Road
                            v809 = v804[v805 + 1].Road
                            v810 = v804[v805].End
                            v811 = v804[v805 + 1].End
                        end
                        local v812 = -(v806 - v807) % 360
                        if v812 <= 270 and v812 >= 90 then
                            local v813 = v808.Size.X / 2
                            local v814 = v812 / 2
                            local v815 = math.rad(v814)
                            local v816 = v813 / math.tan(v815)
                            local v817 = math.abs(v816)
                            local v818 = v808.Size.X
                            local v819 = math.clamp(v817, 0, v818)
                            p703:ShiftRoad(v808, v819 * v810, v819)
                            p703:ShiftRoad(v809, v819 * v811, v819)
                        end
                    end
                end
            end
            p703.AirportsLoaded[v713.Data.ICAO] = v726
        end
    end
    debug.profileend()
end
function u8.BuildRoads(p820, p821, p822, p823, p824, p825) --[[ Line: 1940 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u10
    --]]
    local v826, v827 = u5:ConvertLatLongToPix(p820.Lat, p820.Lon, p825)
    local v828 = Vector2.new(v826, v827)
    local v829 = p821.Roads
    debug.profilebegin("BuildRoads")
    if v829 and #v829 > 0 then
        for v830 = 1, #v829 do
            if v829[v830] and v829[v830].p then
                local v831 = v829[v830].p.i
                local v832 = v829[v830].p.b
                local v833 = v829[v830].p.rt
                local v834 = Instance.new("Model")
                v834.Name = v831
                local v835 = v829[v830].g
                local v836 = Instance.new("Model")
                local v837 = 0
                for v838 = 1, #v835 do
                    local v839 = v835[v838]
                    for v840 = 1, #v839 do
                        v839[v840] = { ((v839[v840][1] + p821.LowestX) / 10 - v828.X) * 0.32, ((v839[v840][2] + p821.LowestY) / 10 - v828.Y) * -0.32 }
                    end
                    for v841 = 1, #v839 do
                        local v842 = v839[v841]
                        local v843 = v839[v841 - 1]
                        local v844 = (u10 * CFrame.new(v842[1], 0, v842[2])).p
                        if v841 > 1 then
                            local v845 = u10
                            local v846 = CFrame.new
                            local v847 = v843[1]
                            local v848 = tonumber(v847)
                            local v849 = v843[2]
                            local v850 = (v845 * v846(v848, 0, (tonumber(v849)))).p
                            debug.profileend()
                            p820:RenderRoad(v844, v850, v836, v833, p823, p824, v832)
                            v837 = v837 + 1
                            debug.profilebegin("BuildRoads")
                            if v837 % 10 == 0 then
                                debug.profilebegin("NewChunk_Roads")
                                v836.Parent = v834
                                debug.profileend()
                                v836 = Instance.new("Model")
                            end
                        end
                    end
                end
                debug.profilebegin("NewChunk_Roads")
                v836.Parent = v834
                debug.profileend()
                v834.Parent = p822
            end
        end
    end
    debug.profileend()
end
initialResolution = 156542.7884911149
originShift = 20037476.926862705
function Resolution(p851)
    return initialResolution / math.pow(2, p851)
end
function InNearestTileJobs(p852, p853)
    for v854 = 1, #p852 do
        if p852[v854][1] .. "_" .. p852[v854][2] == p853 then
            return true
        end
    end
    return false
end
function u8.GetGBPool(p855, p856) --[[ Line: 2029 ]]
    local v857 = tick()
    local v858 = p855.NearestTerrainTiles[p856]
    local v859 = {}
    for v860, v861 in pairs(p855.TileModels[p856]) do
        if v861.Terrain and not InNearestTileJobs(v858, v860) then
            for v862, v863 in pairs(v861.Terrain:GetChildren()) do
                v859[v862] = v863
            end
        end
    end
    print("CALC POOL TIME", tick() - v857)
    return #v859 > 0 and v859 and v859 or nil
end
function RecreateElement3(p864, p865, p866)
    return p864[(p865 - 1) * 3 + p866]
end
function RecreateElement2(p867, p868, p869)
    return p867[(p868 - 1) * 4 + p869]
end
function RecreateElement(p870, p871, p872)
    debug.profilebegin("RecreateElement")
    local v873 = p871 - 1
    local v874 = v873 / 10
    local v875 = p870[math.floor(v874) * 40 + p872]
    for v876 = 1, v873 % 10 do
        local v877 = v873 / 10
        v875 = v875 + p870[math.floor(v877) * 40 + p872 + v876 * 4]
    end
    debug.profileend()
    return v875
end
function RecreateTile(p878)
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("RecreateTile")
    local v879 = -99999
    local v880 = 99999
    local v881 = {}
    for v882 = 0, #p878 / 4 - 1 do
        if v882 % 500 == 0 then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("RecreateTile")
        end
        for v883 = 1, 4 do
            local v884 = v882 / 10
            local v885 = math.floor(v884) * 40 + v883
            local v886 = p878[v885]
            for v887 = 1, v882 % 10 do
                v886 = v886 + p878[v885 + v887 * 4]
            end
            table.insert(v881, v886)
            if v883 == 1 then
                if v879 < v886 then
                    v879 = v886
                end
                if v886 < v880 then
                    v880 = v886
                end
            end
        end
    end
    debug.profileend()
    return v881, v880, v879
end
function GetTextureID(p888)
    local v889 = script.PropTextures[p888]:GetChildren()
    return v889[math.random(1, #v889)].Texture
end
function u8.SpawnProps(p890, _, p891, p892, p893, p894, _, _, p895, p896, p897) --[[ Line: 2105 ]]
    debug.profilebegin("SpawnProps")
    local v898 = script.Trees:GetChildren()
    local v899 = p893 - p892
    local v900 = 0
    local v901 = 0
    while v900 < p891 and v901 < p891 do
        local v902 = Vector2.new(p895.X + math.random(-p896.X / 2, p896.X / 2), p895.Z + math.random(-p896.X / 2, p896.X / 2))
        local v903 = math.noise(v902.X / 300, v902.Y / 300)
        local v904 = math.ceil(v903)
        local v905 = v904 <= 0 and 0 or math.random(1, 1 / v904)
        if v901 % 200 == 0 then
            debug.profileend()
            game:GetService("RunService").Stepped:wait()
            debug.profilebegin("SpawnProps")
        end
        v901 = v901 + 1
        if v905 == 1 then
            local v906 = Ray.new
            local v907 = v902.X
            local v908 = v902.Y
            local v909 = Vector3.new(v907, p893, v908)
            local v910 = -v899
            local v911 = v906(v909, (Vector3.new(0, v910, 0)))
            local v912, v913, v914, v915 = workspace:FindPartOnRay(v911)
            if v912 and v912:IsDescendantOf(workspace.Map.Terrain) then
                local v916, _, v917 = v912.Color:ToHSV()
                local v918 = v916 > 0.1568627450980392 and (v916 < 0.5490196078431373 and v917 > 0.2)
                if p892 < v913.Y and (v913.Y < p893 and (v915 == p894 and (v914.Y > 0.5 and v918))) then
                    local v919 = v898[math.random(1, #v898)]:Clone()
                    v919:SetPrimaryPartCFrame(CFrame.new(v913) * CFrame.Angles(0, math.random(-100, 100), 0))
                    v919.Parent = p897
                    if #v919.PrimaryPart:GetTouchingParts() > 1 then
                        v919:Destroy()
                    else
                        v919.PrimaryPart:Destroy()
                        v900 = v900 + 1
                    end
                    p890.Tickers.TreeParts = p890.Tickers.TreeParts + #v919:GetChildren()
                    if v900 % 10 == 0 then
                        debug.profileend()
                        game:GetService("RunService").Stepped:wait()
                        debug.profilebegin("SpawnProps")
                    end
                end
            end
        end
    end
    debug.profileend()
end
function u8.BuildTrees(p920, p921, p922, p923, _, p924, p925) --[[ Line: 2190 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v926 = Instance.new("Model")
    v926.Name = "Trees"
    v926.Parent = p921
    local v927 = 65536 / math.pow(2, p923) * 51.2 * 3.2
    local v928, v929 = u5:ConvertLatLongToTile(-p920.Lat, p920.Lon, p923)
    local v930 = string.split(p922, "_")
    local v931 = (v930[1] - v928) * v927
    local v932 = (v930[2] - v929) * v927
    local v933 = Vector3.new(v931, 0, v932)
    local v934 = Vector3.new(v927, 1, v927)
    p920:SpawnProps("Rocks", 300, p924, p925, Enum.Material.Grass, true, nil, v933, v934, v926)
end
function u8.BuildTerrain(p935, p936, p937, p938, p939, p940) --[[ Line: 2214 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u10
        [4] = u9
    --]]
    debug.profilebegin("BuildTerrain")
    local v941 = 65536 / math.pow(2, p939) * 51.2 * 3.2
    local v942, v943 = u5:ConvertLatLongToTile(-p935.Lat, p935.Lon, p939, 512)
    local v944 = string.split(p938, "_")
    local v945 = (v944[1] - v942) * v941 + p935.TerrainOffsetX - 40.96
    local v946 = (v944[2] - v943) * v941 + p935.TerrainOffsetY - 40.96
    local v947 = Vector3.new(v945, 0, v946)
    tick()
    debug.profileend()
    local v948, v949, v950 = RecreateTile(p936)
    p935.EleTerrainMemory[p938] = { v949, v950 }
    debug.profilebegin("BuildTerrain")
    local v951 = Instance.new("Model")
    local v952 = 0
    for v953 = 1, 64 / p940 - 1 do
        for v954 = 1, 64 / p940 - 1 do
            local v955 = v941 * 0.015625
            local v956 = v953 * p940
            local v957 = v954 * p940
            local v958 = (v957 - p940) * 64 + v956
            local v959 = RecreateElement2(v948, v958, 1) * 0.3328
            local v960 = math.max(v959, -1)
            local v961 = v947 + Vector3.new(v956, v960, v957) * Vector3.new(v955, 1, v955)
            local v962 = Color3.fromRGB(RecreateElement2(v948, v958, 2), RecreateElement2(v948, v958, 3), RecreateElement2(v948, v958, 4))
            local v963 = (v957 - p940) * 64 + v956 + p940
            local v964 = v956 + p940
            local v965 = RecreateElement2(v948, v963, 1) * 0.3328
            local v966 = math.max(v965, -1)
            local v967 = v947 + Vector3.new(v964, v966, v957) * Vector3.new(v955, 1, v955)
            local v968 = v957 * 64 + v956
            local v969 = RecreateElement2(v948, v968, 1) * 0.3328
            local v970 = math.max(v969, -1)
            local v971 = v957 + p940
            local v972 = v947 + Vector3.new(v956, v970, v971) * Vector3.new(v955, 1, v955)
            local v973 = v957 * 64 + v956 + p940
            local v974 = v956 + p940
            local v975 = RecreateElement2(v948, v973, 1) * 0.3328
            local v976 = math.max(v975, -1)
            local v977 = v957 + p940
            local v978 = v947 + Vector3.new(v974, v976, v977) * Vector3.new(v955, 1, v955)
            if v961.Y > 0 or (v967.Y > 0 or v972.Y > 0) then
                p935.Tickers.TerrainParts = p935.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v961)).p, (u10 * CFrame.new(v967)).p, (u10 * CFrame.new(v972)).p, p935:ShiftTerrainColor(v962), v951, 1, p935.RenderSettings.TerrainShadows, p935.RenderSettings.TerrainTextures)
                p935.Tickers.TerrainLoad = p935.Tickers.TerrainLoad + p940
                if p935.Tickers.TerrainLoad > p935.RenderSettings.LoadSpeedTerrain then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("NewChunk_Terrain1_" .. p939 .. "_" .. #p937:GetChildren() .. "_" .. p940 .. "_" .. p938)
                    v951.Parent = p937
                    debug.profileend()
                    v951 = Instance.new("Model")
                    debug.profilebegin("BuildTerrain")
                    p935.Tickers.TerrainLoad = 0
                end
            else
                v952 = v952 + 1
                if v952 % 50 == 0 then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("BuildTerrain")
                end
            end
            if v978.Y > 0 or (v972.Y > 0 or v967.Y > 0) then
                p935.Tickers.TerrainParts = p935.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v978)).p, (u10 * CFrame.new(v972)).p, (u10 * CFrame.new(v967)).p, p935:ShiftTerrainColor(v962), v951, 1, p935.RenderSettings.TerrainShadows, p935.RenderSettings.TerrainTextures)
                p935.Tickers.TerrainLoad = p935.Tickers.TerrainLoad + p940
                if p935.Tickers.TerrainLoad > p935.RenderSettings.LoadSpeedTerrain then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("NewChunk_Terrain2_" .. p939 .. "_" .. #p937:GetChildren() .. "_" .. p940 .. "_" .. p938)
                    v951.Parent = p937
                    debug.profileend()
                    v951 = Instance.new("Model")
                    debug.profilebegin("BuildTerrain")
                    p935.Tickers.TerrainLoad = 0
                end
            else
                v952 = v952 + 1
                if v952 % 50 == 0 then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("BuildTerrain")
                end
            end
        end
    end
    debug.profilebegin("NewChunk_Terrain3_" .. p939 .. "_" .. #p937:GetChildren() .. "_" .. p940 .. "_" .. p938)
    v951.Parent = p937
    debug.profileend()
    debug.profileend()
end
function u8.GetTerrainColorPixel(p979, p980, p981, p982, p983) --[[ Line: 2324 ]]
    return not (p979.Memory[p981][p980] and p979.Memory[p981][p980].Terrain) and { 220, 220, 220 } or p979.Memory[p981][p980].Terrain[(p983 - 1) * 256 + p982].C
end
function ReturnAvgColor(p984, p985, p986)
    local v987 = Vector3.new()
    local v988 = p984[1]
    local v989 = p984[2]
    local v990 = p984[3]
    local v991 = v987 + Vector3.new(v988, v989, v990)
    local v992 = p985[1]
    local v993 = p985[2]
    local v994 = p985[3]
    local v995 = v991 + Vector3.new(v992, v993, v994)
    local v996 = p986[1]
    local v997 = p986[2]
    local v998 = p986[3]
    local v999 = (v995 + Vector3.new(v996, v997, v998)) / 3
    return Color3.fromRGB(v999.X, v999.Y, v999.Z)
end
function u8.Cube(p1000, p1001, p1002, p1003, p1004, p1005, p1006) --[[ Line: 2340 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u10
        [4] = u9
    --]]
    local v1007 = Instance.new("Model")
    debug.profilebegin("Cube")
    local v1008 = 65536 / math.pow(2, p1001) * 51.2 * 3.2
    local v1009, v1010 = u5:ConvertLatLongToTile(-p1000.Lat, p1000.Lon, p1001, 512)
    local v1011 = string.split(p1002, "_")
    local v1012 = string.split(p1003, "_")
    local v1013 = string.split(p1004, "_")
    local v1014 = string.split(p1005, "_")
    local v1015 = (v1011[1] - v1009) * v1008 + p1000.TerrainOffsetX - 40.96
    local v1016 = (v1011[2] - v1010) * v1008 + p1000.TerrainOffsetY - 40.96
    local v1017 = Vector3.new(v1015, 0, v1016)
    local v1018 = (v1012[1] - v1009) * v1008 + p1000.TerrainOffsetX - 40.96
    local v1019 = (v1012[2] - v1010) * v1008 + p1000.TerrainOffsetY - 40.96
    local v1020 = Vector3.new(v1018, 0, v1019)
    local v1021 = (v1013[1] - v1009) * v1008 + p1000.TerrainOffsetX - 40.96
    local v1022 = (v1013[2] - v1010) * v1008 + p1000.TerrainOffsetY - 40.96
    local v1023 = Vector3.new(v1021, 0, v1022)
    local v1024 = (v1014[1] - v1009) * v1008 + p1000.TerrainOffsetX - 40.96
    local v1025 = (v1014[2] - v1010) * v1008 + p1000.TerrainOffsetY - 40.96
    local v1026 = Vector3.new(v1024, 0, v1025)
    local v1027 = p1000.LODTerrainMemory[p1002]
    local v1028 = p1000.LODTerrainMemory[p1003]
    local v1029 = p1000.LODTerrainMemory[p1004]
    local v1030 = p1000.LODTerrainMemory[p1005]
    local v1031 = p1000.Memory[p1001][p1002]
    if v1031 then
        v1031 = p1000.Memory[p1001][p1002].Terrain
    end
    local v1032 = p1000.Memory[p1001][p1003]
    if v1032 then
        v1032 = p1000.Memory[p1001][p1003].Terrain
    end
    local v1033 = p1000.Memory[p1001][p1004]
    if v1033 then
        v1033 = p1000.Memory[p1001][p1004].Terrain
    end
    local v1034 = p1000.Memory[p1001][p1005]
    if v1034 then
        v1034 = p1000.Memory[p1001][p1005].Terrain
    end
    local v1035 = {}
    local v1036 = {}
    if v1031 and (v1032 and (v1033 and (v1034 and (v1027 and (v1028 and (v1029 and v1030)))))) then
        local v1037 = v1008 * 0.015625
        local v1038 = (v1027 - v1027) * 64 + 64
        local v1039 = RecreateElement(v1031, v1038, 1) * 0.3328
        local v1040 = math.max(v1039, -1)
        local v1041 = v1017 + Vector3.new(64, v1040, v1027) * Vector3.new(v1037, 1, v1037)
        local v1042 = Color3.fromRGB(RecreateElement(v1031, v1038, 2), RecreateElement(v1031, v1038, 3), RecreateElement(v1031, v1038, 4))
        table.insert(v1035, v1041)
        local v1043 = (64 - v1028) * 64 + 64
        local v1044 = RecreateElement(v1032, v1043, 1) * 0.3328
        local v1045 = math.max(v1044, -1)
        local v1046 = v1020 + Vector3.new(64, v1045, 64) * Vector3.new(v1037, 1, v1037)
        table.insert(v1035, v1046)
        local v1047 = (v1030 - v1030) * 64 + v1030
        local v1048 = RecreateElement(v1034, v1047, 1) * 0.3328
        local v1049 = math.max(v1048, -1)
        local v1050 = v1026 + Vector3.new(v1030, v1049, v1030) * Vector3.new(v1037, 1, v1037)
        table.insert(v1036, v1050)
        local v1051 = (64 - v1029) * 64 + v1029
        local v1052 = RecreateElement(v1033, v1051, 1) * 0.3328
        local v1053 = math.max(v1052, -1)
        local v1054 = v1023 + Vector3.new(v1029, v1053, 64) * Vector3.new(v1037, 1, v1037)
        table.insert(v1036, v1054)
        local v1055 = v1035[1]
        local v1056 = v1035[2]
        local v1057 = v1036[2]
        local v1058 = v1036[1]
        local v1059 = v1036[2]
        local v1060 = v1035[1]
        if v1055.Y > 0 or (v1056.Y > 0 or v1057.Y > 0) then
            p1000.Tickers.TerrainParts = p1000.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1055)).p, (u10 * CFrame.new(v1056)).p, (u10 * CFrame.new(v1057)).p, p1000:ShiftTerrainColor(v1042), v1007, 1, p1000.RenderSettings.TerrainShadows, p1000.RenderSettings.TerrainTextures)
            p1000.Tickers.TerrainLoad = p1000.Tickers.TerrainLoad + 1
            if p1000.Tickers.TerrainLoad > p1000.RenderSettings.LoadSpeedTerrain then
                debug.profileend()
                u9.Stepped:wait()
                debug.profilebegin("Cube")
                p1000.Tickers.TerrainLoad = 0
            end
        end
        if v1058.Y > 0 or (v1059.Y > 0 or v1060.Y > 0) then
            p1000.Tickers.TerrainParts = p1000.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1058)).p, (u10 * CFrame.new(v1059)).p, (u10 * CFrame.new(v1060)).p, p1000:ShiftTerrainColor(v1042), v1007, 1, p1000.RenderSettings.TerrainShadows, p1000.RenderSettings.TerrainTextures)
            p1000.Tickers.TerrainLoad = p1000.Tickers.TerrainLoad + 1
            if p1000.Tickers.TerrainLoad > p1000.RenderSettings.LoadSpeedTerrain then
                debug.profileend()
                u9.Stepped:wait()
                debug.profilebegin("Cube")
                p1000.Tickers.TerrainLoad = 0
            end
        end
    end
    debug.profilebegin("NewChunk_TerrainCube_" .. p1001)
    v1007.Parent = p1006
    debug.profileend()
    debug.profileend()
end
function u8.FindNearestTileDis(_, p1061, p1062, _) --[[ Line: 2466 ]]
    for v1063 = 1, #p1061 do
        local v1064 = string.split(p1062, "_")
        local v1065 = p1061[v1063][1]
        local v1066 = v1064[1]
        if v1065 == tonumber(v1066) then
            local v1067 = p1061[v1063][2]
            local v1068 = v1064[2]
            if v1067 == tonumber(v1068) then
                return p1061[v1063][3]
            end
        end
    end
end
function NewMark(p1069, p1070)
    local v1071 = script.Mark:Clone()
    v1071.Name = p1070 or "NoName"
    v1071.CFrame = CFrame.new(p1069)
    v1071.Parent = workspace.Debug
    game:GetService("Debris"):AddItem(v1071, 60)
end
function u8.StitchLines(p1072, p1073, p1074, p1075, p1076, p1077) --[[ Line: 2486 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u10
        [4] = u9
    --]]
    debug.profilebegin("StitchLines")
    local v1078 = 65536 / math.pow(2, p1073) * 51.2 * 3.2
    local v1079, v1080 = u5:ConvertLatLongToTile(-p1072.Lat, p1072.Lon, p1073, 512)
    local v1081 = string.split(p1074, "_")
    local v1082 = string.split(p1075, "_")
    local v1083 = (v1081[1] - v1079) * v1078 + p1072.TerrainOffsetX - 40.96
    local v1084 = (v1081[2] - v1080) * v1078 + p1072.TerrainOffsetY - 40.96
    local v1085 = Vector3.new(v1083, 0, v1084)
    local v1086 = (v1082[1] - v1079) * v1078 + p1072.TerrainOffsetX - 40.96
    local v1087 = (v1082[2] - v1080) * v1078 + p1072.TerrainOffsetY - 40.96
    local v1088 = Vector3.new(v1086, 0, v1087)
    local v1089 = p1072.Memory[p1073][p1074]
    if v1089 then
        v1089 = p1072.Memory[p1073][p1074].Terrain
    end
    local v1090 = p1072.Memory[p1073][p1075]
    if v1090 then
        v1090 = p1072.Memory[p1073][p1075].Terrain
    end
    local v1091 = {}
    local v1092 = {}
    local v1093 = p1072.LODTerrainMemory[p1074]
    local v1094 = p1072.LODTerrainMemory[p1075]
    if v1089 and (v1090 and (v1093 and v1094)) then
        local v1095 = v1078 * 0.015625
        if p1076 == "Ver" then
            for v1096 = 1, 64 / v1093 do
                local v1097 = v1096 * v1093
                local v1098 = (v1097 - v1093) * 64 + v1093
                local v1099 = RecreateElement(v1089, v1098, 1) * 0.3328
                local v1100 = math.max(v1099, -1)
                local v1101 = {
                    ["P"] = v1085 + Vector3.new(v1093, v1100, v1097) * Vector3.new(v1095, 1, v1095),
                    ["C"] = Color3.fromRGB(RecreateElement(v1089, v1098, 2), RecreateElement(v1089, v1098, 3), RecreateElement(v1089, v1098, 4))
                }
                table.insert(v1091, v1101)
            end
            for v1102 = 1, 64 / v1094 do
                local v1103 = v1102 * v1094
                local v1104 = (v1103 - v1094) * 64 + 64
                local v1105 = RecreateElement(v1090, v1104, 1) * 0.3328
                local v1106 = math.max(v1105, -1)
                local v1107 = {
                    ["P"] = v1088 + Vector3.new(64, v1106, v1103) * Vector3.new(v1095, 1, v1095),
                    ["C"] = Color3.fromRGB(RecreateElement(v1090, v1104, 2), RecreateElement(v1090, v1104, 3), RecreateElement(v1090, v1104, 4))
                }
                table.insert(v1092, v1107)
            end
        elseif p1076 == "Hor" then
            for v1108 = 1, 64 / v1093 do
                local v1109 = v1108 * v1093
                local v1110 = (v1093 - v1093) * 64 + v1109
                local v1111 = RecreateElement(v1089, v1110, 1) * 0.3328
                local v1112 = math.max(v1111, -1)
                local v1113 = {
                    ["P"] = v1085 + Vector3.new(v1109, v1112, v1093) * Vector3.new(v1095, 1, v1095),
                    ["C"] = Color3.fromRGB(RecreateElement(v1089, v1110, 2), RecreateElement(v1089, v1110, 3), RecreateElement(v1089, v1110, 4))
                }
                table.insert(v1091, v1113)
            end
            for v1114 = 1, 64 / v1094 do
                local v1115 = v1114 * v1094
                local v1116 = (64 - v1094) * 64 + v1115
                local v1117 = RecreateElement(v1090, v1116, 1) * 0.3328
                local v1118 = math.max(v1117, -1)
                local v1119 = {
                    ["P"] = v1088 + Vector3.new(v1115, v1118, 64) * Vector3.new(v1095, 1, v1095),
                    ["C"] = Color3.fromRGB(RecreateElement(v1090, v1116, 2), RecreateElement(v1090, v1116, 3), RecreateElement(v1090, v1116, 4))
                }
                table.insert(v1092, v1119)
            end
        end
        local v1120 = Instance.new("Model")
        local v1121 = math.max(v1093, v1094)
        if #v1091 == #v1092 then
            for v1122 = 1, 64 / v1121 - 1 do
                local v1123 = v1091[v1122].P
                local v1124 = v1091[v1122 + 1].P
                local v1125 = v1092[v1122 + 1].P
                local v1126 = v1092[v1122].P
                local v1127 = v1092[v1122 + 1].P
                local v1128 = v1091[v1122].P
                if v1123.Y > 0 or (v1124.Y > 0 or v1125.Y > 0) then
                    p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1123)).p, (u10 * CFrame.new(v1124)).p, (u10 * CFrame.new(v1125)).p, p1072:ShiftTerrainColor(v1092[v1122].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                    p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                    if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                        v1120.Parent = p1077
                        debug.profileend()
                        v1120 = Instance.new("Model")
                        debug.profilebegin("StitchLines")
                        p1072.Tickers.TerrainLoad = 0
                    end
                end
                if v1126.Y > 0 or (v1127.Y > 0 or v1128.Y > 0) then
                    p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1126)).p, (u10 * CFrame.new(v1127)).p, (u10 * CFrame.new(v1128)).p, p1072:ShiftTerrainColor(v1092[v1122].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                    p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                    if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                        v1120.Parent = p1077
                        debug.profileend()
                        v1120 = Instance.new("Model")
                        debug.profilebegin("StitchLines")
                        p1072.Tickers.TerrainLoad = 0
                    end
                end
            end
        else
            if #v1092 <= #v1091 then
                local v1129 = v1091
                v1091 = v1092
                v1092 = v1129
            end
            if #v1092 > #v1091 * 2 then
                local v1130 = v1092[1].P
                local v1131 = v1092[2].P
                local v1132 = v1091[1].P
                local v1133 = v1092[2].P
                local v1134 = v1092[3].P
                local v1135 = v1091[1].P
                local v1136 = v1092[3].P
                local v1137 = v1092[4].P
                local v1138 = v1091[1].P
                if v1130.Y > 0 or (v1131.Y > 0 or v1132.Y > 0) then
                    p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1130)).p, (u10 * CFrame.new(v1131)).p, (u10 * CFrame.new(v1132)).p, p1072:ShiftTerrainColor(v1092[1].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                    p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                    if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                        v1120.Parent = p1077
                        debug.profileend()
                        v1120 = Instance.new("Model")
                        debug.profilebegin("StitchLines")
                        p1072.Tickers.TerrainLoad = 0
                    end
                end
                if v1133.Y > 0 or (v1134.Y > 0 or v1135.Y > 0) then
                    p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1133)).p, (u10 * CFrame.new(v1134)).p, (u10 * CFrame.new(v1135)).p, p1072:ShiftTerrainColor(v1092[2].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                    p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                    if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                        v1120.Parent = p1077
                        debug.profileend()
                        v1120 = Instance.new("Model")
                        debug.profilebegin("StitchLines")
                        p1072.Tickers.TerrainLoad = 0
                    end
                end
                if v1136.Y > 0 or (v1137.Y > 0 or v1138.Y > 0) then
                    p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1136)).p, (u10 * CFrame.new(v1137)).p, (u10 * CFrame.new(v1138)).p, p1072:ShiftTerrainColor(v1092[3].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                    p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                    if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                        v1120.Parent = p1077
                        debug.profileend()
                        v1120 = Instance.new("Model")
                        debug.profilebegin("StitchLines")
                        p1072.Tickers.TerrainLoad = 0
                    end
                end
                for v1139 = 1, #v1091 - 1 do
                    local v1140 = v1092[v1139 * 4 + 0].P
                    local v1141 = v1092[v1139 * 4 + 1].P
                    local v1142 = v1091[v1139].P
                    local v1143 = v1092[v1139 * 4 + 1].P
                    local v1144 = v1092[v1139 * 4 + 2].P
                    local v1145 = v1091[v1139].P
                    local v1146 = v1091[v1139].P
                    local v1147 = v1091[v1139 + 1].P
                    local v1148 = v1092[v1139 * 4 + 2].P
                    local v1149 = v1092[v1139 * 4 + 2].P
                    local v1150 = v1092[v1139 * 4 + 3].P
                    local v1151 = v1091[v1139 + 1].P
                    local v1152 = v1092[v1139 * 4 + 3].P
                    local v1153 = v1092[v1139 * 4 + 4].P
                    local v1154 = v1091[v1139 + 1].P
                    if v1140.Y > 0 or (v1141.Y > 0 or v1142.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1140)).p, (u10 * CFrame.new(v1141)).p, (u10 * CFrame.new(v1142)).p, p1072:ShiftTerrainColor(v1092[v1139 * 4 + 0].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                    if v1143.Y > 0 or (v1144.Y > 0 or v1145.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1143)).p, (u10 * CFrame.new(v1144)).p, (u10 * CFrame.new(v1145)).p, p1072:ShiftTerrainColor(v1092[v1139 * 4 + 1].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                    if v1146.Y > 0 or (v1147.Y > 0 or v1148.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1146)).p, (u10 * CFrame.new(v1147)).p, (u10 * CFrame.new(v1148)).p, p1072:ShiftTerrainColor(v1091[v1139].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                    if v1149.Y > 0 or (v1150.Y > 0 or v1151.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1149)).p, (u10 * CFrame.new(v1150)).p, (u10 * CFrame.new(v1151)).p, p1072:ShiftTerrainColor(v1092[v1139 * 4 + 2].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                    if v1152.Y > 0 or (v1153.Y > 0 or v1154.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1152)).p, (u10 * CFrame.new(v1153)).p, (u10 * CFrame.new(v1154)).p, p1072:ShiftTerrainColor(v1092[v1139 * 4 + 3].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                end
            else
                local v1155 = v1092[1].P
                local v1156 = v1092[2].P
                local v1157 = v1091[1].P
                if v1155.Y > 0 or (v1156.Y > 0 or v1157.Y > 0) then
                    p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1155)).p, (u10 * CFrame.new(v1156)).p, (u10 * CFrame.new(v1157)).p, p1072:ShiftTerrainColor(v1092[1].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                    p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                    if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                        v1120.Parent = p1077
                        debug.profileend()
                        v1120 = Instance.new("Model")
                        debug.profilebegin("StitchLines")
                        p1072.Tickers.TerrainLoad = 0
                    end
                end
                for v1158 = 1, #v1091 - 1 do
                    local v1159 = v1092[v1158 * 2].P
                    local v1160 = v1092[v1158 * 2 + 1].P
                    local v1161 = v1091[v1158].P
                    local v1162 = v1091[v1158].P
                    local v1163 = v1091[v1158 + 1].P
                    local v1164 = v1092[v1158 * 2 + 1].P
                    local v1165 = v1092[v1158 * 2 + 1].P
                    local v1166 = v1092[v1158 * 2 + 2].P
                    local v1167 = v1091[v1158 + 1].P
                    if v1159.Y > 0 or (v1160.Y > 0 or v1161.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1159)).p, (u10 * CFrame.new(v1160)).p, (u10 * CFrame.new(v1161)).p, p1072:ShiftTerrainColor(v1092[v1158 * 2].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                    if v1162.Y > 0 or (v1163.Y > 0 or v1164.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1162)).p, (u10 * CFrame.new(v1163)).p, (u10 * CFrame.new(v1164)).p, p1072:ShiftTerrainColor(v1091[v1158].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                    if v1165.Y > 0 or (v1166.Y > 0 or v1167.Y > 0) then
                        p1072.Tickers.TerrainParts = p1072.Tickers.TerrainParts + u2:Triangle((u10 * CFrame.new(v1165)).p, (u10 * CFrame.new(v1166)).p, (u10 * CFrame.new(v1167)).p, p1072:ShiftTerrainColor(v1092[v1158 * 2 + 1].C), v1120, 1, p1072.RenderSettings.TerrainShadows, p1072.RenderSettings.TerrainTextures)
                        p1072.Tickers.TerrainLoad = p1072.Tickers.TerrainLoad + 1
                        if p1072.Tickers.TerrainLoad > p1072.RenderSettings.LoadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("NewChunk_TerrainSeam_" .. p1073)
                            v1120.Parent = p1077
                            debug.profileend()
                            v1120 = Instance.new("Model")
                            debug.profilebegin("StitchLines")
                            p1072.Tickers.TerrainLoad = 0
                        end
                    end
                end
            end
        end
        v1120.Parent = p1077
    end
    debug.profileend()
end
function u8.BuildSeams(p1168, p1169, p1170, p1171) --[[ Line: 2923 ]]
    debug.profilebegin("BuildSeams")
    local v1172 = string.split(p1170, "_")
    local v1173 = v1172[1] + 1 .. "_" .. v1172[2]
    local v1174 = v1172[1] - 1 .. "_" .. v1172[2]
    local v1175 = v1172[1] .. "_" .. v1172[2] - 1
    local v1176 = v1172[1] .. "_" .. v1172[2] + 1
    local v1177 = v1172[1] + 1 .. "_" .. v1172[2] - 1
    local v1178 = v1172[1] + 1 .. "_" .. v1172[2] + 1
    local v1179 = v1172[1] - 1 .. "_" .. v1172[2] - 1
    local v1180 = v1172[1] - 1 .. "_" .. v1172[2] + 1
    if p1168.TileModels[p1169][v1173] and (p1168.TileModels[p1169][v1173].Terrain and not (p1168.TileModels[p1169][v1173].Seams and p1168.TileModels[p1169][v1173].Seams[p1170])) then
        if not p1168.TileModels[p1169][p1170].Seams[v1173] then
            local v1181 = Instance.new("Model")
            v1181.Name = "SeamLine"
            v1181.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams[v1173] = v1181
        end
        debug.profileend()
        p1168:StitchLines(p1169, v1173, p1170, "Ver", p1168.TileModels[p1169][p1170].Seams[v1173])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1174] and (p1168.TileModels[p1169][v1174].Terrain and not (p1168.TileModels[p1169][v1174].Seams and p1168.TileModels[p1169][v1174].Seams[p1170])) then
        if not p1168.TileModels[p1169][p1170].Seams[v1174] then
            local v1182 = Instance.new("Model")
            v1182.Name = "SeamLine"
            v1182.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams[v1174] = v1182
        end
        debug.profileend()
        p1168:StitchLines(p1169, p1170, v1174, "Ver", p1168.TileModels[p1169][p1170].Seams[v1174])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1175] and (p1168.TileModels[p1169][v1175].Terrain and not (p1168.TileModels[p1169][v1175].Seams and p1168.TileModels[p1169][v1175].Seams[p1170])) then
        if not p1168.TileModels[p1169][p1170].Seams[v1175] then
            local v1183 = Instance.new("Model")
            v1183.Name = "SeamLine"
            v1183.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams[v1175] = v1183
        end
        debug.profileend()
        p1168:StitchLines(p1169, p1170, v1175, "Hor", p1168.TileModels[p1169][p1170].Seams[v1175])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1176] and (p1168.TileModels[p1169][v1176].Terrain and not (p1168.TileModels[p1169][v1176].Seams and p1168.TileModels[p1169][v1176].Seams[p1170])) then
        if not p1168.TileModels[p1169][p1170].Seams[v1176] then
            local v1184 = Instance.new("Model")
            v1184.Name = "SeamLine"
            v1184.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams[v1176] = v1184
        end
        debug.profileend()
        p1168:StitchLines(p1169, v1176, p1170, "Hor", p1168.TileModels[p1169][p1170].Seams[v1176])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1175] and (p1168.TileModels[p1169][v1173] and (p1168.TileModels[p1169][v1177] and (p1168.TileModels[p1169][v1175].Terrain and (p1168.TileModels[p1169][v1173].Terrain and (p1168.TileModels[p1169][v1177].Terrain and not (p1168.TileModels[p1169][v1177].Seams and p1168.TileModels[p1169][v1177].Seams["C" .. p1170])))))) then
        if not p1168.TileModels[p1169][p1170].Seams["C" .. v1177] then
            local v1185 = Instance.new("Model")
            v1185.Name = "CubeSeam"
            v1185.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams["C" .. v1177] = v1185
            if not p1168.TileModels[p1169][v1173].Seams then
                p1168.TileModels[p1169][v1173].Seams = {}
            end
            if not p1168.TileModels[p1169][v1175].Seams then
                p1168.TileModels[p1169][v1175].Seams = {}
            end
            p1168.TileModels[p1169][p1170].Seams["C" .. v1173] = v1185
            p1168.TileModels[p1169][p1170].Seams["C" .. v1175] = v1185
        end
        debug.profileend()
        p1168:Cube(p1169, p1170, v1175, v1177, v1173, p1168.TileModels[p1169][p1170].Seams["C" .. v1177])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1176] and (p1168.TileModels[p1169][v1173] and (p1168.TileModels[p1169][v1178] and (p1168.TileModels[p1169][v1176].Terrain and (p1168.TileModels[p1169][v1173].Terrain and (p1168.TileModels[p1169][v1178].Terrain and not (p1168.TileModels[p1169][v1178].Seams and p1168.TileModels[p1169][v1178].Seams["C" .. p1170])))))) then
        if not p1168.TileModels[p1169][p1170].Seams["C" .. v1178] then
            local v1186 = Instance.new("Model")
            v1186.Name = "CubeSeam"
            v1186.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams["C" .. v1178] = v1186
            if not p1168.TileModels[p1169][v1176].Seams then
                p1168.TileModels[p1169][v1176].Seams = {}
            end
            if not p1168.TileModels[p1169][v1173].Seams then
                p1168.TileModels[p1169][v1173].Seams = {}
            end
            p1168.TileModels[p1169][p1170].Seams["C" .. v1176] = v1186
            p1168.TileModels[p1169][p1170].Seams["C" .. v1173] = v1186
        end
        debug.profileend()
        p1168:Cube(p1169, v1176, p1170, v1173, v1178, p1168.TileModels[p1169][p1170].Seams["C" .. v1178])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1175] and (p1168.TileModels[p1169][v1174] and (p1168.TileModels[p1169][v1179] and (p1168.TileModels[p1169][v1175].Terrain and (p1168.TileModels[p1169][v1174].Terrain and (p1168.TileModels[p1169][v1179].Terrain and not (p1168.TileModels[p1169][v1179].Seams and p1168.TileModels[p1169][v1179].Seams["C" .. p1170])))))) then
        if not p1168.TileModels[p1169][p1170].Seams["C" .. v1179] then
            local v1187 = Instance.new("Model")
            v1187.Name = "CubeSeam"
            v1187.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams["C" .. v1179] = v1187
            if not p1168.TileModels[p1169][v1174].Seams then
                p1168.TileModels[p1169][v1174].Seams = {}
            end
            if not p1168.TileModels[p1169][v1175].Seams then
                p1168.TileModels[p1169][v1175].Seams = {}
            end
            p1168.TileModels[p1169][p1170].Seams["C" .. v1174] = v1187
            p1168.TileModels[p1169][p1170].Seams["C" .. v1175] = v1187
        end
        debug.profileend()
        p1168:Cube(p1169, v1174, v1179, v1175, p1170, p1168.TileModels[p1169][p1170].Seams["C" .. v1179])
        debug.profilebegin("BuildSeams")
    end
    if p1168.TileModels[p1169][v1176] and (p1168.TileModels[p1169][v1174] and (p1168.TileModels[p1169][v1180] and (p1168.TileModels[p1169][v1176].Terrain and (p1168.TileModels[p1169][v1174].Terrain and (p1168.TileModels[p1169][v1180].Terrain and not (p1168.TileModels[p1169][v1180].Seams and p1168.TileModels[p1169][v1180].Seams["C" .. p1170])))))) then
        if not p1168.TileModels[p1169][p1170].Seams["C" .. v1180] then
            local v1188 = Instance.new("Model")
            v1188.Name = "CubeSeam"
            v1188.Parent = p1171
            p1168.TileModels[p1169][p1170].Seams["C" .. v1180] = v1188
            if not p1168.TileModels[p1169][v1174].Seams then
                p1168.TileModels[p1169][v1174].Seams = {}
            end
            if not p1168.TileModels[p1169][v1176].Seams then
                p1168.TileModels[p1169][v1176].Seams = {}
            end
            p1168.TileModels[p1169][p1170].Seams["C" .. v1174] = v1188
            p1168.TileModels[p1169][p1170].Seams["C" .. v1176] = v1188
        end
        debug.profileend()
        p1168:Cube(p1169, v1180, v1174, p1170, v1176, p1168.TileModels[p1169][p1170].Seams["C" .. v1180])
        debug.profilebegin("BuildSeams")
    end
    debug.profileend()
end
function u8.RefreshTile(p1189, p1190, p1191, p1192, p1193, p1194) --[[ Line: 3094 ]]
    if p1190 and p1190[p1192] then
        debug.profilebegin("RefreshTile" .. p1192)
        if not p1189.TileModels[p1193][p1191] then
            p1189.TileModels[p1193][p1191] = {}
        end
        if not p1189.TileModels[p1193][p1191].TileModel then
            local v1195 = Instance.new("Model")
            v1195.Name = p1191
            if p1192 == "Terrain" then
                v1195.Parent = workspace.Map.Terrain
            else
                v1195.Parent = workspace.Map
            end
            p1189.TileModels[p1193][p1191].TileModel = v1195
        end
        if p1192 == "Buildings" then
            if not p1189.TileModels[p1193][p1191][p1192] then
                local v1196 = Instance.new("Model")
                v1196.Name = p1192
                v1196.Parent = p1189.TileModels[p1193][p1191].TileModel
                p1189.TileModels[p1193][p1191][p1192] = v1196
            end
            debug.profileend()
            local v1197 = math.pow(2, p1193) / 4096
            local v1198 = string.split(p1191, "_")
            local v1199 = v1198[1] / v1197
            local v1200 = math.floor(v1199)
            local v1201 = v1198[2] / v1197
            local v1202 = v1200 .. "_" .. math.floor(v1201)
            p1189:BuildBuildings(p1190[p1192], p1189.TileModels[p1193][p1191][p1192], p1193, p1189.EleTerrainMemory[v1202][1], p1189.EleTerrainMemory[v1202][2])
            if p1189.Tickers.TreeParts < p1189.RenderSettings.MaxTreeParts and p1189.TileModels[p1193][p1191] then
                p1189:BuildTrees(p1189.TileModels[p1193][p1191][p1192], p1191, p1193, p1194, p1189.EleTerrainMemory[v1202][1], p1189.EleTerrainMemory[v1202][2])
            end
            debug.profilebegin("RefreshTile" .. p1192)
            return
        end
        if p1192 == "Earth" then
            if not p1189.TileModels[p1193][p1191][p1192] then
                local v1203 = Instance.new("Model")
                v1203.Name = p1192
                v1203.Parent = workspace.Map.Terrain
                p1189.TileModels[p1193][p1191][p1192] = v1203
            end
            debug.profileend()
            p1189:BuildEarth(p1190[p1192], p1189.TileModels[p1193][p1191][p1192], p1191, p1193)
            debug.profilebegin("RefreshTile" .. p1192)
            return
        end
        if p1192 == "Roads" then
            if not p1189.TileModels[p1193][p1191][p1192] then
                local v1204 = Instance.new("Model")
                v1204.Name = p1192
                v1204.Parent = p1189.TileModels[p1193][p1191].TileModel
                p1189.TileModels[p1193][p1191][p1192] = v1204
            end
            debug.profileend()
            local v1205 = math.pow(2, p1193) / 4096
            local v1206 = string.split(p1191, "_")
            local v1207 = v1206[1] / v1205
            local v1208 = math.floor(v1207)
            local v1209 = v1206[2] / v1205
            local v1210 = v1208 .. "_" .. math.floor(v1209)
            p1189:BuildRoads(p1190[p1192], p1189.TileModels[p1193][p1191][p1192], p1189.EleTerrainMemory[v1210][1], p1189.EleTerrainMemory[v1210][2], p1193)
            debug.profilebegin("RefreshTile" .. p1192)
            return
        end
        if p1192 == "Airports" then
            if not p1189.TileModels[p1193][p1191][p1192] then
                local v1211 = Instance.new("Model")
                v1211.Name = p1192
                v1211.Parent = p1189.TileModels[p1193][p1191].TileModel
                p1189.TileModels[p1193][p1191][p1192] = v1211
            end
            debug.profileend()
            local v1212 = math.pow(2, p1193) / 4096
            local v1213 = string.split(p1191, "_")
            local v1214 = v1213[1] / v1212
            local v1215 = math.floor(v1214)
            local v1216 = v1213[2] / v1212
            local v1217 = v1215 .. "_" .. math.floor(v1216)
            p1189:BuildAirports(p1190[p1192], p1189.TileModels[p1193][p1191][p1192], p1189.EleTerrainMemory[v1217][1], p1189.EleTerrainMemory[v1217][2], p1193)
            debug.profilebegin("RefreshTile" .. p1192)
            return
        end
        if p1192 == "Terrain" then
            if not p1189.TileModels[p1193][p1191][p1192] then
                local v1218 = Instance.new("Model")
                v1218.Name = p1192
                v1218.Parent = p1189.TileModels[p1193][p1191].TileModel
                p1189.TileModels[p1193][p1191][p1192] = v1218
            end
            if not p1189.TileModels[p1193][p1191].Seams then
                p1189.TileModels[p1193][p1191].Seams = {}
            end
            if not p1189.TileModels[p1193][p1191].Seams.SeamModel then
                local v1219 = Instance.new("Model")
                v1219.Name = "Seams"
                v1219.Parent = p1189.TileModels[p1193][p1191].TileModel
                p1189.TileModels[p1193][p1191].Seams.SeamModel = v1219
            end
            p1189.LODTerrainMemory[p1191] = p1194
            debug.profileend()
            p1189.TerrainLoaded[p1191] = true
            p1189:LoadingNearBy(p1191, p1193, p1192, false, 1)
            p1189:LoadingNearBy(p1191, p1193, p1192, true, 0)
            p1189:BuildSeams(p1193, p1191, p1189.TileModels[p1193][p1191].Seams.SeamModel)
            p1189:BuildTerrain(p1190[p1192], p1189.TileModels[p1193][p1191][p1192], p1191, p1193, p1194)
            debug.profilebegin("RefreshTile" .. p1192)
            return
        end
        if p1192 == "POIs" then
            if not p1189.TileModels[p1193][p1191][p1192] then
                local v1220 = Instance.new("Model")
                v1220.Name = p1192
                v1220.Parent = p1189.TileModels[p1193][p1191].TileModel
                p1189.TileModels[p1193][p1191][p1192] = v1220
            end
            debug.profileend()
            local v1221 = math.pow(2, p1193) / 4096
            local v1222 = string.split(p1191, "_")
            local v1223 = v1222[1] / v1221
            local v1224 = math.floor(v1223)
            local v1225 = v1222[2] / v1221
            local v1226 = v1224 .. "_" .. math.floor(v1225)
            p1189:BuildPOIs(p1190[p1192], p1189.TileModels[p1193][p1191][p1192], p1189.EleTerrainMemory[v1226][1], p1189.EleTerrainMemory[v1226][2], p1193)
            debug.profilebegin("RefreshTile" .. p1192)
        end
    end
end
function DrawLine(p1227, p1228, p1229)
    local v1230 = (p1227 - p1228).magnitude
    local v1231 = Instance.new("Part")
    v1231.Anchored = true
    v1231.Size = Vector3.new(1, 1, v1230)
    v1231.CanCollide = false
    v1231.Color = p1229 or Color3.fromRGB(220, 100, 100)
    v1231.Material = Enum.Material.Neon
    v1231.CFrame = CFrame.new(p1227, p1228) * CFrame.new(0, 0, -v1230 / 2)
    v1231.Parent = workspace.Debug
end
function u8.VisTrap(_, p1232, p1233, p1234, p1235, p1236, p1237) --[[ Line: 3249 ]]
    DrawLine(p1232, p1233)
    DrawLine(p1233, p1234)
    DrawLine(p1234, p1235)
    DrawLine(p1235, p1232)
    for v1238 = 1, p1237 do
        local v1239 = p1232:lerp(p1235, (v1238 - 0.5) / p1237)
        local v1240 = p1233:lerp(p1234, (v1238 - 0.5) / p1237)
        DrawLine(v1239, v1240, Color3.fromRGB(100, 220, 255))
    end
    for v1241 = 1, p1236 do
        local v1242 = p1232:lerp(p1233, (v1241 - 0.5) / p1236)
        local v1243 = p1235:lerp(p1234, (v1241 - 0.5) / p1236)
        DrawLine(v1242, v1243, Color3.fromRGB(100, 220, 255))
    end
end
function u8.CreateGridPart(p1244, p1245, p1246, p1247) --[[ Line: 3267 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v1248 = 65536 / math.pow(2, p1247) * 51.2 * 3.2
    local v1249, v1250 = u5:ConvertLatLongToTile(-p1244.Lat, p1244.Lon, p1247)
    local v1251 = string.split(p1245, "_")
    local v1252 = script.GridPart:Clone()
    local v1253 = (v1251[1] - v1249) * v1248
    local v1254 = (v1251[2] - v1250) * v1248
    local v1255 = Vector3.new(v1253, 0, v1254)
    local v1256 = p1244.TerrainOffsetX * (2621.4400000000005 / v1248)
    local v1257 = p1244.TerrainOffsetY * (2621.4400000000005 / v1248)
    local v1258 = v1255 + Vector3.new(v1256, 0, v1257)
    v1252.Size = Vector3.new(v1248, 1, v1248)
    print("gridsize", v1252.Size)
    v1252.CFrame = CFrame.new(v1258)
    v1252.Color = p1246 or Color3.fromRGB(220, 100, 100)
    v1252.Parent = workspace.Debug
    return v1252
end
function u8.GetTerrainTiles(p1259, p1260) --[[ Line: 3284 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v1261 = 65536 / math.pow(2, p1260) * 51.2 * 3.2
    local v1262 = workspace.CurrentCamera.CFrame
    local _ = p1259.Recentering == true
    local v1263 = v1262.p
    local v1264, v1265 = u5:ConvertLatLongToTile(-p1259.Lat, p1259.Lon, p1260)
    local v1266 = Vector2.new
    local v1267 = v1263.X / v1261
    local v1268 = v1264 + math.floor(v1267)
    local v1269 = v1263.Z / v1261
    local v1270 = v1266(v1268, v1265 + math.floor(v1269))
    local v1271 = {}
    for v1272 = v1270.X - 1 - 10, v1270.X + 10 do
        for v1273 = v1270.Y - 1 - 10, v1270.Y + 10 do
            local v1274 = (Vector2.new(v1270.X, v1270.Y) - Vector2.new(v1272, v1273)).magnitude / 2
            local v1275 = { v1272, v1273, (math.clamp(v1274, 0, 5)) }
            table.insert(v1271, v1275)
        end
    end
    table.sort(v1271, function(p1276, p1277) --[[ Line: 3308 ]]
        return p1276[3] < p1277[3]
    end)
    return v1271
end
local u1278 = Vector3.new()
local u1279 = tick()
function u8.RefreshCamVel(p1280) --[[ Line: 3316 ]]
    --[[
    Upvalues:
        [1] = u1278
        [2] = u1279
    --]]
    local v1281 = tick()
    local v1282 = workspace.CurrentCamera.CFrame
    local _ = p1280.Recentering == true
    local v1283 = v1282.p
    local v1284 = Vector3.new()
    if v1283 == u1278 or not (v1283 and v1283.Y) then
        p1280.CamVel = v1284
    else
        local v1285 = (v1283 - u1278) / (v1281 - u1279)
        local v1286 = v1285.Unit
        local v1287 = v1285.magnitude
        local v1288 = v1286 * math.min(v1287, 50)
        local v1289 = v1283.Y / 20
        local v1290 = math.abs(v1289)
        p1280.CamVel = v1288 * math.clamp(v1290, 15, 400)
    end
    u1279 = v1281
    u1278 = v1283
end
function u8.GetViewportTiles(p1291, p1292) --[[ Line: 3343 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
    --]]
    tick()
    debug.profilebegin("GetViewportTiles:" .. p1292)
    local v1293 = 65536 / math.pow(2, p1292) * 51.2 * 3.2
    local v1294 = {}
    local v1295 = {}
    local v1296 = workspace.CurrentCamera.CFrame
    local _ = p1291.Recentering == true
    local v1297 = v1296.p
    local v1298 = p1291.TerrainOffsetX * (v1293 / 2621.4400000000005)
    local v1299 = p1291.TerrainOffsetY * (v1293 / 2621.4400000000005)
    local v1300 = v1297 - Vector3.new(v1298, 0, v1299)
    local v1301, v1302 = u5:ConvertLatLongToTile(-p1291.Lat, p1291.Lon, p1292)
    local _ = workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y
    local _ = workspace.CurrentCamera.FieldOfView * 1.2 / 2
    local v1303 = {}
    local v1304 = p1291.RenderSettings.TerrainMaxRadius * 528
    if p1292 == 14 then
        v1304 = p1291.RenderSettings.DetailsMaxRadius * 528
    end
    local v1305 = 0.5773502691896257 * v1304
    local v1306 = p1291.CamVel / 2
    local v1307 = (v1300.X + v1306.X) / v1293
    local v1308 = v1301 + math.floor(v1307)
    local v1309 = (v1300.Z + v1306.Z) / v1293
    local v1310 = v1302 + math.floor(v1309)
    local v1311 = Vector3.new(v1308, 0, v1310)
    local v1312 = workspace.Debug:GetChildren()
    for v1313 = 1, #v1312 do
        v1312[v1313]:Destroy()
    end
    for v1314 = -2, 2 do
        for v1315 = -2, 2 do
            local v1316 = v1311.X + v1314 .. "_" .. v1311.Z + v1315
            if not v1294[v1316] then
                v1294[v1316] = true
                local v1317 = v1311.X + v1314
                local v1318 = v1311.Z + v1315
                local v1319 = Vector3.new(v1317, 0, v1318)
                local v1320 = (v1300.X + v1306.X) / v1293
                local v1321 = v1301 + math.floor(v1320)
                local v1322 = v1300.Y / 1000
                local v1323 = math.floor(v1322)
                local v1324 = (v1300.Z + v1306.Z) / v1293
                local v1325 = v1302 + math.floor(v1324)
                local v1326 = (v1319 - Vector3.new(v1321, v1323, v1325)).magnitude - 1
                local v1327 = { v1311.X + v1314, v1311.Z + v1315, v1326 }
                table.insert(v1295, v1327)
                local v1328 = v1311.X + v1314 .. "_" .. v1311.Z + v1315
                table.insert(v1303, v1328)
            end
        end
    end
    for v1329 = -1, 1 do
        local v1330 = CFrame.new
        local v1331 = p1291.LastYaw + v1329 * 60
        local v1332 = math.rad(v1331)
        local v1333 = math.cos(v1332)
        local v1334 = p1291.LastYaw + v1329 * 60
        local v1335 = math.rad(v1334)
        local v1336 = math.sin(v1335)
        local v1337 = v1330(v1300, v1300 + Vector3.new(v1333, 0, v1336) * v1304) * CFrame.new(-v1305, 0, -v1304).p
        local v1338 = CFrame.new
        local v1339 = p1291.LastYaw + v1329 * 60
        local v1340 = math.rad(v1339)
        local v1341 = math.cos(v1340)
        local v1342 = p1291.LastYaw + v1329 * 60
        local v1343 = math.rad(v1342)
        local v1344 = math.sin(v1343)
        local v1345 = v1338(v1300, v1300 + Vector3.new(v1341, 0, v1344) * v1304) * CFrame.new(v1305, 0, -v1304).p
        local v1346 = 2 * (v1304 / v1293) * 2
        local v1347 = 2 * (v1304 / v1293)
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("GetViewportTiles:" .. p1292)
        local v1348 = v1300
        local v1349 = v1348
        local v1350 = v1348
        v1348 = v1349
        v1350 = v1349
        for v1351 = 1, v1347 do
            if v1351 % 4 == 0 then
                debug.profileend()
                u9.Stepped:wait()
                debug.profilebegin("GetViewportTiles:" .. p1292)
            end
            local v1352 = v1349:lerp(v1337, (v1351 - 0.5) / v1347)
            local v1353 = v1348:lerp(v1345, (v1351 - 0.5) / v1347)
            for v1354 = 0, v1346 / 2 do
                local v1355 = v1352:lerp(v1353, 0.5 - v1354 / v1346)
                local v1356 = v1355.X / v1293
                local v1357 = v1301 + math.floor(v1356)
                local v1358 = v1355.Z / v1293
                local v1359 = v1302 + math.floor(v1358)
                local v1360 = Vector3.new(v1357, 0, v1359)
                local v1361 = v1360.X .. "_" .. v1360.Z
                if not v1294[v1361] then
                    v1294[v1361] = true
                    local v1362 = v1360.X
                    local v1363 = v1360.Z
                    local v1364 = Vector3.new(v1362, 0, v1363)
                    local v1365 = (v1300.X + v1306.X) / v1293
                    local v1366 = v1301 + math.floor(v1365)
                    local v1367 = v1300.Y / 1000
                    local v1368 = math.floor(v1367)
                    local v1369 = (v1300.Z + v1306.Z) / v1293
                    local v1370 = v1302 + math.floor(v1369)
                    local v1371 = (v1364 - Vector3.new(v1366, v1368, v1370)).magnitude - 1
                    local v1372 = { v1360.X, v1360.Z, v1371 }
                    table.insert(v1295, v1372)
                    local v1373 = v1360.X .. "_" .. v1360.Z
                    table.insert(v1303, v1373)
                end
                if v1354 ~= 0 then
                    local v1374 = v1352:lerp(v1353, 0.5 + v1354 / v1346)
                    local v1375 = v1374.X / v1293
                    local v1376 = v1301 + math.floor(v1375)
                    local v1377 = v1374.Z / v1293
                    local v1378 = v1302 + math.floor(v1377)
                    local v1379 = Vector3.new(v1376, 0, v1378)
                    local v1380 = v1379.X .. "_" .. v1379.Z
                    if not v1294[v1380] then
                        v1294[v1380] = true
                        local v1381 = v1379.X
                        local v1382 = v1379.Z
                        local v1383 = Vector3.new(v1381, 0, v1382)
                        local v1384 = (v1300.X + v1306.X) / v1293
                        local v1385 = v1301 + math.floor(v1384)
                        local v1386 = v1300.Y / 1000
                        local v1387 = math.floor(v1386)
                        local v1388 = (v1300.Z + v1306.Z) / v1293
                        local v1389 = v1302 + math.floor(v1388)
                        local v1390 = (v1383 - Vector3.new(v1385, v1387, v1389)).magnitude - 1
                        local v1391 = { v1379.X, v1379.Z, v1390 }
                        table.insert(v1295, v1391)
                        local v1392 = v1379.X .. "_" .. v1379.Z
                        table.insert(v1303, v1392)
                    end
                end
            end
        end
    end
    local v1393 = {}
    for v1394 = 1, #v1303 do
        v1393[v1303[v1394]] = true
    end
    p1291.NearestCheckTiles[p1292] = v1393
    table.sort(v1295, function(p1395, p1396) --[[ Line: 3462 ]]
        return p1395[3] < p1396[3]
    end)
    p1291.NearestTiles[p1292] = v1295
    debug.profileend()
end
function u8.UnloadLua(p1397, p1398, p1399) --[[ Line: 3494 ]]
    debug.profilebegin("UnloadLua," .. p1398)
    local v1400 = 0
    local v1401 = {}
    for v1402, v1403 in pairs(p1397.MemoryLastUsed[p1398]) do
        v1400 = v1400 + 1
        if not (p1397.TileModels[p1398][v1402] or p1397.UnloadingTiles[p1398][v1402] and (p1397.UnloadingTiles[p1398][v1402].Terrain or (p1397.UnloadingTiles[p1398][v1402].Roads or (p1397.UnloadingTiles[p1398][v1402].Buildings or p1397.UnloadingTiles[p1398][v1402].Airports))) or p1397.LoadingTiles[p1398][v1402] and (p1397.LoadingTiles[p1398][v1402].Terrain or (p1397.LoadingTiles[p1398][v1402].Roads or (p1397.LoadingTiles[p1398][v1402].Buildings or p1397.LoadingTiles[p1398][v1402].Airports)))) then
            table.insert(v1401, { v1402, v1403 })
        end
    end
    if #v1401 > 0 then
        table.sort(v1401, function(p1404, p1405) --[[ Line: 3535 ]]
            return p1404[2] < p1405[2]
        end)
    end
    local v1406 = v1400 - p1397.RenderSettings.MaxMemDetailsTiles
    if p1399 == "Terrain" then
        v1406 = v1400 - p1397.RenderSettings.MaxMemTerrainTiles
        p1397.Tickers.MemTerrainTiles = v1400
    else
        p1397.Tickers.MemDetailsTiles = v1400
    end
    local v1407 = math.clamp(v1406, 0, 10)
    local v1408 = game:GetService("Stats"):GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.LuaHeap) > p1397.RenderSettings.MaxLuaHeapMemory * 0.8 and 2 or v1407
    local v1409 = v1400 < 20 and 0 or v1408
    local v1410 = #v1401
    for v1411 = 1, math.clamp(v1409, 0, v1410) do
        p1397.MemoryLastUsed[p1398][v1401[v1411][1]] = nil
        p1397.Memory[p1398][v1401[v1411][1]] = nil
    end
    debug.profileend()
end
function u8.DataShow(p1412, p1413) --[[ Line: 3559 ]]
    local v1414 = 0
    for _, _ in pairs(p1412.MemoryLastUsed[p1413]) do
        v1414 = v1414 + 1
    end
    local v1415 = 0
    for _, _ in pairs(p1412.Memory[p1413]) do
        v1415 = v1415 + 1
    end
    local v1416 = 0
    for _, _ in pairs(p1412.TileModels[p1413]) do
        v1416 = v1416 + 1
    end
    local v1417 = 0
    for _, _ in pairs(p1412.UnloadingTiles[p1413]) do
        v1417 = v1417 + 1
    end
    local v1418 = 0
    for _, _ in pairs(p1412.LoadingTiles[p1413]) do
        v1418 = v1418 + 1
    end
end
function u8.GrabData(p1419, p1420, p1421) --[[ Line: 3588 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("GrabData," .. p1421)
    local v1422 = p1419.NearestTiles[p1420]
    local v1423 = true
    if v1422 then
        for v1424 = 1, #v1422 do
            if v1424 % 10 == 0 then
                debug.profileend()
                u9.Stepped:wait()
                debug.profilebegin("GrabData," .. p1421)
            end
            if v1422 == p1419.NearestTiles[p1420] and not p1419.Stopped then
                local v1425 = v1422[v1424][1] .. "_" .. v1422[v1424][2]
                local v1426
                if p1421 == "Terrain" then
                    v1426 = nil
                else
                    local v1427 = math.pow(2, p1420) / 4096
                    local v1428 = v1422[v1424][1] / v1427
                    local v1429 = math.floor(v1428)
                    local v1430 = v1422[v1424][2] / v1427
                    v1426 = v1429 .. "_" .. math.floor(v1430)
                end
                if not (p1419.Memory[p1420][v1425] and p1419.Memory[p1420][v1425][p1421]) and ((not p1419.TileModels[p1420][v1425] or (not p1419.TileModels[p1420][v1425][p1421] or p1421 == "Terrain" and not p1419:TerrainLoadedNearBy(v1425))) and (not p1419.FetchingData[p1420][v1425] and (p1421 == "Terrain" or (p1421 == "Earth" or p1419:TerrainLoadedNearBy(v1426))))) then
                    p1419:UnloadLua(p1420, p1421)
                    if game:GetService("Stats"):GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.LuaHeap) < p1419.RenderSettings.MaxLuaHeapMemory then
                        if not p1419.Memory[p1420][v1425] then
                            p1419.Memory[p1420][v1425] = {}
                        end
                        p1419.MemoryLastUsed[p1420][v1425] = tick()
                        if not p1419.Memory[p1420][v1425][p1421] then
                            p1419.FetchingData[p1420][v1425] = true
                            debug.profileend()
                            p1419.Memory[p1420][v1425][p1421] = game.ReplicatedStorage.MapRemotes.GetData:InvokeServer(p1420, v1425, p1421)
                            debug.profilebegin("GrabData," .. p1421)
                            p1419.FetchingData[p1420][v1425] = nil
                            if p1419.Memory[p1420][v1425] and p1419.Memory[p1420][v1425][p1421] then
                                v1423 = false
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    if v1423 then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("GrabData," .. p1421)
    end
    debug.profileend()
end
function u8.PrepareForUpdate(p1431, p1432, p1433, p1434) --[[ Line: 3644 ]]
    debug.profilebegin("PrepareForUpdate")
    local v1435 = Instance.new("Model")
    v1435.Name = "Buffer"
    v1435.Parent = workspace.MapBuffers
    local v1436 = p1433.Terrain:GetChildren()
    for v1437 = 1, #v1436 do
        v1436[v1437].Parent = v1435
    end
    if p1433.Seams and p1433.Seams.SeamModel then
        local v1438 = p1433.Seams.SeamModel:GetChildren()
        for v1439 = 1, #v1438 do
            local v1440 = v1438[v1439]:GetChildren()
            for v1441 = 1, #v1440 do
                v1440[v1441].Parent = v1435
            end
            v1438[v1439]:Destroy()
        end
        p1433.Seams.SeamModel:Destroy()
        p1433.Seams = nil
    end
    if p1433.Terrain then
        p1433.Terrain:Destroy()
        p1433.Terrain = nil
    end
    p1431.LODTerrainMemory[p1432] = nil
    p1431.EleTerrainMemory[p1432] = nil
    p1431.TerrainLoaded[p1432] = nil
    if p1431.TileModels[p1434][p1432] then
        debug.profileend()
        p1431:GroupAllRelatedSeams(p1434, p1432, v1435)
        debug.profilebegin("PrepareForUpdate")
        if p1431.TileModels[p1434][p1432] then
            p1431.TileModels[p1434][p1432].Seams = nil
            p1431.TileModels[p1434][p1432].Terrain = nil
            if p1431.TileModels[p1434][p1432].TileModel and not (p1431.TileModels[p1434][p1432].Buildings or (p1431.TileModels[p1434][p1432].Earth or (p1431.TileModels[p1434][p1432].Roads or p1431.TileModels[p1434][p1432].Airports))) then
                p1431.TileModels[p1434][p1432].TileModel:Destroy()
                p1431.TileModels[p1434][p1432] = nil
            end
        end
    end
    debug.profileend()
    return v1435
end
function u8.UnloadTerrainFromTile(p1442, p1443, p1444, p1445) --[[ Line: 3695 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("UnloadTerrainFromTile:")
    local v1446 = p1444.Terrain:GetChildren()
    debug.profileend()
    u9.Stepped:wait()
    debug.profilebegin("UnloadTerrainFromTile:")
    for v1447 = 1, #v1446 do
        p1442.Tickers.TerrainUnload = p1442.Tickers.TerrainUnload + 1
        p1442.Tickers.TerrainParts = p1442.Tickers.TerrainParts - #v1446[v1447]:GetChildren()
        v1446[v1447]:Destroy()
        if p1442.Tickers.TerrainUnload > p1442.RenderSettings.UnloadSpeedTerrain then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("UnloadTerrainFromTile:")
            p1442.Tickers.TerrainUnload = 0
        end
    end
    if p1444.Seams and p1444.Seams.SeamModel then
        local v1448 = p1444.Seams.SeamModel:GetChildren()
        for v1449 = 1, #v1448 do
            local v1450 = v1448[v1449]:GetChildren()
            for v1451 = 1, #v1450 do
                p1442.Tickers.TerrainUnload = p1442.Tickers.TerrainUnload + 1
                p1442.Tickers.TerrainParts = p1442.Tickers.TerrainParts - #v1450[v1451]:GetChildren()
                v1450[v1451]:Destroy()
                if p1442.Tickers.TerrainUnload > p1442.RenderSettings.UnloadSpeedTerrain then
                    debug.profileend()
                    u9.Stepped:wait()
                    debug.profilebegin("UnloadTerrainFromTile:")
                    p1442.Tickers.TerrainUnload = 0
                end
            end
            v1448[v1449]:Destroy()
        end
        if p1444.Seams and p1444.Seams.SeamModel then
            p1444.Seams.SeamModel:Destroy()
            p1444.Seams = nil
        end
    end
    if p1444.Terrain then
        p1444.Terrain:Destroy()
        p1444.Terrain = nil
    end
    p1442.LODTerrainMemory[p1443] = nil
    p1442.EleTerrainMemory[p1443] = nil
    p1442.TerrainLoaded[p1443] = nil
    if p1442.TileModels[p1445][p1443] then
        debug.profileend()
        p1442:RemoveAllRelatedSeams(p1445, p1443)
        debug.profilebegin("UnloadTerrainFromTile:")
        if p1442.TileModels[p1445][p1443] then
            p1442.TileModels[p1445][p1443].Seams = nil
            p1442.TileModels[p1445][p1443].Terrain = nil
            if p1442.TileModels[p1445][p1443].TileModel and not (p1442.TileModels[p1445][p1443].Buildings or (p1442.TileModels[p1445][p1443].Earth or (p1442.TileModels[p1445][p1443].Roads or p1442.TileModels[p1445][p1443].Airports))) then
                p1442.TileModels[p1445][p1443].TileModel:Destroy()
                p1442.TileModels[p1445][p1443] = nil
            end
        end
    end
    debug.profileend()
end
function u8.UnloadAirportsFromTile(p1452, p1453, p1454, p1455) --[[ Line: 3778 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("UnloadAirportsFromTile:")
    local v1456 = p1454.Airports:GetChildren()
    debug.profileend()
    u9.Stepped:wait()
    debug.profilebegin("UnloadAirportsFromTile:")
    for v1457 = 1, #v1456 do
        local v1458 = v1456[v1457]:GetChildren()
        for v1459 = 1, #v1458 do
            v1458[v1459]:Destroy()
            p1452.Tickers.RoadsUnload = p1452.Tickers.RoadsUnload + 1
            if p1452.Tickers.RoadsUnload > p1452.RenderSettings.UnloadSpeedRoads then
                debug.profileend()
                u9.Stepped:wait()
                debug.profilebegin("UnloadAirportsFromTile:")
                p1452.Tickers.RoadsUnload = 0
            end
        end
        v1456[v1457]:Destroy()
        p1452.AirportsLoaded[v1456[v1457].Name] = nil
    end
    if p1454.Airports then
        p1454.Airports:Destroy()
    end
    if p1452.TileModels[p1455][p1453] then
        p1452.TileModels[p1455][p1453].Airports = nil
        if p1452.TileModels[p1455][p1453].TileModel and #p1452.TileModels[p1455][p1453].TileModel:GetChildren() == 0 then
            p1452.TileModels[p1455][p1453].TileModel:Destroy()
            p1452.TileModels[p1455][p1453].TileModel = nil
            if not (p1452.TileModels[p1455][p1453].Buildings or (p1452.TileModels[p1455][p1453].Earth or p1452.TileModels[p1455][p1453].Roads)) then
                p1452.TileModels[p1455][p1453] = nil
            end
        end
    end
    debug.profileend()
end
function u8.UnloadRoadsFromTile(p1460, p1461, p1462, p1463) --[[ Line: 3818 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("UnloadRoadsFromTile:")
    local v1464 = p1462.Roads:GetChildren()
    debug.profileend()
    u9.Stepped:wait()
    debug.profilebegin("UnloadRoadsFromTile:")
    for v1465 = 1, #v1464 do
        p1460.Tickers.RoadsUnload = p1460.Tickers.RoadsUnload + 1
        local v1466 = v1464[v1465]:GetChildren()
        for v1467 = 1, #v1466 do
            p1460.Tickers.RoadParts = p1460.Tickers.RoadParts - #v1466[v1467]:GetChildren()
        end
        v1464[v1465]:Destroy()
        if p1460.Tickers.RoadsUnload > p1460.RenderSettings.UnloadSpeedRoads then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("UnloadRoadsFromTile:")
            p1460.Tickers.RoadsUnload = 0
        end
    end
    if p1462.Roads then
        p1462.Roads:Destroy()
    end
    if p1460.TileModels[p1463][p1461] then
        p1460.TileModels[p1463][p1461].Roads = nil
        if p1460.TileModels[p1463][p1461].TileModel and #p1460.TileModels[p1463][p1461].TileModel:GetChildren() == 0 then
            p1460.TileModels[p1463][p1461].TileModel:Destroy()
            p1460.TileModels[p1463][p1461].TileModel = nil
            if not (p1460.TileModels[p1463][p1461].Buildings or (p1460.TileModels[p1463][p1461].Earth or p1460.TileModels[p1463][p1461].Airports)) then
                p1460.TileModels[p1463][p1461] = nil
            end
        end
    end
    debug.profileend()
end
function u8.UnloadBuildingsFromTile(p1468, p1469, p1470, p1471) --[[ Line: 3860 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("UnloadBuildingsFromTile:")
    local v1472 = p1470.Buildings:GetChildren()
    debug.profileend()
    u9.Stepped:wait()
    debug.profilebegin("UnloadBuildingsFromTile:")
    for v1473 = 1, #v1472 do
        local v1474 = v1472[v1473]:GetChildren()
        for v1475 = 1, #v1474 do
            if p1468.AllBuildings[v1474[v1475].Name] then
                p1468.AllBuildings[v1474[v1475].Name] = nil
            end
            if v1472[v1473].Name == "Trees" then
                p1468.Tickers.TreeParts = p1468.Tickers.TreeParts - #v1474[v1475]:GetChildren()
            else
                p1468.Tickers.BuildingParts = p1468.Tickers.BuildingParts - #v1474[v1475]:GetChildren()
            end
        end
        p1468.Tickers.BuildingsUnload = p1468.Tickers.BuildingsUnload + 1
        v1472[v1473]:Destroy()
        if p1468.Tickers.BuildingsUnload > p1468.RenderSettings.UnloadSpeedBuildings then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("UnloadBuildingsFromTile:")
            p1468.Tickers.BuildingsUnload = 0
        end
    end
    if p1470.Buildings then
        p1470.Buildings:Destroy()
    end
    if p1468.TileModels[p1471][p1469] then
        p1468.TileModels[p1471][p1469].Buildings = nil
        if p1468.TileModels[p1471][p1469].TileModel and #p1468.TileModels[p1471][p1469].TileModel:GetChildren() == 0 then
            p1468.TileModels[p1471][p1469].TileModel:Destroy()
            p1468.TileModels[p1471][p1469].TileModel = nil
            if not (p1468.TileModels[p1471][p1469].Roads or (p1468.TileModels[p1471][p1469].Earth or p1468.TileModels[p1471][p1469].Airports)) then
                p1468.TileModels[p1471][p1469] = nil
            end
        end
    end
    debug.profileend()
end
function u8.UnloadEarthFromTile(p1476, p1477, p1478, p1479) --[[ Line: 3906 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("UnloadEarthFromTile:")
    local v1480 = p1478.Earth:GetChildren()
    debug.profileend()
    u9.Stepped:wait()
    debug.profilebegin("UnloadEarthFromTile:")
    for v1481 = 1, #v1480 do
        p1476.Tickers.EarthUnload = p1476.Tickers.EarthUnload + 1
        if v1480[v1481]:IsA("BasePart") then
            p1476.Tickers.EarthParts = p1476.Tickers.EarthParts - 1
        else
            p1476.Tickers.EarthParts = p1476.Tickers.EarthParts - #v1480[v1481]:GetChildren()
        end
        v1480[v1481]:Destroy()
        if p1476.Tickers.EarthUnload > p1476.RenderSettings.UnloadSpeedEarth then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("UnloadEarthFromTile:")
            p1476.Tickers.EarthUnload = 0
        end
    end
    if p1478.Earth then
        p1478.Earth:Destroy()
    end
    if p1476.TileModels[p1479][p1477] then
        p1476.TileModels[p1479][p1477].Earth = nil
        if p1476.TileModels[p1479][p1477].TileModel and #p1476.TileModels[p1479][p1477].TileModel:GetChildren() == 0 then
            p1476.TileModels[p1479][p1477].TileModel:Destroy()
            p1476.TileModels[p1479][p1477].TileModel = nil
            if not (p1476.TileModels[p1479][p1477].Roads or p1476.TileModels[p1479][p1477].Buildings) then
                p1476.TileModels[p1479][p1477] = nil
            end
        end
    end
    debug.profileend()
end
function u8.UnloadTileMemory(p1482, p1483, p1484) --[[ Line: 3944 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u5
    --]]
    local _ = game:GetService("Stats"):GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.PhysicsParts) > p1482.RenderSettings.MaxPhysicsPartsMemory
    debug.profilebegin("UnloadTileMemory:" .. p1484)
    local v1485 = 0
    local v1486 = {}
    local v1487 = true
    for v1488, _ in pairs(p1482.TileModels[p1483]) do
        v1485 = v1485 + 1
        if v1485 % 100 == 0 then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("UnloadTileMemory:" .. p1484)
        end
        if not (p1482.UnloadingTiles[p1483][v1488] and p1482.UnloadingTiles[p1483][v1488][p1484]) and (not (p1482.LoadingTiles[p1483][v1488] and p1482.LoadingTiles[p1483][v1488][p1484]) and (p1482.TileModels[p1483][v1488] and p1482.TileModels[p1483][v1488][p1484])) then
            if not p1482.NearestCheckTiles[p1483][v1488] then
                local v1489 = string.split(v1488, "_")
                local v1490 = 65536 / math.pow(2, p1483) * 51.2 * 3.2
                local v1491, v1492 = u5:ConvertLatLongToTile(-p1482.Lat, p1482.Lon, p1483)
                local v1493 = workspace.CurrentCamera.CFrame
                local _ = p1482.Recentering == true
                local v1494 = v1493.p
                local v1495 = Vector2.new
                local v1496 = v1494.X / v1490
                local v1497 = v1491 + math.floor(v1496)
                local v1498 = v1494.Z / v1490
                local v1499 = {
                    ["TileName"] = v1488,
                    ["Dis"] = (v1495(v1497, v1492 + math.floor(v1498)) - Vector2.new(v1489[1], v1489[2])).magnitude,
                    ["v"] = p1482.TileModels[p1483][v1488]
                }
                table.insert(v1486, v1499)
            end
        end
    end
    table.sort(v1486, function(p1500, p1501) --[[ Line: 3984 ]]
        return p1500.Dis > p1501.Dis
    end)
    local v1502
    if game:GetService("Stats"):GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.PhysicsParts) > p1482.RenderSettings.MaxPhysicsPartsMemory * 0.8 or p1484 == "Terrain" and p1482.Tickers.TerrainParts > p1482.RenderSettings.MaxTerrainParts * 0.8 or (p1484 == "Earth" and p1482.Tickers.EarthParts > p1482.RenderSettings.MaxEarthParts * 0.8 or (p1484 == "Roads" and p1482.Tickers.RoadParts > p1482.RenderSettings.MaxRoadParts * 0.8 or p1484 == "Buildings" and p1482.Tickers.BuildingParts > p1482.RenderSettings.MaxBuildingParts * 0.8)) then
        local v1503 = #v1486
        v1502 = math.clamp(2, 0, v1503)
    else
        v1502 = 0
    end
    local v1504 = v1485 < 10 and 0 or v1502
    if v1504 > 0 then
        for v1505 = 1, v1504 do
            if p1482.TileModels[p1483][v1486[v1505].TileName] and (v1486[v1505].v and v1486[v1505].v[p1484]) then
                p1482:UnloadingNearBy(v1486[v1505].TileName, p1483, p1484, true)
                if p1484 == "Terrain" and p1482.TileModels[p1483][v1486[v1505].TileName].Terrain then
                    debug.profileend()
                    p1482:UnloadTerrainFromTile(v1486[v1505].TileName, v1486[v1505].v, p1483)
                    if p1482.TileModels[p1483][v1486[v1505].TileName] and p1482.TileModels[p1483][v1486[v1505].TileName].Earth then
                        p1482:UnloadEarthFromTile(v1486[v1505].TileName, v1486[v1505].v, p1483)
                        if p1482.Memory[p1483][v1486[v1505].TileName] then
                            p1482.Memory[p1483][v1486[v1505].TileName].Earth = nil
                        end
                    end
                    debug.profilebegin("UnloadTileMemory:" .. p1484)
                    local v1506 = string.split(v1486[v1505].TileName, "_")
                    for v1507 = 0, 3 do
                        for v1508 = 0, 3 do
                            local v1509 = v1506[1] * 4 + v1507 .. "_" .. v1506[2] * 4 + v1508
                            if p1482.TileModels[14][v1509] and p1482.TileModels[14][v1509].Roads then
                                debug.profileend()
                                p1482:UnloadRoadsFromTile(v1509, p1482.TileModels[14][v1509], 14)
                                debug.profilebegin("UnloadTileMemory:" .. p1484)
                                if p1482.Memory[14][v1509] then
                                    p1482.Memory[14][v1509].Roads = nil
                                end
                            end
                            if p1482.TileModels[14][v1509] and p1482.TileModels[14][v1509].Buildings then
                                debug.profileend()
                                p1482:UnloadBuildingsFromTile(v1509, p1482.TileModels[14][v1509], 14)
                                debug.profilebegin("UnloadTileMemory:" .. p1484)
                                if p1482.Memory[14][v1509] then
                                    p1482.Memory[14][v1509].Buildings = nil
                                end
                            end
                            if p1482.Memory[14][v1509] and not (p1482.Memory[14][v1509].Buildings or (p1482.Memory[14][v1509].Roads or (p1482.Memory[14][v1509].Terrain or (p1482.Memory[14][v1509].Earth or p1482.Memory[14][v1509].Airports)))) then
                                p1482.Memory[14][v1509] = nil
                                p1482.MemoryLastUsed[14][v1509] = nil
                            end
                        end
                    end
                elseif p1484 == "Roads" and p1482.TileModels[p1483][v1486[v1505].TileName].Roads then
                    debug.profileend()
                    p1482:UnloadRoadsFromTile(v1486[v1505].TileName, v1486[v1505].v, p1483)
                    debug.profilebegin("UnloadTileMemory:" .. p1484)
                elseif p1484 == "Buildings" and p1482.TileModels[p1483][v1486[v1505].TileName].Buildings then
                    debug.profileend()
                    p1482:UnloadBuildingsFromTile(v1486[v1505].TileName, v1486[v1505].v, p1483)
                    debug.profilebegin("UnloadTileMemory:" .. p1484)
                elseif p1484 == "Airports" and p1482.TileModels[p1483][v1486[v1505].TileName].Airports then
                    debug.profileend()
                    p1482:UnloadAirportsFromTile(v1486[v1505].TileName, v1486[v1505].v, p1483)
                    debug.profilebegin("UnloadTileMemory:" .. p1484)
                end
                if p1482.Memory[p1483][v1486[v1505].TileName] then
                    p1482.Memory[p1483][v1486[v1505].TileName][p1484] = nil
                end
                if p1482.Memory[p1483][v1486[v1505].TileName] and not (p1482.Memory[p1483][v1486[v1505].TileName].Buildings or (p1482.Memory[p1483][v1486[v1505].TileName].Roads or (p1482.Memory[p1483][v1486[v1505].TileName].Terrain or (p1482.Memory[p1483][v1486[v1505].TileName].Earth or p1482.Memory[p1483][v1486[v1505].TileName].Airports)))) then
                    p1482.MemoryLastUsed[p1483][v1486[v1505].TileName] = nil
                    p1482.Memory[p1483][v1486[v1505].TileName] = nil
                end
                p1482:UnloadingNearBy(v1486[v1505].TileName, p1483, p1484, nil)
            end
        end
        v1487 = false
    end
    if v1487 then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("UnloadTileMemory:" .. p1484)
    end
    debug.profileend()
end
function u8.UnloadType(p1510, p1511, p1512) --[[ Line: 4075 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u5
    --]]
    debug.profilebegin("UnloadType:" .. p1512)
    local v1513 = p1510.NearestTiles[p1511]
    local v1514 = 0
    local v1515 = true
    for v1516, v1517 in pairs(p1510.TileModels[p1511]) do
        v1514 = v1514 + 1
        if v1514 % 10 == 0 then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("UnloadType:" .. p1512)
        end
        if v1513 == p1510.NearestTiles[p1511] and (not p1510.Stopped and (v1517[p1512] and not (p1510.UnloadingTiles[p1511][v1516] and p1510.UnloadingTiles[p1511][v1516][p1512]))) and not (p1510.LoadingTiles[p1511][v1516] and p1510.LoadingTiles[p1511][v1516][p1512]) then
            local v1518 = string.split(v1516, "_")
            local v1519 = 65536 / math.pow(2, p1511) * 51.2 * 3.2
            local v1520 = workspace.CurrentCamera.CFrame
            local _ = p1510.Recentering == true
            local v1521 = v1520.p
            local v1522 = p1510.TerrainOffsetX * (v1519 / 2621.4400000000005)
            local v1523 = p1510.TerrainOffsetY * (v1519 / 2621.4400000000005)
            local v1524 = v1521 - Vector3.new(v1522, 0, v1523)
            local v1525, v1526 = u5:ConvertLatLongToTile(-p1510.Lat, p1510.Lon, p1511)
            local v1527 = Vector2.new
            local v1528 = v1524.X / v1519
            local v1529 = v1525 + math.floor(v1528)
            local v1530 = v1524.Z / v1519
            local v1531 = (v1527(v1529, v1526 + math.floor(v1530)) - Vector2.new(v1518[1], v1518[2])).magnitude * v1519
            local v1532 = p1510.RenderSettings.TerrainUnloadRadius * 528
            if p1512 ~= "Terrain" then
                v1532 = p1510.RenderSettings.DetailsUnloadRadius * 528
            end
            if v1532 <= v1531 then
                p1510:UnloadingNearBy(v1516, p1511, p1512, true)
                if p1512 == "Terrain" then
                    debug.profileend()
                    p1510:UnloadTerrainFromTile(v1516, v1517, p1511)
                    if p1510.TileModels[p1511][v1516] and p1510.TileModels[p1511][v1516].Earth then
                        p1510:UnloadEarthFromTile(v1516, v1517, p1511)
                        if p1510.Memory[p1511][v1516] then
                            p1510.Memory[p1511][v1516].Earth = nil
                        end
                    end
                    debug.profilebegin("UnloadType:" .. p1512)
                    local v1533 = string.split(v1516, "_")
                    for v1534 = 0, 3 do
                        for v1535 = 0, 3 do
                            local v1536 = v1533[1] * 4 + v1534 .. "_" .. v1533[2] * 4 + v1535
                            if p1510.TileModels[14][v1536] and p1510.TileModels[14][v1536].Roads then
                                debug.profileend()
                                p1510:UnloadRoadsFromTile(v1536, p1510.TileModels[14][v1536], 14)
                                debug.profilebegin("UnloadType:" .. p1512)
                                if p1510.Memory[14][v1536] then
                                    p1510.Memory[14][v1536].Roads = nil
                                end
                            end
                            if p1510.TileModels[14][v1536] and p1510.TileModels[14][v1536].Buildings then
                                debug.profileend()
                                p1510:UnloadBuildingsFromTile(v1536, p1510.TileModels[14][v1536], 14)
                                debug.profilebegin("UnloadType:" .. p1512)
                                if p1510.Memory[14][v1536] then
                                    p1510.Memory[14][v1536].Buildings = nil
                                end
                            end
                            if p1510.Memory[14][v1536] and not (p1510.Memory[14][v1536].Buildings or (p1510.Memory[14][v1536].Roads or (p1510.Memory[14][v1536].Terrain or (p1510.Memory[p1511][v1516].Earth or p1510.Memory[p1511][v1516].Airports)))) then
                                p1510.Memory[14][v1536] = nil
                                p1510.MemoryLastUsed[14][v1536] = nil
                            end
                        end
                    end
                elseif p1512 == "Roads" then
                    debug.profileend()
                    p1510:UnloadRoadsFromTile(v1516, v1517, p1511)
                    debug.profilebegin("UnloadType:" .. p1512)
                elseif p1512 == "Airports" then
                    debug.profileend()
                    p1510:UnloadAirportsFromTile(v1516, v1517, p1511)
                    debug.profilebegin("UnloadType:" .. p1512)
                elseif p1512 == "Buildings" then
                    debug.profileend()
                    p1510:UnloadBuildingsFromTile(v1516, v1517, p1511)
                    debug.profilebegin("UnloadType:" .. p1512)
                elseif p1512 == "Earth" then
                    debug.profileend()
                    p1510:UnloadEarthFromTile(v1516, v1517, p1511)
                    debug.profilebegin("UnloadType:" .. p1512)
                end
                if p1510.Memory[p1511][v1516] then
                    p1510.Memory[p1511][v1516][p1512] = nil
                end
                if p1510.Memory[p1511][v1516] and not (p1510.Memory[p1511][v1516].Buildings or (p1510.Memory[p1511][v1516].Roads or (p1510.Memory[p1511][v1516].Terrain or (p1510.Memory[p1511][v1516].Earth or p1510.Memory[p1511][v1516].Airports)))) then
                    p1510.MemoryLastUsed[p1511][v1516] = nil
                    p1510.Memory[p1511][v1516] = nil
                end
                p1510:UnloadingNearBy(v1516, p1511, p1512, nil)
                v1515 = false
                break
            end
        end
    end
    if v1515 then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("UnloadType:" .. p1512)
    end
    debug.profileend()
end
function u8.UnloadingNearBy(p1537, p1538, p1539, p1540, p1541) --[[ Line: 4193 ]]
    local v1542 = string.split(p1538, "_")
    for v1543 = -1, 1 do
        for v1544 = -1, 1 do
            local v1545 = v1542[1]
            local v1546 = tonumber(v1545) + v1543
            local v1547 = v1542[2]
            local v1548 = v1546 .. "_" .. tonumber(v1547) + v1544
            if not p1537.UnloadingTiles[p1539][v1548] then
                p1537.UnloadingTiles[p1539][v1548] = {}
            end
            if p1541 then
                if p1537.UnloadingTiles[p1539][v1548][p1540] then
                    p1537.UnloadingTiles[p1539][v1548][p1540] = p1537.UnloadingTiles[p1539][v1548][p1540] + 1
                else
                    p1537.UnloadingTiles[p1539][v1548][p1540] = 1
                end
            else
                if not p1537.UnloadingTiles[p1539][v1548][p1540] then
                    p1537.UnloadingTiles[p1539][v1548][p1540] = 1
                end
                p1537.UnloadingTiles[p1539][v1548][p1540] = p1537.UnloadingTiles[p1539][v1548][p1540] - 1
                if p1537.UnloadingTiles[p1539][v1548][p1540] == 0 then
                    p1537.UnloadingTiles[p1539][v1548][p1540] = nil
                    if not (p1537.UnloadingTiles[p1539][v1548].Terrain or (p1537.UnloadingTiles[p1539][v1548].Roads or (p1537.UnloadingTiles[p1539][v1548].Buildings or (p1537.UnloadingTiles[p1539][v1548].Earth or p1537.UnloadingTiles[p1539][v1548].Airports)))) then
                        p1537.UnloadingTiles[p1539][v1548] = nil
                    end
                end
            end
        end
    end
end
function u8.LoadingNearBy(p1549, p1550, p1551, p1552, p1553, p1554) --[[ Line: 4223 ]]
    local v1555 = string.split(p1550, "_")
    for v1556 = -p1554, p1554 do
        for v1557 = -p1554, p1554 do
            local v1558 = v1555[1]
            local v1559 = tonumber(v1558) + v1556
            local v1560 = v1555[2]
            local v1561 = v1559 .. "_" .. tonumber(v1560) + v1557
            if not p1549.LoadingTiles[p1551][v1561] then
                p1549.LoadingTiles[p1551][v1561] = {}
            end
            if p1553 then
                if p1549.LoadingTiles[p1551][v1561][p1552] then
                    p1549.LoadingTiles[p1551][v1561][p1552] = p1549.LoadingTiles[p1551][v1561][p1552] + 1
                else
                    p1549.LoadingTiles[p1551][v1561][p1552] = 1
                end
            else
                if not p1549.LoadingTiles[p1551][v1561][p1552] then
                    p1549.LoadingTiles[p1551][v1561][p1552] = 1
                end
                p1549.LoadingTiles[p1551][v1561][p1552] = p1549.LoadingTiles[p1551][v1561][p1552] - 1
                if p1549.LoadingTiles[p1551][v1561][p1552] == 0 then
                    p1549.LoadingTiles[p1551][v1561][p1552] = nil
                    if not (p1549.LoadingTiles[p1551][v1561].Terrain or (p1549.LoadingTiles[p1551][v1561].Roads or (p1549.LoadingTiles[p1551][v1561].Buildings or (p1549.LoadingTiles[p1551][v1561].Earth or p1549.LoadingTiles[p1551][v1561].Airports)))) then
                        p1549.LoadingTiles[p1551][v1561] = nil
                    end
                end
            end
        end
    end
end
function u8.TerrainLoadedNearBy(p1562, p1563) --[[ Line: 4254 ]]
    local v1564 = string.split(p1563, "_")
    for v1565 = -1, 1 do
        for v1566 = -1, 1 do
            local v1567 = v1564[1]
            local v1568 = tonumber(v1567) + v1565
            local v1569 = v1564[2]
            local v1570 = v1568 .. "_" .. tonumber(v1569) + v1566
            if not p1562.TerrainLoaded[v1570] then
                return false
            end
        end
    end
    return true
end
function u8.RefreshType(p1571, p1572, p1573, p1574, p1575) --[[ Line: 4267 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
    local v1576 = p1571.NearestTiles[p1572]
    local v1577 = true
    local v1578 = 0
    if v1576 then
        for v1579 = 1, #v1576 do
            if v1579 % 10 == 0 then
                debug.profileend()
                u9.Stepped:wait()
                debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
            end
            if v1576 == p1571.NearestTiles[p1572] and not p1571.Stopped then
                local v1580 = math.pow(2, p1572) / 4096
                local v1581 = v1576[v1579][1] .. "_" .. v1576[v1579][2]
                local v1582 = v1576[v1579][1] / v1580
                local v1583 = math.floor(v1582)
                local v1584 = v1576[v1579][2] / v1580
                local v1585 = v1583 .. "_" .. math.floor(v1584)
                local v1586 = v1576[v1579][3] - 1
                local v1587 = math.floor(v1586)
                local v1588 = math.clamp(v1587, 0, 3)
                local v1589 = math.pow(2, v1588)
                local v1590 = p1571.RenderSettings.MinTerrainRes
                local v1591 = math.max(v1589, v1590)
                if p1571.Memory[p1572][v1581] and (p1571.Memory[p1572][v1581][p1573] and (p1573 ~= "Earth" or p1571.TileModels[p1572][v1581] and (p1571.TileModels[p1572][v1581].Terrain and (p1571.Memory[p1572][v1581].Terrain and p1571.LODTerrainMemory[v1581] <= p1571.RenderSettings.MinTerrainRes)))) and ((not p1571.TileModels[p1572][v1581] or (not p1571.TileModels[p1572][v1581][p1573] or p1573 == "Terrain" and (p1574 and v1591 < p1571.LODTerrainMemory[v1581]))) and ((not p1575 or p1575 <= v1591) and (not (p1571.LoadingTiles[p1572][v1581] and p1571.LoadingTiles[p1572][v1581][p1573]) and (not (p1571.UnloadingTiles[p1572][v1581] and p1571.UnloadingTiles[p1572][v1581][p1573]) and ((p1573 == "Terrain" or (p1573 == "Earth" or p1571:TerrainLoadedNearBy(v1585))) and (p1573 ~= "Buildings" or p1571.TileModels[p1572][v1581] and p1571.TileModels[p1572][v1581].Airports)))))) then
                    p1571:LoadingNearBy(v1581, p1572, p1573, true, 1)
                    local v1592
                    if p1574 and (p1573 == "Terrain" and (p1571.TileModels[p1572][v1581] and p1571.TileModels[p1572][v1581][p1573])) then
                        debug.profileend()
                        v1592 = p1571:PrepareForUpdate(v1581, p1571.TileModels[p1572][v1581], p1572)
                        debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
                    else
                        v1592 = nil
                    end
                    debug.profileend()
                    p1571:UnloadTileMemory(p1572, p1573)
                    debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
                    p1571.MemoryLastUsed[p1572][v1581] = tick()
                    p1571:LoadingNearBy(v1581, p1572, p1573, false, 1)
                    if game:GetService("Stats"):GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.PhysicsParts) < p1571.RenderSettings.MaxPhysicsPartsMemory and (p1573 ~= "Terrain" or p1571.Tickers.TerrainParts < p1571.RenderSettings.MaxTerrainParts) and ((p1573 ~= "Buildings" or p1571.Tickers.BuildingParts < p1571.RenderSettings.MaxBuildingParts) and ((p1573 ~= "Earth" or p1571.Tickers.EarthParts < p1571.RenderSettings.MaxEarthParts) and (p1573 ~= "Roads" or p1571.Tickers.RoadParts < p1571.RenderSettings.MaxRoadParts))) then
                        local v1593 = p1573 == "Terrain" and 1 or 0
                        p1571:LoadingNearBy(v1581, p1572, p1573, true, v1593)
                        debug.profileend()
                        p1571:RefreshTile(p1571.Memory[p1572][v1581], v1581, p1573, p1572, v1591)
                        debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
                        if p1573 == "Terrain" or not p1571.Memory[p1572][v1581] then
                            local _ = v1591 == 1
                        else
                            p1571.Memory[p1572][v1581][p1573] = nil
                            if not (p1571.Memory[p1572][v1581].Roads or (p1571.Memory[p1572][v1581].Buildings or (p1571.Memory[p1572][v1581].Terrain or (p1571.Memory[p1572][v1581].Earth or p1571.Memory[p1572][v1581].Airports)))) then
                                p1571.MemoryLastUsed[p1572][v1581] = nil
                                p1571.Memory[p1572][v1581] = nil
                            end
                        end
                        if p1573 == "Terrain" then
                            p1571:LoadingNearBy(v1581, p1572, p1573, nil, 0)
                        else
                            p1571:LoadingNearBy(v1581, p1572, p1573, nil, v1593)
                        end
                    end
                    if v1592 then
                        local v1594 = v1592:GetChildren()
                        debug.profileend()
                        u9.Stepped:wait()
                        debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
                        for v1595 = 1, #v1594 do
                            p1571.Tickers.TerrainUnload = p1571.Tickers.TerrainUnload + 1
                            p1571.Tickers.TerrainParts = p1571.Tickers.TerrainParts - #v1594[v1595]:GetChildren()
                            v1594[v1595]:Destroy()
                            if p1571.Tickers.TerrainUnload > p1571.RenderSettings.UnloadSpeedTerrain then
                                debug.profileend()
                                u9.Stepped:wait()
                                debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
                                p1571.Tickers.TerrainUnload = 0
                            end
                        end
                        v1592:Destroy()
                    end
                    if v1578 + 1 >= 3 then
                        v1577 = false
                    end
                    break
                end
            end
        end
    end
    if v1577 then
        debug.profileend()
        u9.Stepped:wait()
        debug.profilebegin("RefreshType:" .. p1573 .. ",Zoom:" .. p1572)
    end
    debug.profileend()
end
function u8.GroupAllRelatedSeams(p1596, p1597, p1598, p1599) --[[ Line: 4418 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("GroupAllRelatedSeams:" .. p1597)
    local v1600 = 0
    for v1601, v1602 in pairs(p1596.TileModels[p1597]) do
        v1600 = v1600 + 1
        if v1600 % 100 == 0 then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("GroupAllRelatedSeams:" .. p1597)
        end
        if v1602.Seams then
            for v1603, _ in pairs(v1602.Seams) do
                if (v1603 == p1598 or v1603 == "C" .. p1598) and (p1596.TileModels[p1597][v1601] and p1596.TileModels[p1597][v1601].Seams) then
                    local v1604 = p1596.TileModels[p1597][v1601].Seams[v1603]:GetChildren()
                    for v1605 = 1, #v1604 do
                        v1604[v1605].Parent = p1599
                    end
                    p1596.TileModels[p1597][v1601].Seams[v1603]:Destroy()
                    p1596.TileModels[p1597][v1601].Seams[v1603] = nil
                    if p1596.TileModels[p1597][v1601].Seams.SeamModel and #p1596.TileModels[p1597][v1601].Seams.SeamModel:GetChildren() == 0 then
                        p1596.TileModels[p1597][v1601].Seams.SeamModel:Destroy()
                        p1596.TileModels[p1597][v1601].Seams = nil
                    end
                    if p1596.TileModels[p1597][v1601].TileModel and #p1596.TileModels[p1597][v1601].TileModel:GetChildren() == 0 then
                        p1596.TileModels[p1597][v1601].TileModel:Destroy()
                        p1596.TileModels[p1597][v1601] = nil
                    end
                end
            end
        end
    end
    debug.profileend()
end
function u8.RemoveAllRelatedSeams(p1606, p1607, p1608) --[[ Line: 4455 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    debug.profilebegin("RemoveAllRelatedSeams:" .. p1607)
    local v1609 = 0
    for v1610, v1611 in pairs(p1606.TileModels[p1607]) do
        v1609 = v1609 + 1
        if v1609 % 100 == 0 then
            debug.profileend()
            u9.Stepped:wait()
            debug.profilebegin("RemoveAllRelatedSeams:" .. p1607)
        end
        if v1611.Seams then
            for v1612, _ in pairs(v1611.Seams) do
                if (v1612 == p1608 or v1612 == "C" .. p1608) and (p1606.TileModels[p1607][v1610] and p1606.TileModels[p1607][v1610].Seams) then
                    local v1613 = p1606.TileModels[p1607][v1610].Seams[v1612]:GetChildren()
                    for v1614 = 1, #v1613 do
                        p1606.Tickers.TerrainUnload = p1606.Tickers.TerrainUnload + 1
                        p1606.Tickers.TerrainParts = p1606.Tickers.TerrainParts - #v1613[v1614]:GetChildren()
                        v1613[v1614]:Destroy()
                        if p1606.Tickers.TerrainUnload > p1606.RenderSettings.UnloadSpeedTerrain then
                            debug.profileend()
                            u9.Stepped:wait()
                            debug.profilebegin("RemoveAllRelatedSeams:" .. p1607)
                            p1606.Tickers.TerrainUnload = 0
                        end
                    end
                    if p1606.TileModels[p1607][v1610] and p1606.TileModels[p1607][v1610].Seams then
                        if p1606.TileModels[p1607][v1610].Seams[v1612] then
                            p1606.TileModels[p1607][v1610].Seams[v1612]:Destroy()
                            p1606.TileModels[p1607][v1610].Seams[v1612] = nil
                        end
                        if p1606.TileModels[p1607][v1610].Seams.SeamModel and #p1606.TileModels[p1607][v1610].Seams.SeamModel:GetChildren() == 0 then
                            p1606.TileModels[p1607][v1610].Seams.SeamModel:Destroy()
                            p1606.TileModels[p1607][v1610].Seams = nil
                        end
                        if p1606.TileModels[p1607][v1610].TileModel and #p1606.TileModels[p1607][v1610].TileModel:GetChildren() == 0 then
                            p1606.TileModels[p1607][v1610].TileModel:Destroy()
                            p1606.TileModels[p1607][v1610] = nil
                        end
                    end
                end
            end
        end
    end
    debug.profileend()
end
return u8