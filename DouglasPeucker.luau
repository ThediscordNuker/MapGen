-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = {}
function getSqDist(p2, p3)
    local v4 = p2.x - p3.x
    local v5 = p2.y - p3.y
    return v4 * v4 + v5 * v5
end
function getSqSegDist(p6, p7, p8)
    local v9 = p7.x
    local v10 = p7.y
    local v11 = p8.x - v9
    local v12 = p8.y - v10
    if v11 ~= 0 or v12 ~= 0 then
        local v13 = ((p6.x - v9) * v11 + (p6.y - v10) * v12) / (v11 * v11 + v12 * v12)
        if v13 > 1 then
            v9 = p8.x
            v10 = p8.y
        elseif v13 > 0 then
            v9 = v9 + v11 * v13
            v10 = v10 + v12 * v13
        end
    end
    local v14 = p6.x - v9
    local v15 = p6.y - v10
    return v14 * v14 + v15 * v15
end
function simplifyRadialDist(p16, p17)
    local v18 = p16[1]
    local v19 = { v18 }
    local v20 = nil
    for v21 = 2, #p16 do
        v20 = p16[v21]
        if p17 < getSqDist(v20, v18) then
            table.insert(v19, v20)
            v18 = v20
        end
    end
    if v18 ~= v20 then
        table.insert(v19, v20)
    end
    return v19
end
function simplifyDPStep(p22, p23, p24, p25, p26)
    local v27 = p25
    local v28 = nil
    for v29 = p23 + 1, p24 do
        local v30 = getSqSegDist(p22[v29], p22[p23], p22[p24])
        if p25 < v30 then
            v28 = v29
            p25 = v30
        end
    end
    if v27 < p25 then
        if v28 - p23 > 1 then
            simplifyDPStep(p22, p23, v28, v27, p26)
        end
        local v31 = p22[v28]
        table.insert(p26, v31)
        if p24 - v28 > 1 then
            simplifyDPStep(p22, v28, p24, v27, p26)
        end
    end
end
function simplifyDouglasPeucker(p32, p33)
    local v34 = #p32
    local v35 = { p32[1] }
    simplifyDPStep(p32, 1, v34, p33, v35)
    local v36 = p32[v34]
    table.insert(v35, v36)
    return v35
end
function v1.Calc(_, p37, p38, p39) --[[ Line: 95 ]]
    tick()
    if #p37 <= 2 then
        return p37
    end
    local v40 = p38 == nil and 1 or (p38 ^ 2 or 1)
    local v41 = p39 and p37 and p37 or simplifyRadialDist(p37, v40)
    return simplifyDouglasPeucker(v41, v40)
end
return v1