-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local u1 = Vector3.new
local u2 = CFrame.new
local _ = CFrame.Angles
local u3 = Ray.new
local _ = math.rad
local v4 = {}
function QuickRemove(p5, p6)
    local v7 = #p5
    p5[p6] = p5[v7]
    p5[v7] = nil
end
local function u21(p8, p9, p10, p11, p12, p13, p14) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v15 = 0
    if p8.y > 0.05 and p8.z > 0.05 then
        local v16 = p9 * u2(p12 / 2, 0, 0)
        local v17 = p9 * u2(-p12 / 2, 0, 0)
        local v18 = v16.p.Y < v17.p.Y and v16 and v16 or v17
        local v19 = v18 == v16 and "WedgeLeft" or "WedgeRight"
        if v18.p.y > -1000 then
            local v20 = script[v19]:Clone()
            v20.CFrame = v18
            v20.Size = p8
            v20.Color = p10
            v20.CastShadow = false
            if p13 then
                v20.CastShadow = true
            end
            if p14 == "Off" then
                v20.Material = Enum.Material.SmoothPlastic
            end
            v20.Parent = p11
            v15 = 1
        end
    end
    return v15
end
function v4.Triangle(_, p22, p23, p24, p25, p26, p27, p28, p29) --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u21
        [3] = u1
        [4] = u2
    --]]
    local v30 = true
    local v31 = 0
    local v32 = 0
    local v33 = nil
    while v30 and v31 < 100000 do
        v31 = v31 + 1
        local v34 = u3(p22, (p24 - p22).unit):ClosestPoint(p23)
        if (v34 - u3(p24, (p22 - p24).unit):ClosestPoint(p23)).magnitude > 0.05 then
            v34 = v33
            local v35 = p23
            p23 = p22
            p22 = p24
            p24 = v35
        else
            v30 = false
        end
        v33 = v34
    end
    if v30 == false then
        local v36 = p22:lerp(p23, 0.5)
        local v37 = (p23:lerp(v33, 0.5) - v36).unit
        local v38 = (p22:lerp(v33, 0.5) - v36).unit * -1
        local v39 = v38:Cross(v37)
        v32 = v32 + u21(u1(p27, (p23 - v33).magnitude, (p22 - v33).magnitude), u2(v36.x, v36.y, v36.z, v39.x, v38.x, v37.x, v39.y, v38.y, v37.y, v39.z, v38.z, v37.z), p25, p26, p27, p28, p29)
        if (v33 - p22).magnitude > 0.001 or (v33 - p24).magnitude > 0.001 then
            local v40 = p24:lerp(p23, 0.5)
            local v41 = (p23:lerp(v33, 0.5) - v40).unit
            local v42 = (p24:lerp(v33, 0.5) - v40).unit * -1
            local v43 = v42:Cross(v41)
            v32 = v32 + u21(u1(p27, (p23 - v33).magnitude, (p24 - v33).magnitude), u2(v40.x, v40.y, v40.z, v43.x, v42.x, v41.x, v43.y, v42.y, v41.y, v43.z, v42.z, v41.z), p25, p26, p27, p28, p29)
        end
    end
    return v32
end
return v4