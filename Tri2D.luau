-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = {}
function CreateWedge(p2, p3, p4, _, p5, _, p6, p7, p8, p9, p10)
    local v11 = script.Wedge:Clone()
    if p6 ~= Enum.Material.Grass then
        v11.Material = p6
    end
    v11.Size = p3
    v11.Color = p4
    v11.CFrame = p2
    if p7 then
        v11.Transparency = 1
        if p3.x > 5 then
            v11.CastShadow = true
        end
        if p9[2] then
            local v12 = p7:Clone()
            v12.Parent = v11
            v12.Face = Enum.NormalId.Front
        end
        if p9[3] then
            local v13 = p7:Clone()
            v13.Parent = v11
            v13.Face = Enum.NormalId.Back
        end
    end
    if p8 then
        if p10 == "Right" then
            local v14 = p8:Clone()
            v14.Parent = v11
            v14.Face = Enum.NormalId.Left
        else
            local v15 = p8:Clone()
            v15.Parent = v11
            v15.Face = Enum.NormalId.Right
        end
    end
    v11.Parent = p5
end
function dotv2(p16, p17)
    return p16.x * p17.x + p16.y * p17.y
end
function v1.Triangle(_, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28) --[[ Line: 55 ]]
    local v29 = Vector2.new(p18.X, p18.Z)
    local v30 = Vector2.new(p19.X, p19.Z)
    local v31 = Vector2.new(p20.X, p20.Z)
    local v32 = {
        {
            ["longest"] = v31 - v30,
            ["other"] = v29 - v30,
            ["position"] = v30
        },
        {
            ["longest"] = v29 - v31,
            ["other"] = v30 - v31,
            ["position"] = v31
        },
        {
            ["longest"] = v30 - v29,
            ["other"] = v31 - v29,
            ["position"] = v29
        }
    }
    table.sort(v32, function(p33, p34) --[[ Line: 66 ]]
        return p33.longest.magnitude > p34.longest.magnitude
    end)
    local v35 = v32[1]
    local v36 = dotv2(v35.longest.unit, v35.other.unit)
    v35.angle = math.acos(v36)
    local v37 = v35.other.magnitude
    local v38 = v35.angle
    v35.x = v37 * math.cos(v38)
    local v39 = v35.other.magnitude
    local v40 = v35.angle
    v35.y = v39 * math.sin(v40)
    local v41 = v35.longest.unit * v35.x - v35.other
    local v42 = v41.y
    local v43 = v41.x
    local v44 = math.atan2(v42, v43) - 1.5707963267948966
    local v45 = -v35.other
    local v46 = v35.longest.unit * v35.x - v35.other
    local v47 = v45.x * v46.y - v45.y * v46.x
    local v48 = v35.position + v35.other
    local v49 = v47 > 0 and v35.position + v35.longest - v46 or v35.position - v46
    local v50 = Vector2.new((v48 - v49).magnitude, v35.y)
    local v51 = Vector2.new(v35.longest.magnitude - v50.x, v35.y)
    local v52 = p23 + 10
    local v53 = v50.x
    local v54 = v50.y
    local v55 = Vector3.new(v52, v53, v54)
    local v56 = p23 + 10
    local v57 = v51.x
    local v58 = v51.y
    local v59 = Vector3.new(v56, v57, v58)
    local v60 = CFrame.new(v48.x, p18.Y + p23 / 2 - 5, v48.y) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(-v44, 0, 0) * CFrame.Angles(0, 0, 0) * CFrame.new(0, v50.x / 2, v50.y / 2)
    local v61 = CFrame.new(v49.x, p18.Y + p23 / 2 - 5, v49.y) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(-v44, 0, 0) * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, v51.x / 2 + v50.x, v51.y / 2)
    local v62 = {}
    local v63
    if v35.position == v29 then
        v63 = { p28[2], p28[3], p28[1] }
    elseif v35.position == v30 then
        v63 = { p28[3], p28[1], p28[2] }
    else
        v63 = v35.position == v31 and { p28[1], p28[2], p28[3] } or v62
    end
    CreateWedge(v60, v55, p21, true, p22, p24, p25, p26, p27, v63, "Left")
    CreateWedge(v61, v59, p21, true, p22, p24, p25, p26, p27, { v63[2], v63[1], v63[3] }, "Right")
    return 2
end
return v1