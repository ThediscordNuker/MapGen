-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local u1 = game:GetService("HttpService")
local v2 = {}
local u3 = require(game.ReplicatedStorage.MapScripts.DouglasPeucker)
local u4 = require(game.ReplicatedStorage.MapScripts.ParseServer)
local u5 = require(game.ReplicatedStorage.MapScripts.ConvertCoords)
function v2.CreateJobs(_, p6, p7, p8) --[[ Line: 12 ]]
    local v9 = {}
    for v10 = 1, p6 do
        if v10 == 1 then
            table.insert(v9, { p7, p8 })
        else
            local v11 = (v10 - 1) * 2 + 1
            for v12 = 1, v11 do
                local v13 = { p7 - (v10 - 1) + (v12 - 1), p8 - (v10 - 1) }
                table.insert(v9, v13)
            end
            for v14 = 1, v11 - 2 do
                local v15 = { p7 - (v10 - 1), p8 - (v10 - 2) + (v14 - 1) }
                table.insert(v9, v15)
            end
            for v16 = 1, v11 - 2 do
                local v17 = { p7 + (v10 - 1), p8 - (v10 - 2) + (v16 - 1) }
                table.insert(v9, v17)
            end
            for v18 = 1, v11 do
                local v19 = { p7 - (v10 - 1) + (v18 - 1), p8 + (v10 - 1) }
                table.insert(v9, v19)
            end
        end
    end
    return v9
end
function round(p20, p21)
    local v22 = 10 ^ (p21 or 0)
    local v23 = p20 * v22 + 0.5
    return math.floor(v23) / v22
end
function round2(p24, p25)
    local v26 = string.format
    local v27 = "%." .. (p25 or 0) .. "f"
    return tonumber(v26(v27, p24))
end
function QuickRemove(p28, p29)
    local v30 = #p28
    p28[p29] = p28[v30]
    p28[v30] = nil
end
local u31 = {
    ["Polygon"] = true,
    ["MultiPolygon"] = true
}
local u32 = {
    ["LineString"] = true,
    ["MultiLineString"] = true
}
function BasicRoadType(p33)
    local v34 = p33.kind
    return v34 == "minor_road" and "Small Road" or (v34 == "major_road" and "Large Road" or (v34 == "highway" and "Highway" or nil))
end
function CheckBuildingTypeGood(p35, p36)
    if p35[p36].properties.kind_detail and p35[p36].properties.kind_detail == "hangar" then
        return false
    else
        return (not p35[p36].properties.landuse_kind or p35[p36].properties.landuse_kind ~= "aerodrome") and true or false
    end
end
function v2.CompressBuildings(_, p37, p38, p39) --[[ Line: 87 ]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u5
        [3] = u3
    --]]
    local v40 = 99999999999999
    local v41 = 99999999999999
    local v42 = {
        ["Buildings"] = {}
    }
    for v43 = 1, #p37 do
        if u31[p37[v43].geometry.type] and (CheckBuildingTypeGood(p37, v43) and p37[v43].properties) then
            local v44 = p37[v43].geometry.coordinates
            local v45 = {
                ["p"] = {
                    ["i"] = p37[v43].properties.name or "NoNameBuilding",
                    ["mh"] = p37[v43].properties.min_height,
                    ["h"] = p37[v43].properties.height,
                    ["t"] = p37[v43].geometry.type,
                    ["d"] = p37[v43].properties.kind_detail
                },
                ["g"] = {}
            }
            for v46 = 1, #v44 do
                if p37[v43].geometry.type == "Polygon" then
                    local v47 = v44[v46]
                    local v48 = {}
                    for v49 = 1, #v47 do
                        local v50, v51 = u5:ConvertLatLongToPix(v47[v49][2], v47[v49][1], p39)
                        local v52 = Vector2.new(v50, v51)
                        local v53 = {
                            ["x"] = v52.X,
                            ["y"] = v52.Y
                        }
                        table.insert(v48, v53)
                    end
                    local v54 = u3:Calc(v48, 2, false)
                    if #v54 > 1 then
                        local v55 = {}
                        for v56 = 1, #v54 do
                            local v57 = v54[v56].x * p38
                            local v58 = math.floor(v57)
                            local v59 = v54[v56].y * p38
                            local v60 = math.floor(v59)
                            if v58 < v40 then
                                v40 = v58
                            end
                            if v60 < v41 then
                                v41 = v60
                            end
                            table.insert(v55, { v58, v60 })
                        end
                        local v61 = v45.g
                        table.insert(v61, v55)
                    end
                elseif p37[v43].geometry.type == "MultiPolygon" then
                    local v62 = v44[v46]
                    for v63 = 1, #v62 do
                        local v64 = v62[v63]
                        local v65 = {}
                        for v66 = 1, #v64 do
                            local v67, v68 = u5:ConvertLatLongToPix(v64[v66][2], v64[v66][1], p39)
                            local v69 = Vector2.new(v67, v68)
                            local v70 = {
                                ["x"] = v69.X,
                                ["y"] = v69.Y
                            }
                            table.insert(v65, v70)
                        end
                        local v71 = u3:Calc(v65, 2, false)
                        if #v71 > 1 then
                            local v72 = {}
                            for v73 = 1, #v71 do
                                local v74 = v71[v73].x * p38
                                local v75 = math.floor(v74)
                                local v76 = v71[v73].y * p38
                                local v77 = math.floor(v76)
                                if v75 < v40 then
                                    v40 = v75
                                end
                                if v77 < v41 then
                                    v41 = v77
                                end
                                table.insert(v72, { v75, v77 })
                            end
                            local v78 = v45.g
                            table.insert(v78, v72)
                        end
                    end
                end
            end
            if #v45.g > 0 then
                local v79 = v42.Buildings
                table.insert(v79, v45)
            end
        end
    end
    if #v42.Buildings > 0 then
        table.sort(v42.Buildings, function(p80, p81) --[[ Line: 164 ]]
            return (p80.p.h or 0) > (p81.p.h or 0)
        end)
        for v82 = 1, #v42.Buildings do
            local v83 = v42.Buildings[v82]
            for v84 = 1, #v83.g do
                local v85 = v83.g[v84]
                for v86 = 1, #v85 do
                    v85[v86][1] = v85[v86][1] - v40
                    v85[v86][2] = v85[v86][2] - v41
                end
            end
        end
    end
    v42.LowestX = v40
    v42.LowestY = v41
    return v42
end
function v2.CompressEarth(_, p87, p88, p89) --[[ Line: 184 ]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u5
        [3] = u3
    --]]
    local v90 = 99999999999999
    local v91 = 99999999999999
    local v92 = {
        ["Earth"] = {}
    }
    for v93 = 1, #p87 do
        local v94 = p87[v93].geometry.coordinates
        if u31[p87[v93].geometry.type] and p87[v93].properties then
            local v95 = {
                ["p"] = {
                    ["i"] = p87[v93].properties.name or "Earth"
                },
                ["g"] = {}
            }
            for v96 = 1, #v94 do
                if p87[v93].geometry.type == "Polygon" then
                    local v97 = v94[v96]
                    local v98 = {}
                    for v99 = 1, #v97 do
                        local v100, v101 = u5:ConvertLatLongToPix(v97[v99][2], v97[v99][1], p89)
                        local v102 = Vector2.new(v100, v101)
                        local v103 = {
                            ["x"] = v102.X,
                            ["y"] = v102.Y
                        }
                        table.insert(v98, v103)
                    end
                    local v104 = u3:Calc(v98, 2, false)
                    if #v104 > 1 then
                        local v105 = {}
                        for v106 = 1, #v104 do
                            local v107 = v104[v106].x * p88
                            local v108 = math.floor(v107)
                            local v109 = v104[v106].y * p88
                            local v110 = math.floor(v109)
                            if v108 < v90 then
                                v90 = v108
                            end
                            if v110 < v91 then
                                v91 = v110
                            end
                            table.insert(v105, { v108, v110 })
                        end
                        local v111 = v95.g
                        table.insert(v111, v105)
                    end
                elseif p87[v93].geometry.type == "MultiPolygon" then
                    local v112 = v94[v96]
                    for v113 = 1, #v112 do
                        local v114 = v112[v113]
                        local v115 = {}
                        for v116 = 1, #v114 do
                            local v117, v118 = u5:ConvertLatLongToPix(v114[v116][2], v114[v116][1], p89)
                            local v119 = Vector2.new(v117, v118)
                            local v120 = {
                                ["x"] = v119.X,
                                ["y"] = v119.Y
                            }
                            table.insert(v115, v120)
                        end
                        local v121 = u3:Calc(v115, 2, false)
                        if #v121 > 1 then
                            local v122 = {}
                            for v123 = 1, #v121 do
                                local v124 = v121[v123].x * p88
                                local v125 = math.floor(v124)
                                local v126 = v121[v123].y * p88
                                local v127 = math.floor(v126)
                                if v125 < v90 then
                                    v90 = v125
                                end
                                if v127 < v91 then
                                    v91 = v127
                                end
                                table.insert(v122, { v125, v127 })
                            end
                            local v128 = v95.g
                            table.insert(v128, v122)
                        end
                    end
                end
            end
            if #v95.g > 0 then
                local v129 = v92.Earth
                table.insert(v129, v95)
            end
        end
    end
    if #v92.Earth > 0 then
        for v130 = 1, #v92.Earth do
            local v131 = v92.Earth[v130]
            for v132 = 1, #v131.g do
                local v133 = v131.g[v132]
                for v134 = 1, #v133 do
                    v133[v134][1] = v133[v134][1] - v90
                    v133[v134][2] = v133[v134][2] - v91
                end
            end
        end
    end
    v92.LowestX = v90
    v92.LowestY = v91
    return v92
end
function v2.CompressRoads(_, p135, p136, p137) --[[ Line: 279 ]]
    --[[
    Upvalues:
        [1] = u32
        [2] = u5
    --]]
    local v138 = 99999999999999
    local v139 = 99999999999999
    local v140 = {
        ["Roads"] = {}
    }
    for v141 = 1, #p135 do
        local v142 = p135[v141].geometry.coordinates
        if u32[p135[v141].geometry.type] and (p135[v141].properties and BasicRoadType(p135[v141].properties)) then
            local v143 = {
                ["p"] = {
                    ["i"] = p135[v141].properties.name or "NoNameRoad",
                    ["rt"] = BasicRoadType(p135[v141].properties),
                    ["t"] = p135[v141].geometry.type,
                    ["b"] = p135[v141].properties.is_bridge
                },
                ["g"] = {}
            }
            if p135[v141].geometry.type == "LineString" then
                local v144 = {}
                for v145 = 1, #v142 do
                    local v146, v147 = u5:ConvertLatLongToPix(v142[v145][2], v142[v145][1], p137)
                    local v148 = v146 * p136
                    local v149 = math.floor(v148)
                    local v150 = v147 * p136
                    local v151 = math.floor(v150)
                    if v149 < v138 then
                        v138 = v149
                    end
                    if v151 < v139 then
                        v139 = v151
                    end
                    table.insert(v144, { v149, v151 })
                end
                local v152 = v143.g
                table.insert(v152, v144)
            elseif p135[v141].geometry.type == "MultiLineString" then
                for v153 = 1, #v142 do
                    local v154 = v142[v153]
                    local v155 = {}
                    for v156 = 1, #v154 do
                        local v157, v158 = u5:ConvertLatLongToPix(v154[v156][2], v154[v156][1], p137)
                        local v159 = v157 * p136
                        local v160 = math.floor(v159)
                        local v161 = v158 * p136
                        local v162 = math.floor(v161)
                        if v160 < v138 then
                            v138 = v160
                        end
                        if v162 < v139 then
                            v139 = v162
                        end
                        table.insert(v155, { v160, v162 })
                    end
                    local v163 = v143.g
                    table.insert(v163, v155)
                end
            end
            if #v143.g > 0 then
                local v164 = v140.Roads
                table.insert(v164, v143)
            end
        end
    end
    if #v140.Roads > 0 then
        for v165 = 1, #v140.Roads do
            local v166 = v140.Roads[v165]
            for v167 = 1, #v166.g do
                local v168 = v166.g[v167]
                for v169 = 1, #v168 do
                    v168[v169][1] = v168[v169][1] - v138
                    v168[v169][2] = v168[v169][2] - v139
                end
            end
        end
    end
    v140.LowestX = v138
    v140.LowestY = v139
    return v140
end
function v2.CompressTerrain(_, p170, p171, p172, p173) --[[ Line: 351 ]]
    local v174 = {}
    for v175 = 1, #p170 / 4 do
        local v176 = p170[(v175 - 1) * 4 + 1]
        local v177 = p170[(v175 - 1) * 4 + 2]
        local v178 = p170[(v175 - 1) * 4 + 3]
        local _ = p170[(v175 - 1) * 4 + 4]
        local v179 = -10010 + (v176 * 256 * 256 + v177 * 256 + v178) * 0.1
        table.insert(v174, v179)
    end
    local v180 = {}
    for v181 = 1, 256 do
        for v182 = 1, #p171[v181] do
            local v183 = p171[v181][v182][1]
            local v184 = p171[v181][v182][2]
            local v185 = p171[v181][v182][3]
            table.insert(v180, v183)
            table.insert(v180, v184)
            table.insert(v180, v185)
        end
    end
    local v186 = {}
    for v187 = 1, 4 do
        for v188 = 1, 4 do
            local v189 = p172 * 4 + (v187 - 1) .. "_" .. p173 * 4 + (v188 - 1)
            v186[v189] = {}
            local v190 = 0
            local v191 = 0
            local v192 = 0
            local v193 = 0
            local v194 = 0
            for v195 = (v188 - 1) * 64 + 1, v188 * 64 do
                for v196 = (v187 - 1) * 64 + 1, v187 * 64 do
                    local v197 = v174[(v195 - 1) * 256 + v196] - v193
                    v193 = v174[(v195 - 1) * 256 + v196]
                    local v198 = v186[v189]
                    table.insert(v198, v197)
                    local v199 = ((v195 - 1) * 256 + v196) * 3 - 3
                    local v200 = v180[v199 + 1] - v194
                    v194 = v180[v199 + 1]
                    local v201 = v186[v189]
                    table.insert(v201, v200)
                    local v202 = v180[v199 + 2] - v190
                    v190 = v180[v199 + 2]
                    local v203 = v186[v189]
                    table.insert(v203, v202)
                    local v204 = v180[v199 + 3] - v191
                    v191 = v180[v199 + 3]
                    local v205 = v186[v189]
                    table.insert(v205, v204)
                    v192 = v192 + 1
                    if v192 >= 10 then
                        v190 = 0
                        v191 = 0
                        v192 = 0
                        v193 = 0
                        v194 = 0
                    end
                end
            end
        end
    end
    return v186
end
local function u211(p206) --[[ Line: 454 ]]
    --[[
    Upvalues:
        [1] = u211
    --]]
    local v207 = {}
    for v208, v210 in pairs(p206) do
        if type(v210) == "table" then
            local v210 = u211(v210)
        end
        v207[v208] = v210
    end
    return v207
end
function v2.GetAirports(_, p212, _) --[[ Line: 466 ]]
    local v213 = {}
    for v214 = 1, #p212 do
        if p212[v214].properties and (p212[v214].properties.kind == "aerodrome" or (p212[v214].properties.kind == "airport" or p212[v214].properties.kind == "airfield")) then
            local v215 = {
                ["Coords"] = { p212[v214].geometry.coordinates[2], p212[v214].geometry.coordinates[1] },
                ["ICAO"] = p212[v214].properties.ref or (p212[v214].properties.iata or "A" .. math.random(1, 1000000)),
                ["IATA"] = p212[v214].properties.iata,
                ["Name"] = p212[v214].properties["name:en"] or p212[v214].properties.name
            }
            table.insert(v213, v215)
        end
    end
    return v213
end
function v2.CompressAirport(_, p216, p217, p218) --[[ Line: 493 ]]
    --[[
    Upvalues:
        [1] = u211
        [2] = u5
    --]]
    local v219 = 99999999999999
    local v220 = {
        ["Ways"] = {},
        ["Nodes"] = {},
        ["FakeNodes"] = {}
    }
    local v221 = 99999999999999
    local v222 = 99999999999999
    local v223 = nil
    for v224 = 1, #p216 do
        if p216[v224].type == "way" then
            local v225 = nil
            if p216[v224].tags and (p216[v224].tags.runway == "displaced_threshold" and not p216[v224].tags.area) then
                v225 = "RunwayThres"
            elseif p216[v224].tags and (p216[v224].tags.runway == "blast_pad" and not p216[v224].tags.area) then
                v225 = "RunwayBlast"
            elseif p216[v224].tags and (p216[v224].tags.aeroway == "runway" and not p216[v224].tags.area) then
                v225 = "Runway"
            elseif p216[v224].tags and (p216[v224].tags.aeroway == "runway" or (p216[v224].tags.runway == "blast_pad" or p216[v224].tags.runway == "displaced_threshold")) then
                v225 = "Apron"
            elseif p216[v224].tags and p216[v224].tags.aeroway == "taxiway" then
                v225 = "Taxiway"
            elseif p216[v224].tags and p216[v224].tags.aeroway == "aerodrome" then
                v225 = "Outline"
                v223 = p216[v224].tags.icao
                if v223 then
                    v223 = p216[v224].tags.icao
                end
                print("CHANGED ICAO TO ", v223)
            elseif p216[v224].tags and p216[v224].tags.landuse == "grass" then
                v225 = "Grass"
            elseif p216[v224].tags and p216[v224].tags.aeroway == "apron" then
                v225 = "Apron"
            elseif p216[v224].tags and p216[v224].tags.aeroway == "terminal" then
                v225 = "Terminal"
            elseif p216[v224].tags and p216[v224].tags.aeroway == "hangar" then
                v225 = "Hangar"
            end
            if v225 then
                local v226 = p216[v224].nodes
                local v227 = {
                    ["p"] = {},
                    ["g"] = {}
                }
                local v228 = {}
                if v225 == "RunwayThres" or (v225 == "RunwayBlast" or v225 == "Runway") then
                    local v229 = v226[1]
                    table.insert(v228, v229)
                    local v230 = v226[#v226]
                    table.insert(v228, v230)
                else
                    for v231 = 1, #v226 do
                        local v232 = v226[v231]
                        table.insert(v228, v232)
                    end
                end
                v227.p.t = v225
                if v225 == "Terminal" or v225 == "Hangar" then
                    v227.p.h = p216[v224].tags.height
                end
                v227.p.w = p216[v224].tags.width
                v227.g = v228
                if #v227.g > 0 then
                    local v233 = v220.Ways
                    table.insert(v233, v227)
                    if v225 == "Taxiway" then
                        local v234 = u211(v227)
                        v234.p.t = "TaxiLine"
                        local v235 = v220.Ways
                        table.insert(v235, v234)
                    end
                end
            end
        elseif p216[v224].type == "node" then
            local v236 = {}
            local v237, v238 = u5:ConvertLatLongToPix(p216[v224].lat, p216[v224].lon, p218)
            local v239 = v237 * p217
            local v240 = math.floor(v239)
            local v241 = v238 * p217
            local v242 = math.floor(v241)
            table.insert(v236, v240)
            table.insert(v236, v242)
            if p216[v224].id < v221 then
                v221 = p216[v224].id
            end
            if v240 >= v222 then
                v240 = v222
            end
            if v242 >= v219 then
                v242 = v219
            end
            v220.FakeNodes[p216[v224].id] = v236
            v222 = v240
            v219 = v242
        end
    end
    for v243, v244 in pairs(v220.FakeNodes) do
        local v245 = v220.Nodes
        local v246 = v243 - v221
        v245[tostring(v246)] = { v244[1] - v222, v244[2] - v219 }
    end
    if #v220.Ways > 0 then
        for v247 = 1, #v220.Ways do
            local v248 = v220.Ways[v247]
            for v249 = 1, #v248.g do
                v248.g[v249] = v248.g[v249] - v221
            end
        end
    end
    v220.FakeNodes = nil
    v220.LowestX = v222
    v220.LowestY = v219
    return v220, v223
end
local u250 = 500
local u251 = game.ReplicatedStorage.Debug.HTTPRequests.Request:Clone()
game.ReplicatedStorage.Debug.HTTPRequests.Request:Destroy()
game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
function NewHTTPRequest(p252, p253, p254)
    --[[
    Upvalues:
        [1] = u251
    --]]
    local v255 = u251:Clone()
    v255.AName.Value = p252
    v255.SubName.Value = p253
    v255.Status.Value = p254
    game:GetService("Debris"):AddItem(v255, 120)
    v255.Parent = game.ReplicatedStorage.Debug.HTTPRequests
    return v255
end
function v2.ReturnAirportData(p256, p257, p258) --[[ Line: 634 ]]
    --[[
    Upvalues:
        [1] = u250
        [2] = u1
    --]]
    local v259 = {}
    for v260 = 1, #p257 do
        warn("GETTING HTTP AIRPORT: ", p257[v260].Name, p257[v260].Coords)
        local v261 = p257[v260].Coords
        local v262 = "http://overpass-api.de/api/interpreter?data=" .. "[timeout:25][bbox:" .. (v261[1] - 0.03 .. "," .. v261[2] - 0.03 .. "," .. v261[1] + 0.03 .. "," .. v261[2] + 0.03) .. "][out:json];((way[\'aeroway\'=\'aerodrome\'];way[\'aeroway\'=\'taxiway\'];way[\'aeroway\'=\'runway\'];<;>;way(bn););way[\'landuse\'=\'grass\'];way[\'aeroway\'=\'apron\'];);(._;>;);out;"
        u250 = u250 - 1
        local v263 = u1:GetAsync(v262)
        game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
        local v264, v265 = p256:CompressAirport(u1:JSONDecode(v263).elements, 10, p258)
        v264.Data = p257[v260]
        v264.Data.ICAO = v265 or v264.Data.ICAO
        table.insert(v259, v264)
        spawn(function() --[[ Line: 672 ]]
            --[[
            Upvalues:
                [1] = u250
            --]]
            wait(60)
            u250 = u250 + 1
            game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
        end)
    end
    return v259
end
TerrainBuffer = 10
AirportBuffer = 20
EarthBuffer = 30
RoadBuffer = 40
BuildingBuffer = 50
function v2.GetTerrainData(u266, u267, u268, u269) --[[ Line: 686 ]]
    --[[
    Upvalues:
        [1] = u250
        [2] = u4
        [3] = u1
    --]]
    print("GET TERRAIN DATA", u267, u268, u269)
    local u270 = nil
    if u250 > TerrainBuffer then
        u250 = u250 - 2
        game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
        local u271 = NewHTTPRequest("Terrain Data", u268 .. "_" .. u269, "Fetching")
        local v276, u277 = pcall(function() --[[ Line: 693 ]]
            --[[
            Upvalues:
                [1] = u267
                [2] = u268
                [3] = u269
                [4] = u4
                [5] = u1
                [6] = u270
                [7] = u266
            --]]
            local v272 = {
                ["TerrainURL"] = "https://api.mapbox.com/v4/mapbox.terrain-rgb/" .. u267 .. "/" .. u268 .. "/" .. u269 .. ".pngraw?access_token=pk.eyJ1Ijoid2lkZ2VvbiIsImEiOiJja2Q5ODRqeG8wNHp5Mnh0MTY0bTdhMTNoIn0.42sX83cOzbu0l60ml6pXZQ"
            }
            print("GET URL:", v272.TerrainURL)
            local v273 = u1:JSONDecode((u4:CloudCode("GetTerrainData", v272))).result
            local v274 = {
                ["TerrainURL"] = "https://api.maptiler.com/tiles/satellite/" .. u267 .. "/" .. u268 .. "/" .. u269 .. ".jpg?key=Fezz48OAVJSneak8xoDK"
            }
            local v275 = u4:CloudCode("GetTerrainData2", v274)
            print("GET URL2:", v274.TerrainURL)
            if v273 ~= "WATERTILE" then
                u270 = u266:CompressTerrain(v273, u1:JSONDecode(v275).result, u268, u269)
            end
        end)
        spawn(function() --[[ Line: 713 ]]
            --[[
            Upvalues:
                [1] = u250
            --]]
            wait(60)
            u250 = u250 + 2
            game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
        end)
        if v276 then
            pcall(function() --[[ Line: 720 ]]
                --[[
                Upvalues:
                    [1] = u271
                --]]
                u271.Status.Value = "Good"
            end)
            game.ReplicatedStorage.Debug.HTTPLimits.Terrain.Value = true
        else
            pcall(function() --[[ Line: 715 ]]
                --[[
                Upvalues:
                    [1] = u271
                    [2] = u277
                --]]
                u271.Status.Value = u277
            end)
            game.ReplicatedStorage.Debug.HTTPLimits.Terrain.Value = false
            local v278 = nil
            warn("TERRAIN DATA ERROR", u277)
            u270 = v278
        end
    end
    return u270
end
function v2.CompressPOI(_, p279, p280, p281) --[[ Line: 728 ]]
    local v282 = {}
    for v283 = 1, #p280 do
        if p280[v283].properties.kind == "locality" and p280[v283].properties.population_rank >= 5 then
            local v284 = {
                ["Type"] = "City",
                ["Coords"] = p280[v283].geometry.coordinates,
                ["Name"] = p280[v283].properties["name:en"] or p280[v283].properties.name
            }
            table.insert(v282, v284)
        end
    end
    for v285 = 1, #p281 do
        if p281[v285].properties.kind == "aerodrome" or (p281[v285].properties.kind == "airport" or p281[v285].properties.kind == "airfield") then
            local v286 = {
                ["Type"] = "Airport",
                ["Coords"] = p281[v285].geometry.coordinates,
                ["Name"] = p281[v285].properties["name:en"] or p281[v285].properties.name
            }
            table.insert(v282, v286)
        end
    end
    for v287 = 1, #p279 do
        if p279[v287].properties.is_bridge and p279[v287].properties.kind == "highway" then
            local v288 = {
                ["Type"] = "Bridge",
                ["Coords"] = p279[v287].geometry.coordinates[1],
                ["Name"] = p279[v287].properties["name:en"] or p279[v287].properties.name
            }
            table.insert(v282, v288)
        end
    end
    return v282
end
function v2.GetData(u289, u290, p291, p292, p293) --[[ Line: 754 ]]
    --[[
    Upvalues:
        [1] = u250
        [2] = u1
    --]]
    local u294 = nil
    local u295 = "https://tile.nextzen.org/tilezen/vector/v1/all/" .. u290 .. "/" .. p291 .. "/" .. p292 .. ".json?api_key=Y6Vz5v1fQjiMEb89fbv4oQ"
    if p293 == "Roads" and u250 > RoadBuffer or (p293 == "Buildings" and u250 > BuildingBuffer or (p293 == "Earth" and u250 > EarthBuffer or p293 == "Airports" and u250 > AirportBuffer)) then
        u250 = u250 - 1
        game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
        local u296 = NewHTTPRequest("OSM Data", p291 .. "_" .. p292, "Fetching")
        local v298, u299 = pcall(function() --[[ Line: 762 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u295
                [3] = u294
                [4] = u289
                [5] = u290
            --]]
            local v297 = u1:JSONDecode((u1:GetAsync(u295)))
            u294 = {
                ["Earth"] = u289:CompressEarth(v297.earth.features, 10, u290),
                ["Buildings"] = u289:CompressBuildings(v297.buildings.features, 10, u290),
                ["Roads"] = u289:CompressRoads(v297.roads.features, 10, u290),
                ["POIs"] = u289:CompressPOI(v297.roads.features, v297.places.features, v297.pois.features),
                ["Airports"] = u289:ReturnAirportData(u289:GetAirports(v297.pois.features, v297.landuse.features, u290), u290)
            }
        end)
        spawn(function() --[[ Line: 780 ]]
            --[[
            Upvalues:
                [1] = u250
            --]]
            wait(60)
            u250 = u250 + 1
            game.ReplicatedStorage.Debug.HTTPLimits.RequestsLeft.Value = u250
        end)
        if v298 then
            pcall(function() --[[ Line: 790 ]]
                --[[
                Upvalues:
                    [1] = u296
                --]]
                u296.Status.Value = "Good"
            end)
            game.ReplicatedStorage.Debug.HTTPLimits.Airport.Value = true
            game.ReplicatedStorage.Debug.HTTPLimits.Earth.Value = true
            game.ReplicatedStorage.Debug.HTTPLimits.Building.Value = true
            game.ReplicatedStorage.Debug.HTTPLimits.Road.Value = true
        else
            local v300 = nil
            game.ReplicatedStorage.Debug.HTTPLimits.Airport.Value = false
            game.ReplicatedStorage.Debug.HTTPLimits.Earth.Value = false
            game.ReplicatedStorage.Debug.HTTPLimits.Building.Value = false
            game.ReplicatedStorage.Debug.HTTPLimits.Road.Value = false
            pcall(function() --[[ Line: 787 ]]
                --[[
                Upvalues:
                    [1] = u296
                    [2] = u299
                --]]
                u296.Status.Value = u299
            end)
            warn("OSM DATA ERROR", u299)
            u294 = v300
        end
    end
    return u294
end
return v2