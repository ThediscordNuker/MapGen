-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local function u10(p1, p2, p3, p4) --[[ Line: 68 ]]
    local v5 = p4.x - p3.x
    local v6 = p4.y - p3.y
    local v7 = p1.x - p3.x
    local v8 = v5 * (p1.y - p3.y) - v6 * v7
    local v9 = p2.x - p3.x
    return v8 * (v5 * (p2.y - p3.y) - v6 * v9) >= 0
end
local function u17(p11, p12, p13, p14) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    for v15 in pairs(p11) do
        if v15 ~= p12 and (v15 ~= p13 and v15 ~= p14) then
            local v16 = u10(v15, p12, p13, p14) and u10(v15, p13, p12, p14)
            if v16 then
                v16 = u10(v15, p14, p12, p13)
            end
            if v16 then
                return true
            end
        end
    end
    return false
end
local function u29(p18, p19) --[[ Line: 102 ]]
    local v23 = setmetatable({}, {
        ["__index"] = function(p20, p21) --[[ Name: __index, Line 103 ]]
            local v22 = {}
            p20[p21] = v22
            return v22
        end
    })
    for v24 = 1, #p18 do
        v23[p18[v24].x][p18[v24].y] = v24
    end
    local v25 = #p19
    for v26 = 1, #p19 do
        local v27 = p19[v25]
        local v28 = p19[v26]
        if v23[v27.x][v27.y] and v23[v28.x][v28.y] then
            return v23[v28.x][v28.y], v26
        end
        v25 = v26
    end
end
local u30 = {}
u30.__index = u30
function u30.new(p31) --[[ Line: 132 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u30
    --]]
    local v32 = #p31 >= 3
    local v33 = "Need at least 3 non collinear points to build polygon (got " .. #p31 .. ")"
    assert(v32, v33)
    local v34 = p31
    local v35 = 1
    for v36 = 2, #p31 do
        if p31[v36].x < p31[v35].x then
            v35 = v36
        end
    end
    local v37 = v35 > 1 and v35 - 1 or #v34
    local v38 = v35 < #v34 and (v35 + 1 or 1) or 1
    local v39 = v34[v37]
    local v40 = v34[v35]
    local v41 = v34[v38]
    local v42 = v40.x - v39.x
    local v43 = v40.y - v39.y
    local v44 = v41.x - v39.x
    local v45
    if v42 * (v41.y - v39.y) - v43 * v44 >= 0 then
        v45 = v34
    else
        v45 = {}
        for v46 = #v34, 1, -1 do
            v45[#v45 + 1] = v34[v46]
        end
    end
    local v47 = v45[#v45]
    for v48 = 1, #v45 - 2 do
        local v49 = v45[v48]
        v47 = v49
        for v50 = v48 + 1, #v45 - 1 do
            local v51 = v45[v50]
            local v52 = v45[v50 + 1]
            local v53 = u10(v47, v47, v51, v52) or u10(v51, v52, v47, v47)
            assert(v53 and true or false, "Polygon may not intersect itself")
            v49 = v47
            v47 = v49
        end
    end
    local v54 = v45[#v45]
    local v55 = v45[1]
    local v56 = v54.x
    local v57 = v54.y
    local v58 = v55.x
    local v59 = v56 * v55.y - v57 * v58
    local v60 = v45
    local v61 = v59
    for v62 = 2, #v45 do
        local v63 = v45[v62]
        local v64 = v55.x
        local v65 = v55.y
        local v66 = v63.x
        v59 = v59 + (v64 * v63.y - v65 * v66)
        v55 = v63
    end
    local v67 = v59 / 2
    local v68 = v45[#v45]
    local v69 = v45[1]
    local v70 = {
        ["x"] = (v68.x + v69.x) * v61,
        ["y"] = (v68.y + v69.y) * v61
    }
    for v71 = 2, #v45 do
        local v72 = v45[v71]
        local v73 = v69.x
        local v74 = v69.y
        local v75 = v72.x
        local v76 = v73 * v72.y - v74 * v75
        v70.x = v70.x + (v69.x + v72.x) * v76
        v70.y = v70.y + (v69.y + v72.y) * v76
        v69 = v72
    end
    v70.x = v70.x / (6 * v67)
    v70.y = v70.y / (6 * v67)
    local v77 = 0
    for v78 = 1, #v45 do
        local v79 = v45[v78].x
        local v80 = v45[v78].y
        local v81 = v70.x
        local v82 = v70.y
        local v83 = v79 - v81
        local v84 = v80 - v82
        local v85 = v83 * v83 + v84 * v84
        local v86 = math.sqrt(v85)
        v77 = math.max(v77, v86)
    end
    local v87 = u30
    return setmetatable({
        ["area"] = v67,
        ["vertices"] = v60,
        ["_radius"] = v77,
        ["centroid"] = v70
    }, v87)
end
local u88 = nil
function u30.unpack(p89) --[[ Line: 204 ]]
    local v90 = {}
    for v91 = 1, #p89.vertices do
        v90[v91 * 2 - 1] = p89.vertices[v91].x
        v90[v91 * 2] = p89.vertices[v91].y
    end
    return v90
end
function u30.clone(p92) --[[ Line: 214 ]]
    return p92:unpack()
end
function u30.bbox(p93) --[[ Line: 219 ]]
    local v94 = p93.vertices[1].x
    local v95 = p93.vertices[1].y
    local v96 = v95
    local v97 = v94
    for v98 = 2, #p93.vertices do
        local v99 = p93.vertices[v98]
        if v99.x < v94 then
            v94 = v99.x
        end
        if v99.y < v95 then
            v95 = v99.y
        end
        if v97 < v99.x then
            v97 = v99.x
        end
        if v96 < v99.y then
            v96 = v99.y
        end
    end
    return v94, v95, v97, v96
end
function u30.isConvex(u100) --[[ Line: 235 ]]
    local u121 = (function() --[[ Name: isConvex, Line 236 ]]
        --[[
        Upvalues:
            [1] = u100
        --]]
        local v101 = u100.vertices
        if #v101 == 3 then
            return true
        end
        local v102 = v101[#v101]
        local v103 = v101[1]
        local v104 = v101[2]
        local v105 = v103.x - v102.x
        local v106 = v103.y - v102.y
        local v107 = v104.x - v102.x
        if v105 * (v104.y - v102.y) - v106 * v107 < 0 then
            return false
        end
        for v108 = 2, #v101 - 1 do
            local v109 = v101[v108 - 1]
            local v110 = v101[v108]
            local v111 = v101[v108 + 1]
            local v112 = v110.x - v109.x
            local v113 = v110.y - v109.y
            local v114 = v111.x - v109.x
            if v112 * (v111.y - v109.y) - v113 * v114 < 0 then
                return false
            end
        end
        local v115 = v101[#v101 - 1]
        local v116 = v101[#v101]
        local v117 = v101[1]
        local v118 = v116.x - v115.x
        local v119 = v116.y - v115.y
        local v120 = v117.x - v115.x
        return v118 * (v117.y - v115.y) - v119 * v120 >= 0 and true or false
    end)()
    function u100.isConvex() --[[ Line: 256 ]]
        --[[
        Upvalues:
            [1] = u121
        --]]
        return u121
    end
    return u121
end
function u30.move(p122, p123, p124) --[[ Line: 260 ]]
    if not p124 then
        p123, p124 = p123:unpack()
    end
    for _, v125 in ipairs(p122.vertices) do
        v125.x = v125.x + p123
        v125.y = v125.y + p124
    end
    p122.centroid.x = p122.centroid.x + p123
    p122.centroid.y = p122.centroid.y + p124
end
function u30.rotate(p126, p127, p128, p129) --[[ Line: 272 ]]
    if not (p128 and p129) then
        p128 = p126.centroid.x
        p129 = p126.centroid.y
    end
    for _, v130 in ipairs(p126.vertices) do
        local v131 = v130.x - p128
        local v132 = v130.y - p129
        local v133 = math.cos(p127)
        local v134 = math.sin(p127)
        local v135 = v133 * v131 - v134 * v132
        local v136 = v134 * v131 + v133 * v132
        local v137 = p128 + v135
        local v138 = p129 + v136
        v130.x = v137
        v130.y = v138
    end
    local v139 = p126.centroid
    local v140 = v139.x - p128
    local v141 = v139.y - p129
    local v142 = math.cos(p127)
    local v143 = math.sin(p127)
    local v144 = v142 * v140 - v143 * v141
    local v145 = v143 * v140 + v142 * v141
    local v146 = p128 + v144
    local v147 = p129 + v145
    v139.x = v146
    v139.y = v147
end
function u30.scale(p148, p149, p150, p151) --[[ Line: 284 ]]
    if not (p150 and p151) then
        p150 = p148.centroid.x
        p151 = p148.centroid.y
    end
    for _, v152 in ipairs(p148.vertices) do
        local v153 = v152.x - p150
        local v154 = v152.y - p151
        local v155 = p149 * v153
        local v156 = p149 * v154
        local v157 = p150 + v155
        local v158 = p151 + v156
        v152.x = v157
        v152.y = v158
    end
    p148._radius = p148._radius * p149
end
function u30.triangulate(p159, p160) --[[ Line: 296 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u88
    --]]
    if #p159.vertices == 3 then
        return { p159:clone() }
    end
    local v161 = p159.vertices
    local v162 = {}
    local v163 = {}
    for v164 = 1, #v161 do
        local v165 = v164 + 1
        local v166 = v164 - 1
        v162[v164] = v165
        v163[v164] = v166
    end
    local v167 = #v162
    local v168 = #v163
    v162[v167] = 1
    v163[1] = v168
    local v169 = {}
    for v170, v171 in ipairs(v161) do
        local v172 = v161[v163[v170]]
        local v173 = v161[v162[v170]]
        local v174 = v171.x - v172.x
        local v175 = v171.y - v172.y
        local v176 = v173.x - v172.x
        if v174 * (v173.y - v172.y) - v175 * v176 < 0 then
            v169[v171] = true
        end
    end
    local v177 = #v161
    local v178 = 0
    local v179 = 1
    local v180 = 0
    local v181 = {}
    while v177 > 3 and v178 < 100 do
        v178 = v178 + 1
        local v182 = v162[v179]
        local v183 = v163[v179]
        local v184 = v161[v183]
        local v185 = v161[v179]
        local v186 = v161[v182]
        local v187 = v185.x - v184.x
        local v188 = v185.y - v184.y
        local v189 = v186.x - v184.x
        local v190 = v187 * (v186.y - v184.y) - v188 * v189 >= 0
        if v190 then
            v190 = not u17(v169, v184, v185, v186)
        end
        if v190 or p160 then
            local v191 = v185.x - v184.x
            local v192 = v185.y - v184.y
            local v193 = v186.x - v184.x
            local v194 = v191 * (v186.y - v184.y) - v192 * v193
            if math.abs(v194) > 1e-32 then
                v181[#v181 + 1] = u88(v184.x, v184.y, v185.x, v185.y, v186.x, v186.y)
                v162[v183] = v182
                v163[v182] = v183
                v169[v185] = nil
                v177 = v177 - 1
                v180 = 0
            end
        else
            v180 = v180 + 1
            local v195 = v180 <= v177
            assert(v195, "Cannot triangulate polygon")
        end
        v179 = v182
    end
    local v196 = v162[v179]
    local v197 = v161[v163[v179]]
    local v198 = v161[v179]
    local v199 = v161[v196]
    v181[#v181 + 1] = u88(v197.x, v197.y, v198.x, v198.y, v199.x, v199.y)
    return v181
end
function u30.mergedWith(p200, p201) --[[ Line: 342 ]]
    --[[
    Upvalues:
        [1] = u29
        [2] = u88
    --]]
    local v202, v203 = u29(p200.vertices, p201.vertices)
    assert(v202 and v203, "Polygons do not share an edge")
    local v204 = {}
    for v205 = 1, v202 - 1 do
        v204[#v204 + 1] = p200.vertices[v205].x
        v204[#v204 + 1] = p200.vertices[v205].y
    end
    for v206 = 0, #p201.vertices - 2 do
        local v207 = (v206 - 1 + v203) % #p201.vertices + 1
        v204[#v204 + 1] = p201.vertices[v207].x
        v204[#v204 + 1] = p201.vertices[v207].y
    end
    for v208 = v202 + 1, #p200.vertices do
        v204[#v204 + 1] = p200.vertices[v208].x
        v204[#v204 + 1] = p200.vertices[v208].y
    end
    return u88(unpack(v204))
end
function u30.splitConvex(p209) --[[ Line: 371 ]]
    if #p209.vertices <= 3 or p209:isConvex() then
        return { p209:clone() }
    else
        local u210 = p209:triangulate()
        local v211 = 1
        while true do
            local u212 = u210[v211]
            local u213 = v211 + 1
            while u213 <= #u210 do
                local v214, v215 = pcall(function() --[[ Line: 381 ]]
                    --[[
                    Upvalues:
                        [1] = u212
                        [2] = u210
                        [3] = u213
                    --]]
                    return u212:mergedWith(u210[u213])
                end)
                if v214 and v215:isConvex() then
                    u210[v211] = v215
                    local v216 = u210[v211]
                    table.remove(u210, u213)
                    u212 = v216
                else
                    local v217 = u213 + 1
                    u213 = v217
                end
            end
            v211 = v211 + 1
            if #u210 <= v211 then
                return u210
            end
        end
    end
end
function u30.contains(p218, p219, p220) --[[ Line: 396 ]]
    local v221 = p218.vertices
    local _ = v221[#v221]
    local v222 = v221[#v221]
    local v223 = false
    for v224 = 1, #v221 do
        local v225 = v221[v224]
        local v226
        if p220 < v222.y and v225.y < p220 or v222.y < p220 and p220 < v225.y then
            v226 = p219 - v222.x < (p220 - v222.y) * (v225.x - v222.x) / (v225.y - v222.y)
        else
            v226 = false
        end
        if v226 then
            ::l11::
            v222 = v225
            v223 = not v223
        else
            local v227
            if v222.y == p220 and (p219 < v222.x and v225.y < p220) then
                v227 = true
            elseif v225.y == p220 and p219 < v225.x then
                v227 = v222.y < p220
            else
                v227 = false
            end
            if v227 then
                goto l11
            end
            v222 = v225
        end
    end
    return v223
end
function u30.intersectionsWithRay(p228, p229, p230, p231, p232) --[[ Line: 423 ]]
    local v233 = -p232
    local v234 = p228.vertices[#p228.vertices]
    local v235 = p231
    local v236 = {}
    for v237 = 1, #p228.vertices do
        local v238 = p228.vertices[v237]
        local v239 = v238.x - v234.x
        local v240 = v238.y - v234.y
        local v241 = v235 * v240 - p232 * v239
        if v241 == 0 then
            local v242 = v234.x - p229
            local v243 = v234.y - p230
            if v242 * v233 + v243 * p231 == 0 then
                local v244 = v234.x - p229
                local v245 = v234.y - p230
                local v246 = v235 * v244 + p232 * v245
                local v247 = v238.x - p229
                local v248 = v238.y - p230
                local v249 = v235 * v247 + p232 * v248
                if v249 <= v246 then
                    v236[#v236 + 1] = v246
                    v234 = v238
                else
                    v236[#v236 + 1] = v249
                    v234 = v238
                end
            else
                v234 = v238
            end
        else
            local v250 = v238.x - p229
            local v251 = v238.y - p230
            local v252 = (v250 * v240 - v251 * v239) / v241
            local v253 = (v235 * v251 - p232 * v250) / v241
            if v253 >= 0 and v253 <= 1 then
                v236[#v236 + 1] = v252
                v234 = v238
            else
                v234 = v238
            end
        end
    end
    return v236
end
function u30.intersectsRay(p254, p255, p256, p257, p258) --[[ Line: 464 ]]
    local v259 = (1 / 0)
    for _, v260 in ipairs(p254:intersectionsWithRay(p255, p256, p257, p258)) do
        v259 = math.min(v259, v260)
    end
    return v259 ~= (1 / 0), v259
end
u88 = function(...) --[[ Line: 472 ]]
    return { ... }
end
return u30