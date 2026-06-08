-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = {}
function CreateWedge(p2, p3, p4, p5, p6, p7, p8, p9)
    local v10 = script[p9]:Clone()
    if p6 ~= Enum.Material.Grass then
        v10.Material = p6
    end
    v10.Size = p3
    v10.Color = p4
    v10.CFrame = p2
    if p7 then
        if p8 == "Right" then
            local v11 = p7:Clone()
            v11.Parent = v10
            v11.Face = Enum.NormalId.Left
        else
            local v12 = p7:Clone()
            v12.Parent = v10
            v12.Face = Enum.NormalId.Right
        end
    else
        v10.Transparency = 0
    end
    v10.Parent = p5
end
function dotv2(p13, p14)
    return p13.x * p14.x + p13.y * p14.y
end
function v1.Triangle(_, p15, p16, p17, p18, p19, p20, p21, p22) --[[ Line: 34 ]]
    local v23 = p20 == 0 and 0.4 or p20
    local v24 = Vector2.new(p15.X, p15.Z)
    local v25 = Vector2.new(p16.X, p16.Z)
    local v26 = Vector2.new(p17.X, p17.Z)
    local v27 = {
        {
            ["longest"] = v26 - v25,
            ["other"] = v24 - v25,
            ["position"] = v25
        },
        {
            ["longest"] = v24 - v26,
            ["other"] = v25 - v26,
            ["position"] = v26
        },
        {
            ["longest"] = v25 - v24,
            ["other"] = v26 - v24,
            ["position"] = v24
        }
    }
    table.sort(v27, function(p28, p29) --[[ Line: 48 ]]
        return p28.longest.magnitude > p29.longest.magnitude
    end)
    local v30 = v27[1]
    local v31 = dotv2(v30.longest.unit, v30.other.unit)
    v30.angle = math.acos(v31)
    local v32 = v30.other.magnitude
    local v33 = v30.angle
    v30.x = v32 * math.cos(v33)
    local v34 = v30.other.magnitude
    local v35 = v30.angle
    v30.y = v34 * math.sin(v35)
    local v36 = v30.longest.unit * v30.x - v30.other
    local v37 = v36.y
    local v38 = v36.x
    local v39 = math.atan2(v37, v38) - 1.5707963267948966
    local v40 = -v30.other
    local v41 = v30.longest.unit * v30.x - v30.other
    local v42 = v40.x * v41.y - v40.y * v41.x
    local v43 = v30.position + v30.other
    local v44 = v42 > 0 and v30.position + v30.longest - v41 or v30.position - v41
    local v45 = Vector2.new((v43 - v44).magnitude, v30.y)
    local v46 = Vector2.new(v30.longest.magnitude - v45.x, v30.y)
    local v47 = v23 + 10
    local v48 = v45.x
    local v49 = v45.y
    local v50 = Vector3.new(v47, v48, v49)
    local v51 = v23 + 10
    local v52 = v46.x
    local v53 = v46.y
    local v54 = Vector3.new(v51, v52, v53)
    local v55 = CFrame.new(v43.x, p15.Y + v23 / 2 - 5, v43.y) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(-v39, 0, 0) * CFrame.Angles(0, 0, 0) * CFrame.new(0, v45.x / 2, v45.y / 2)
    local v56 = CFrame.new(v44.x, p15.Y + v23 / 2 - 5, v44.y) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(-v39, 0, 0) * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, v46.x / 2 + v45.x, v46.y / 2)
    CreateWedge(v55, v50, p18, p19, p21, p22, "Left", "WedgeRight")
    CreateWedge(v56, v54, p18, p19, p21, p22, "Right", "WedgeLeft")
    return 2
end
return v1