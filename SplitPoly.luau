-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = {}
local function u5(p2) --[[ Line: 3 ]]
    local v3 = {}
    for v4 = 1, #p2 - 1, 2 do
        v3[#v3 + 1] = {
            ["x"] = p2[v4],
            ["y"] = p2[v4 + 1]
        }
    end
    return v3
end
local function u9(p6) --[[ Line: 13 ]]
    local v7 = {}
    for v8 = 1, #p6 do
        v7[v8] = {
            ["x"] = p6[v8][1],
            ["y"] = p6[v8][2]
        }
    end
    return v7
end
local function u21(p10, p11, p12, p13) --[[ Line: 23 ]]
    local v14 = {
        ["X1"] = p10.x,
        ["Y1"] = p10.y,
        ["X2"] = p11.x,
        ["Y2"] = p11.y
    }
    local v15 = {
        ["X1"] = p12.x,
        ["Y1"] = p12.y,
        ["X2"] = p13.x,
        ["Y2"] = p13.y
    }
    local v16 = (v15.Y2 - v15.Y1) * (v14.X2 - v14.X1) - (v15.X2 - v15.X1) * (v14.Y2 - v14.Y1)
    if v16 == 0 then
        return false
    else
        local v17 = (v15.X2 - v15.X1) * (v14.Y1 - v15.Y1) - (v15.Y2 - v15.Y1) * (v14.X1 - v15.X1)
        local v18 = (v14.X2 - v14.X1) * (v14.Y1 - v15.Y1) - (v14.Y2 - v14.Y1) * (v14.X1 - v15.X1)
        local v19 = v17 / v16
        local v20 = v18 / v16
        if v19 >= 0 and (v19 <= 1 and (v20 >= 0 and v20 <= 1)) then
            return true, {
                ["x"] = v14.X1 + v19 * (v14.X2 - v14.X1),
                ["y"] = v14.Y1 + v19 * (v14.Y2 - v14.Y1)
            }
        else
            return false
        end
    end
end
function lengthOf(...)
    local v22 = { ... }
    local v23 = nil
    local v24 = nil
    if #v22 == 4 then
        local v25 = v22[1]
        if type(v25) == "number" then
            v23 = {
                ["x"] = v22[1],
                ["y"] = v22[2]
            }
            v24 = {
                ["x"] = v22[3],
                ["y"] = v22[4]
            }
            ::l4::
            local v26 = v24.x - v23.x
            local v27 = v24.y - v23.y
            return (v26 * v26 + v27 * v27) ^ 0.5
        end
    end
    if #v22 == 2 and (v22[1].x ~= nil and v22[2].y ~= nil) then
        v23 = v22[1]
        v24 = v22[2]
    elseif #v22 == 1 and v22[1].xStart ~= nil then
        v23 = {
            ["x"] = v22[1].xStart,
            ["y"] = v22[1].yStart
        }
        v24 = v22[1]
    else
        if #v22 > 4 then
            local v28 = v22[1]
            if type(v28) == "number" and #v22 % 2 == 0 then
                local v29 = 0
                for v30 = 1, #v22 - 3, 2 do
                    v29 = v29 + lengthOf(v22[v30], v22[v30 + 1], v22[v30 + 2], v22[v30 + 3])
                end
                return v29
            end
        end
        if #v22 == 1 and (v22[1].a ~= nil and v22[1].b ~= nil) then
            v23 = v22[1].a
            v24 = v22[1].b
        else
            if #v22 == 2 then
                local v31 = v22[1]
                if type(v31) == "number" then
                    v23 = {
                        ["x"] = v22[1],
                        ["y"] = v22[2]
                    }
                    v24 = {
                        ["x"] = 0,
                        ["y"] = 0
                    }
                    goto l4
                end
            end
            if #v22 == 1 and v22[1].x ~= nil then
                v23 = v22[1]
                v24 = {
                    ["x"] = 0,
                    ["y"] = 0
                }
            end
        end
    end
    goto l4
end
local function u38(p32, p33) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v34 = p32.numChildren
    if v34 == nil then
        local v35 = p32[1]
        if type(v35) == "number" then
            p32 = u5(p32)
            local _ = #p32
        elseif p32.numChildren == nil then
            local _ = #p32
        end
        v34 = #p32
    end
    local v36 = false
    for v37 = 1, v34 do
        if (p32[v37].y < p33.y and p32[v34].y >= p33.y or p32[v34].y < p33.y and p32[v37].y >= p33.y) and (p32[v37].x <= p33.x or p32[v34].x <= p33.x) then
            if p32[v37].x + (p33.y - p32[v37].y) / (p32[v34].y - p32[v37].y) * (p32[v34].x - p32[v37].x) < p33.x then
                v36 = not v36
            end
        end
        v34 = v37
    end
    return v36
end
local function u41(p39) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v40 = u9(p39)
    local _ = #v40
    if v40[1].x ~= v40[#v40].x or v40[1].y ~= v40[#v40].y then
        v40[#v40 + 1] = {
            ["x"] = v40[1].x,
            ["y"] = v40[1].y
        }
    end
    return v40
end
local function u77(p42, p43, p44) --[[ Line: 166 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u38
    --]]
    local function v55(p45, u46, p47) --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u38
        --]]
        local v48 = {}
        for v49 = 1, #p45 - 1 do
            local v50, v51 = u21(u46, p47, p45[v49], p45[v49 + 1])
            if v50 then
                v51.index = v49
                v48[#v48 + 1] = v51
            end
        end
        if #v48 == 1 then
            return {}
        end
        table.sort(v48, function(p52, p53) --[[ Line: 184 ]]
            --[[
            Upvalues:
                [1] = u46
            --]]
            return lengthOf(u46, p52) < lengthOf(u46, p53)
        end)
        if #v48 > 0 and u38(p45, u46) then
            table.remove(v48, 1)
        end
        if #v48 % 2 ~= 0 then
            v48[#v48] = nil
        end
        if #v48 == 1 then
            return {}
        end
        for v54 = 1, #v48, 2 do
            v48[v54].pairIndex = v54
            v48[v54 + 1].pairIndex = v54
        end
        return v48
    end
    local function u65(p56, u57, p58) --[[ Line: 207 ]]
        --[[
        Upvalues:
            [1] = u21
        --]]
        local v59 = 1
        local v60 = {}
        while v59 <= #p56 - 1 do
            local v61, v62 = u21(u57, p58, p56[v59], p56[v59 + 1])
            if v61 then
                v62.index = v59
                v60[#v60 + 1] = v62
            end
            v59 = v59 + 1
        end
        table.sort(v60, function(p63, p64) --[[ Line: 219 ]]
            --[[
            Upvalues:
                [1] = u57
            --]]
            return lengthOf(u57, p63) < lengthOf(u57, p64)
        end)
        return v60
    end
    local function v76(p66, p67) --[[ Line: 225 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u65
        --]]
        local v68 = u38(p66, p67[1])
        local v69 = {
            {}
        }
        local v70 = {}
        for v71 = 1, #p67 - 1 do
            local v72 = u65(p66, p67[v71], p67[v71 + 1])
            local v73 = v69[#v69]
            if v68 and #v70 > 0 then
                v73[#v73 + 1] = p67[v71]
            end
            for v74 = 1, #v72 do
                if v68 then
                    if #v70 > 0 then
                        v70[#v70 + 1] = v72[v74]
                        v70[#v70].pathIndex = #v69
                        v69[#v69 + 1] = {}
                    end
                else
                    v70[#v70 + 1] = v72[v74]
                    v70[#v70].pathIndex = #v69
                end
                v68 = not v68
            end
        end
        if v68 then
            v70[#v70] = nil
            v69[#v69] = nil
        end
        for v75 = 1, #v70, 2 do
            v70[v75].pairIndex = v75
            v70[v75 + 1].pairIndex = v75
        end
        v69[#v69] = nil
        return v70, v69
    end
    if p44 == nil then
        return v76(p42, p43)
    else
        return v55(p42, p43, p44)
    end
end
local function u85(p78, p79) --[[ Line: 285 ]]
    table.sort(p79, function(p80, p81) --[[ Line: 288 ]]
        return p80.index < p81.index
    end)
    local v82 = p79[1].index
    local v83 = {}
    for v84 = 1, #p78 do
        v83[#v83 + 1] = p78[v84]
        if v84 == v82 then
            v83[#v83 + 1] = table.remove(p79, 1)
            if #p79 == 0 then
                v82 = nil
            else
                v82 = p79[1].index
            end
        end
    end
    return v83
end
local function u89(p86, p87) --[[ Line: 307 ]]
    for v88 = 1, #p86 do
        if p87 then
            if p86[v88].pairIndex == p87 then
                return v88, p86[v88].pairIndex
            end
        elseif p86[v88].pairIndex then
            return v88, p86[v88].pairIndex
        end
    end
    return nil, p87
end
local function u99(p90, p91, p92, p93) --[[ Line: 323 ]]
    local v94 = 0
    local v95 = {}
    local v96 = {}
    while v94 < 2 do
        v95[#v95 + 1] = p90[p91]
        if p90[p91].pairIndex == p92 then
            v94 = v94 + 1
        end
        if v94 < 2 then
            p91 = p91 + 1
        end
        p91 = #p90 < p91 and 1 or p91
    end
    local v97 = 0
    while v97 < 2 do
        v96[#v96 + 1] = p90[p91]
        if p90[p91].pairIndex == p92 then
            v97 = v97 + 1
        end
        if v97 < 2 then
            p91 = p91 + 1
        end
        p91 = #p90 < p91 and 1 or p91
    end
    if p93 then
        local _ = #v95
        local _ = #v96
        local v98 = p93[v95[1].pathIndex]
        if lengthOf(v95[#v95], v98[1]) < lengthOf(v95[#v95], v98[#v98]) then
            v95 = table.copy(v95, v98)
        else
            v95 = table.copy(v95, table.reverse(v98))
        end
        if lengthOf(v96[#v96], v98[1]) < lengthOf(v96[#v96], v98[#v98]) then
            v96 = table.copy(v96, v98)
        else
            v96 = table.copy(v96, table.reverse(v98))
        end
        for _ = 1, #v95 do

        end
        for _ = 1, #v96 do

        end
    end
    return v95, v96
end
function v1.dissect(_, p100, p101, p102) --[[ Line: 397 ]]
    --[[
    Upvalues:
        [1] = u41
        [2] = u77
        [3] = u85
        [4] = u89
        [5] = u99
    --]]
    local v103 = u41(p100, 1, 0)
    local v104, v105 = u77(v103, p101, p102)
    if #v104 < 2 then
        return {}
    end
    local v106 = u85(v103, v104)
    local v107 = v106
    for v108 = 1, #v106 do
        if v106[v108].pairIndex then
            local _ = v106[v108].pairIndex
            v112 = { v107 }
            v113 = 1
            v114 = 1
            ::l12::
            while v113 <= #v112 do
                local v109
                v109, v114 = u89(v112[v113], v114)
                if v109 then
                    local v110, v111 = u99(v112[v113], v109, v114, v105)
                    table.remove(v112, v113)
                    v112[#v112 + 1] = v110
                    v112[#v112 + 1] = v111
                    v114 = v114 + 2
                    v113 = 0
                end
                v113 = v113 + 1
            end
            return v112
        end
    end
    local v112 = { v107 }
    local v113 = 1
    local v114 = 1
    goto l12
end
return v1