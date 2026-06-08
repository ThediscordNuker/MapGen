-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

IndexedPoly = {}
IndexedPoly.__index = IndexedPoly
function IndexedPoly.previous(p1, p2) --[[ Line: 12 ]]
    local v3 = p1.previous_index[p2]
    if not v3 then
        local v4 = p2 - 1
        local v5 = p1.chain_size
        v3 = (v4 - 1) % v5 + 1
    end
    return v3
end
function IndexedPoly.next(p6, p7) --[[ Line: 16 ]]
    local v8 = p6.next_index[p7]
    if not v8 then
        local v9 = p7 + 1
        local v10 = p6.chain_size
        v8 = (v9 - 1) % v10 + 1
    end
    return v8
end
function IndexedPoly.get_triangle(p11, p12, p13) --[[ Line: 20 ]]
    if p13 then
        local v14 = {}
        local v15 = p11:next(p12)
        local v16 = p11.chain_size
        __set_list(v14, 1, {v15, (p12 - 1) % v16 + 1, p11:previous(p12)})
        return v14
    else
        local v17 = {}
        local v18 = p11:previous(p12)
        local v19 = p11.chain_size
        __set_list(v17, 1, {v18, (p12 - 1) % v19 + 1, p11:next(p12)})
        return v17
    end
end
function IndexedPoly.remove(p20, p21) --[[ Line: 28 ]]
    local v22 = p20:next(p21)
    local v23 = p20:previous(p21)
    p20.next_index[v23] = v22
    p20.previous_index[v22] = v23
    p20.next_index[p21] = nil
    p20.previous_index[p21] = nil
end
function IndexedPoly.new(p24) --[[ Line: 37 ]]
    local v25 = IndexedPoly
    return setmetatable({
        ["chain_size"] = p24,
        ["previous_index"] = {},
        ["next_index"] = {}
    }, v25)
end
local u26 = {}
u26.__index = u26
function u26.is_closed(p27) --[[ Line: 45 ]]
    local v28 = #p27
    local v29
    if v28 >= 6 and p27[1] == p27[v28 - 1] then
        v29 = p27[2] == p27[v28]
    else
        v29 = false
    end
    return v29
end
function u26.is_convex(p30) --[[ Line: 51 ]]
    if not p30:is_closed() then
        return false
    end
    local v31 = p30:get_coord_count() - 1
    local v32 = 0
    for v33 = 1, v31 do
        local v34 = p30:compute_zcross_product(v31, v33, v33 + 1)
        if v32 == 0 then
            v32 = v34
        elseif v32 * v34 < 0 then
            return false
        end
        v31 = v33
    end
    return true
end
function u26.revert_winding(p35) --[[ Line: 72 ]]
    local v36 = p35:is_closed() and #p35 - 2 or #p35
    for v37 = 1, (v36 - 2) / 2, 2 do
        local v38 = v37 + 2
        local v39 = v36 - v37
        local v40 = p35[v36 - v37]
        local v41 = p35[v37 + 2]
        p35[v38] = v40
        p35[v39] = v41
        local v42 = v37 + 3
        local v43 = v36 - v37 + 1
        local v44 = p35[v36 - v37 + 1]
        local v45 = p35[v37 + 3]
        p35[v42] = v44
        p35[v43] = v45
    end
end
function u26.is_cw(p46) --[[ Line: 80 ]]
    if not p46:is_closed() then
        return false
    end
    local v47 = 0
    for v48 = 1, p46:get_coord_count() - 1 do
        v47 = v47 + p46:compute_subsurface(v48, v48 + 1)
    end
    return v47 >= 0
end
function u26.compute_zcross_product(p49, p50, p51, p52) --[[ Line: 92 ]]
    local v53, v54 = p49:get_coord(p50)
    local v55, v56 = p49:get_coord(p51)
    local v57, v58 = p49:get_coord(p52)
    return (v53 - v55) * (v58 - v56) - (v54 - v56) * (v57 - v55)
end
function u26.compute_subsurface(p59, p60, p61) --[[ Line: 100 ]]
    local v62, v63 = p59:get_coord(p60)
    local v64, v65 = p59:get_coord(p61)
    return (v64 - v62) * (v65 + v63)
end
local function u70(p66, p67, p68) --[[ Line: 107 ]]
    for v69, _ in pairs(p68) do
        if p66:compute_zcross_product(v69, p67[2], p67[3]) > 0 and (p66:compute_zcross_product(v69, p67[3], p67[1]) > 0 and p66:compute_zcross_product(v69, p67[1], p67[2]) > 0) then
            return false
        end
    end
    return true
end
function u26.get_triangles(p71) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u70
    --]]
    if not p71:is_closed() then
        return nil
    end
    local v72 = IndexedPoly.new(p71:get_coord_count() - 1)
    local v73 = p71:get_coord_count() - 1
    local v74 = v73
    local v75 = {}
    local v76 = 0
    local v77 = {}
    local v78 = {}
    for v79 = 1, v73 do
        if p71:compute_zcross_product(v73, v79, v79 + 1) < 0 then
            v75[v79] = 1
        else
            v77[v79] = 1
        end
        v76 = v76 + p71:compute_subsurface(v79, v79 + 1)
        v73 = v79
    end
    local v80 = v76 < 0 and -1 or 1
    if v80 < 0 then
        local v81 = v75
        v75 = v77
        v77 = v81
    end
    local v82 = {}
    for v83, _ in pairs(v77) do
        if u70(p71, v72:get_triangle(v83, v80 < 0), v75) then
            table.insert(v82, v83)
            v78[v83] = 1
        end
    end
    local v84 = {}
    for v85 = 1, v74 - 2 do
        local v86
        if v85 % 2 == 1 then
            v86 = v82[1]
            table.remove(v82, 1)
        else
            v86 = v82[#v82]
            table.remove(v82)
        end
        v77[v86] = nil
        v78[v86] = nil
        local v87 = v72:get_triangle(v86, v80 < 0)
        table.insert(v84, v87)
        v72:remove(v86)
        for v88, v89 in ipairs({ v87[1], v87[3] }) do
            local v90 = v72:get_triangle(v89, v80 < 0)
            if v75[v89] and p71:compute_zcross_product(v90[1], v90[2], v90[3]) >= 0 then
                v75[v89] = nil
                v77[v89] = 1
            end
            if v77[v89] and u70(p71, v90, v75) then
                if not v78[v89] then
                    local v91 = v88 == 1 and 1 or #v82
                    table.insert(v82, v91, v89)
                    v78[v89] = 1
                end
            elseif v78[v89] then
                for v92, v93 in ipairs(v82) do
                    if v93 == v89 then
                        table.remove(v82, v92)
                        break
                    end
                end
                v78[v89] = nil
            end
        end
    end
    return v84
end
function u26.get_coord_count(p94) --[[ Line: 211 ]]
    return #p94 / 2
end
function u26.get_coord(p95, p96) --[[ Line: 215 ]]
    return p95[p96 * 2 - 1], p95[p96 * 2]
end
function u26.push_coord(p97, p98, p99) --[[ Line: 219 ]]
    table.insert(p97, p98)
    table.insert(p97, p99)
end
function u26.pop_coord(p100) --[[ Line: 224 ]]
    if #p100 > 1 then
        table.remove(p100)
        table.remove(p100)
    end
end
function u26.close(p101) --[[ Line: 231 ]]
    if #p101 < 6 or p101:is_closed() then
        return false
    end
    local v102 = p101[1]
    table.insert(p101, v102)
    local v103 = p101[2]
    table.insert(p101, v103)
    return true
end
return function(p104) --[[ Line: 240 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    local v105 = u26
    return setmetatable(p104 or {}, v105)
end