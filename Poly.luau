-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local u1 = setmetatable
local u2 = tostring
local u3 = assert
local u4 = unpack or table.unpack
local u5 = table.remove
local u6 = math.sqrt
local u7 = math.max
local function v10(...) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u8 = {}
    u8.__index = u8
    function u8.__call(_, ...) --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        return u8:new(...)
    end
    function u8.new(_, ...) --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u1
        --]]
        local v9 = u1({}, u8)
        u8.__init(v9, ...)
        return v9
    end
    return u1(u8, {
        ["__call"] = u8.__call
    })
end
local u11 = v10()
function u11.__eq(p12, p13) --[[ Line: 59 ]]
    local v14
    if p12.p1 == p13.p1 then
        v14 = p12.p2 == p13.p2
    else
        v14 = false
    end
    return v14
end
function u11.__tostring(p15) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return ("Edge :\n  %s\n  %s"):format(u2(p15.p1), (u2(p15.p2)))
end
function u11.__init(p16, p17, p18) --[[ Line: 77 ]]
    p16.p1 = p17
    p16.p2 = p18
end
function u11.same(p19, p20) --[[ Line: 90 ]]
    local v21
    if p19.p1 == p20.p1 and p19.p2 == p20.p2 then
        v21 = true
    elseif p19.p1 == p20.p2 then
        v21 = p19.p2 == p20.p1
    else
        v21 = false
    end
    return v21
end
function u11.length(p22) --[[ Line: 101 ]]
    return p22.p1:dist(p22.p2)
end
function u11.getMidPoint(p23) --[[ Line: 112 ]]
    return p23.p1.x + (p23.p2.x - p23.p1.x) / 2, p23.p1.y + (p23.p2.y - p23.p1.y) / 2
end
local u24 = v10()
function u24.__eq(p25, p26) --[[ Line: 121 ]]
    local v27
    if p25.x == p26.x then
        v27 = p25.y == p26.y
    else
        v27 = false
    end
    return v27
end
function u24.__tostring(p28) --[[ Line: 122 ]]
    return ("Point (%s) x: %.2f y: %.2f"):format(p28.id, p28.x, p28.y)
end
function u24.__init(p29, p30, p31) --[[ Line: 138 ]]
    p29.x = p30 or 0
    p29.y = p31 or 0
    p29.id = "?"
end
function u24.dist2(p32, p33) --[[ Line: 149 ]]
    local v34 = p32.x - p33.x
    local v35 = p32.y - p33.y
    return v34 * v34 + v35 * v35
end
function u24.dist(p36, p37) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6((p36:dist2(p37)))
end
function u24.isInCircle(p38, p39, p40, p41) --[[ Line: 174 ]]
    local v42 = p39 - p38.x
    local v43 = p40 - p38.y
    return v42 * v42 + v43 * v43 <= p41 * p41
end
local u44 = v10()
function u44.__tostring(p45) --[[ Line: 184 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return ("Triangle: \n  %s\n  %s\n  %s"):format(u2(p45.p1), u2(p45.p2), (u2(p45.p3)))
end
function u44.__init(p46, p47, p48, p49) --[[ Line: 203 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u11
    --]]
    local v50 = p48.x - p47.x
    local v51 = p49.x - p48.x
    local v52 = p48.y - p47.y
    u3(v50 * (p49.y - p48.y) - v52 * v51 ~= 0, ("angle (p1, p2, p3) is flat:\n  %s\n  %s\n  %s"):format(u2(p47), u2(p48), (u2(p49))))
    p46.p1 = p47
    p46.p2 = p48
    p46.p3 = p49
    local v53 = u11(p47, p48)
    local v54 = u11(p48, p49)
    local v55 = u11(p49, p47)
    p46.e1 = v53
    p46.e2 = v54
    p46.e3 = v55
end
function u44.isCW(p56) --[[ Line: 217 ]]
    local v57 = p56.p1
    local v58 = p56.p2
    local v59 = p56.p3
    local v60 = v58.x - v57.x
    local v61 = v59.x - v58.x
    local v62 = v58.y - v57.y
    return v60 * (v59.y - v58.y) - v62 * v61 < 0
end
function u44.isCCW(p63) --[[ Line: 228 ]]
    local v64 = p63.p1
    local v65 = p63.p2
    local v66 = p63.p3
    local v67 = v65.x - v64.x
    local v68 = v66.x - v65.x
    local v69 = v65.y - v64.y
    return v67 * (v66.y - v65.y) - v69 * v68 > 0
end
function u44.getSidesLength(p70) --[[ Line: 241 ]]
    return p70.e1:length(), p70.e2:length(), p70.e3:length()
end
function u44.getCenter(p71) --[[ Line: 253 ]]
    return (p71.p1.x + p71.p2.x + p71.p3.x) / 3, (p71.p1.y + p71.p2.y + p71.p3.y) / 3
end
function u44.getCircumCircle(p72) --[[ Line: 268 ]]
    local v73, v74 = p72:getCircumCenter()
    return v73, v74, p72:getCircumRadius()
end
function u44.getCircumCenter(p75) --[[ Line: 282 ]]
    local v76 = p75.p1
    local v77 = p75.p2
    local v78 = p75.p3
    local v79 = (v76.x * (v77.y - v78.y) + v77.x * (v78.y - v76.y) + v78.x * (v76.y - v77.y)) * 2
    local v80 = (v76.x * v76.x + v76.y * v76.y) * (v77.y - v78.y) + (v77.x * v77.x + v77.y * v77.y) * (v78.y - v76.y) + (v78.x * v78.x + v78.y * v78.y) * (v76.y - v77.y)
    local v81 = (v76.x * v76.x + v76.y * v76.y) * (v78.x - v77.x) + (v77.x * v77.x + v77.y * v77.y) * (v76.x - v78.x) + (v78.x * v78.x + v78.y * v78.y) * (v77.x - v76.x)
    return v80 / v79, v81 / v79
end
function u44.getCircumRadius(p82) --[[ Line: 303 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v83, v84, v85 = p82:getSidesLength()
    return v83 * v84 * v85 / u6((v83 + v84 + v85) * (v83 + v84 - v85) * (v83 - v84 + v85) * (-v83 + v84 + v85))
end
function u44.getArea(p86) --[[ Line: 315 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v87, v88, v89 = p86:getSidesLength()
    return u6((v87 + v88 + v89) * (v87 + v88 - v89) * (v87 - v88 + v89) * (-v87 + v88 + v89)) / 4
end
function u44.inCircumCircle(p90, p91) --[[ Line: 328 ]]
    return p91:isInCircle(p90:getCircumCircle())
end
local u122 = {
    ["convexMultiplier"] = 1000,
    ["_VERSION"] = "0.1",
    ["Point"] = u24,
    ["Edge"] = u11,
    ["Triangle"] = u44,
    ["triangulate"] = function(...) --[[ Name: triangulate, Line 362 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u44
            [3] = u4
            [4] = u122
            [5] = u7
            [6] = u24
            [7] = u5
        --]]
        local v92 = { ... }
        local v93 = #v92
        u3(v93 > 2, "Cannot triangulate, needs more than 3 vertices")
        if v93 == 3 then
            return { u44(u4(v92)) }
        end
        local v94 = v93 * 4
        local v95 = v92[1].x
        local v96 = v92[1].y
        local v97 = v96
        local v98 = v95
        for v99 = 1, #v92 do
            local v100 = v92[v99]
            v100.id = v99
            if v100.x < v95 then
                v95 = v100.x
            end
            if v100.y < v96 then
                v96 = v100.y
            end
            if v98 < v100.x then
                v98 = v100.x
            end
            if v97 < v100.y then
                v97 = v100.y
            end
        end
        local v101 = u122.convexMultiplier
        local v102 = u7((v98 - v95) * v101, (v97 - v96) * v101)
        local v103 = (v95 + v98) * 0.5
        local v104 = (v96 + v97) * 0.5
        local v105 = u24(v103 - v102 * 2, v104 - v102)
        local v106 = u24(v103, v104 + v102 * 2)
        local v107 = u24(v103 + v102 * 2, v104 - v102)
        local v108 = v93 + 1
        local v109 = v93 + 2
        local v110 = v93 + 3
        v105.id = v108
        v106.id = v109
        v107.id = v110
        v92[v105.id] = v105
        v92[v106.id] = v106
        v92[v107.id] = v107
        local v111 = {
            [#v111 + 1] = u44(v92[v93 + 1], v92[v93 + 2], v92[v93 + 3])
        }
        for v112 = 1, v93 do
            local _ = #v111
            local v113 = {}
            for v114 = #v111, 1, -1 do
                local v115 = v111[v114]
                if v115:inCircumCircle(v92[v112]) then
                    v113[#v113 + 1] = v115.e1
                    v113[#v113 + 1] = v115.e2
                    v113[#v113 + 1] = v115.e3
                    u5(v111, v114)
                end
            end
            for v116 = #v113 - 1, 1, -1 do
                for v117 = #v113, v116 + 1, -1 do
                    if v113[v116] and (v113[v117] and v113[v116]:same(v113[v117])) then
                        u5(v113, v116)
                        u5(v113, v117 - 1)
                    end
                end
            end
            for v118 = 1, #v113 do
                local v119 = #v111
                u3(v119 <= v94, "Generated more than needed triangles")
                v111[v119 + 1] = u44(v113[v118].p1, v113[v118].p2, v92[v112])
            end
        end
        for v120 = #v111, 1, -1 do
            local v121 = v111[v120]
            if v93 < v121.p1.id or (v93 < v121.p2.id or v93 < v121.p3.id) then
                u5(v111, v120)
            end
        end
        u5(v92)
        u5(v92)
        u5(v92)
        return v111
    end
}
return u122