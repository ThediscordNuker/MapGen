-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = {}
function MakeRunwayNumbers(p2, p3, p4)
    if #p4 == 2 then
        local v5 = script.RunwayNumbers:FindFirstChild((string.sub(p4, 1, 1))):Clone()
        v5.CFrame = CFrame.new(p3 * (p2.Size.Z / 2) - 20 * p3, p2.Size.Y / 2 - 0.335, p3 * (v5.Size.Z / 2 + 0.5)) * CFrame.Angles(0, -1.5707963267948966 * p3, 0)
        v5.Parent = p2
        local v6 = script.RunwayNumbers:FindFirstChild((string.sub(p4, 2, 2))):Clone()
        v6.CFrame = CFrame.new(p3 * (p2.Size.Z / 2) - 20 * p3, p2.Size.Y / 2 - 0.335, p3 * (-v6.Size.Z / 2 - 0.5)) * CFrame.Angles(0, -1.5707963267948966 * p3, 0)
        v6.Parent = p2
    else
        local v7 = script.RunwayNumbers:FindFirstChild(p4):Clone()
        v7.CFrame = CFrame.new(p3 * (p2.Size.Z / 2) - 20 * p3, p2.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, -1.5707963267948966 * p3, 0)
        v7.Parent = p2
    end
end
local u8 = require(game.ReplicatedStorage.MapData.Declination)
function FindDeclinationLatLon(p9, p10)
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v11 = math.floor(p9)
    local v12 = math.clamp(v11, -80, 80)
    local v13 = math.floor(p10)
    local v14 = math.clamp(v13, -180, 180)
    return u8[(v12 + 80) * 360 + (v14 + 180)]
end
function v1.new(p15, p16, p17) --[[ Line: 29 ]]
    local v18 = p15.PrimaryPart
    local v19 = v18.CFrame
    local _, _, _, _, _, v20, _, _, _, _, _, v21 = v18.CFrame:components()
    p15:SetPrimaryPartCFrame(CFrame.new() * CFrame.Angles(0, -1.5707963267948966, 0))
    if p16.Numbers then
        local v22 = math.atan2(v20, v21)
        local v23 = (-5 - math.deg(v22) - FindDeclinationLatLon(p17[1], p17[2])) % 360
        local v24 = v23 / 10
        local v25 = math.ceil(v24)
        local v26 = v25 == 0 and 36 or v25
        MakeRunwayNumbers(v18, -1, (tostring(v26)))
        local v27 = (v23 + 180) % 360 / 10
        local v28 = math.ceil(v27)
        local v29 = v28 == 0 and 36 or v28
        MakeRunwayNumbers(v18, 1, (tostring(v29)))
    end
    if p16.Threshold then
        local v30 = v18.Size.X / 2.5
        for v31 = 1, math.ceil(v30) do
            local v32 = script.Line:Clone()
            v32.Size = Vector3.new(15, 0.7, 0.6)
            v32.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 8, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v31 * 0.9)
            v32.Parent = v18
            local v33 = script.Line:Clone()
            v33.Size = Vector3.new(15, 0.7, 0.6)
            v33.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 8, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v31 * 0.9)
            v33.Parent = v18
            local v34 = script.Line:Clone()
            v34.Size = Vector3.new(15, 0.7, 0.6)
            v34.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 8, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v31 * 0.9)
            v34.Parent = v18
            local v35 = script.Line:Clone()
            v35.Size = Vector3.new(15, 0.7, 0.6)
            v35.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 8, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v31 * 0.9)
            v35.Parent = v18
        end
    end
    if p16.Outline then
        local v36 = script.Line:Clone()
        local v37 = v18.Size.Z + 0.3
        v36.Size = Vector3.new(v37, 0.7, 0.3)
        v36.CFrame = CFrame.new(0, v18.Size.Y / 2 - 0.335, -v18.Size.X / 2)
        v36.Parent = v18
        local v38 = script.Line:Clone()
        local v39 = v18.Size.Z + 0.3
        v38.Size = Vector3.new(v39, 0.7, 0.3)
        v38.CFrame = CFrame.new(0, v18.Size.Y / 2 - 0.335, v18.Size.X / 2)
        v38.Parent = v18
        local v40 = script.Line:Clone()
        local v41 = v18.Size.X - 0.3
        v40.Size = Vector3.new(0.3, 0.7, v41)
        v40.CFrame = CFrame.new(-v18.Size.Z / 2, v18.Size.Y / 2 - 0.335, 0)
        v40.Parent = v18
        local v42 = script.Line:Clone()
        local v43 = v18.Size.X - 0.3
        v42.Size = Vector3.new(0.3, 0.7, v43)
        v42.CFrame = CFrame.new(v18.Size.Z / 2, v18.Size.Y / 2 - 0.335, 0)
        v42.Parent = v18
    end
    if p16.Stripes then
        local v44 = script.Line:Clone()
        v44.Size = Vector3.new(12, 0.7, 0.2)
        v44.CFrame = CFrame.new(0, v18.Size.Y / 2 - 0.335, 0)
        v44.Parent = v18
        local v45 = (v18.Size.Z - 80) / 40
        for v46 = 1, math.floor(v45) do
            local v47 = script.Line:Clone()
            v47.Size = Vector3.new(12, 0.7, 0.2)
            v47.CFrame = CFrame.new(v46 * 20, v18.Size.Y / 2 - 0.335, 0)
            v47.Parent = v18
            local v48 = script.Line:Clone()
            v48.Size = Vector3.new(12, 0.7, 0.2)
            v48.CFrame = CFrame.new(v46 * -20, v18.Size.Y / 2 - 0.335, 0)
            v48.Parent = v18
        end
    end
    if p16.Blast then
        local v49 = v18.Size.X / 2 * 1.4142135623730951 - 1
        local v50 = v18.Size.X / 4
        local v51 = script.BlastLine:Clone()
        local v52 = v49 + 0.2
        v51.Size = Vector3.new(v52, 0.7, 0.2)
        v51.CFrame = CFrame.new(v50, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 2.356194490192345, 0) * CFrame.new(v49 / 2, 0, 0)
        v51.Parent = v18
        local v53 = (v18.Size.Z - 10) / 10
        for v54 = 1, math.floor(v53) do
            local v55 = script.BlastLine:Clone()
            local v56 = v49 + 0.2
            v55.Size = Vector3.new(v56, 0.7, 0.2)
            v55.CFrame = CFrame.new(v54 * 5 + v50, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 2.356194490192345, 0) * CFrame.new(v49 / 2, 0, 0)
            v55.Parent = v18
            local v57 = script.BlastLine:Clone()
            local v58 = v49 + 0.2
            v57.Size = Vector3.new(v58, 0.7, 0.2)
            v57.CFrame = CFrame.new(v54 * -5 + v50, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 2.356194490192345, 0) * CFrame.new(v49 / 2, 0, 0)
            v57.Parent = v18
        end
        local v59 = script.BlastLine:Clone()
        local v60 = v49 + 0.2
        v59.Size = Vector3.new(v60, 0.7, 0.2)
        v59.CFrame = CFrame.new(v50, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 3.9269908169872414, 0) * CFrame.new(v49 / 2, 0, 0)
        v59.Parent = v18
        local v61 = (v18.Size.Z - 10) / 10
        for v62 = 1, math.floor(v61) do
            local v63 = script.BlastLine:Clone()
            local v64 = v49 + 0.2
            v63.Size = Vector3.new(v64, 0.7, 0.2)
            v63.CFrame = CFrame.new(v62 * 5 + v50, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 3.9269908169872414, 0) * CFrame.new(v49 / 2, 0, 0)
            v63.Parent = v18
            local v65 = script.BlastLine:Clone()
            local v66 = v49 + 0.2
            v65.Size = Vector3.new(v66, 0.7, 0.2)
            v65.CFrame = CFrame.new(v62 * -5 + v50, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 3.9269908169872414, 0) * CFrame.new(v49 / 2, 0, 0)
            v65.Parent = v18
        end
    end
    if p16.Arrows then
        local v67 = script.Line:Clone()
        v67.Size = Vector3.new(8, 0.7, 0.2)
        v67.CFrame = CFrame.new(0, v18.Size.Y / 2 - 0.335, 0)
        v67.Parent = v18
        local v68 = script.Arrow:Clone()
        v68.CFrame = CFrame.new(5.5, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
        v68.Parent = v18
        local v69 = (v18.Size.Z - 20) / 40
        for v70 = 1, math.floor(v69) do
            local v71 = script.Line:Clone()
            v71.Size = Vector3.new(8, 0.7, 0.2)
            v71.CFrame = CFrame.new(v70 * 20, v18.Size.Y / 2 - 0.335, 0)
            v71.Parent = v18
            local v72 = script.Arrow:Clone()
            v72.CFrame = CFrame.new(v70 * 20 + 5.5, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
            v72.Parent = v18
            local v73 = script.Line:Clone()
            v73.Size = Vector3.new(8, 0.7, 0.2)
            v73.CFrame = CFrame.new(v70 * -20, v18.Size.Y / 2 - 0.335, 0)
            v73.Parent = v18
            local v74 = script.Arrow:Clone()
            v74.CFrame = CFrame.new(v70 * -20 + 5.5, v18.Size.Y / 2 - 0.335, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
            v74.Parent = v18
        end
    end
    if p16.Markers then
        for v75 = 1, 3 do
            local v76 = script.Line:Clone()
            v76.Size = Vector3.new(15, 0.7, 0.6)
            v76.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 59, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v75 * 0.9)
            v76.Parent = v18
            local v77 = script.Line:Clone()
            v77.Size = Vector3.new(15, 0.7, 0.6)
            v77.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 59, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v75 * 0.9)
            v77.Parent = v18
            local v78 = script.Line:Clone()
            v78.Size = Vector3.new(15, 0.7, 0.6)
            v78.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 59, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v75 * 0.9)
            v78.Parent = v18
            local v79 = script.Line:Clone()
            v79.Size = Vector3.new(15, 0.7, 0.6)
            v79.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 59, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v75 * 0.9)
            v79.Parent = v18
        end
        if v18.Size.Z > 300 then
            local v80 = script.Line:Clone()
            v80.Size = Vector3.new(15, 0.7, 2.8)
            v80.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 109, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - 2)
            v80.Parent = v18
            local v81 = script.Line:Clone()
            v81.Size = Vector3.new(15, 0.7, 2.8)
            v81.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 109, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + 2)
            v81.Parent = v18
            local v82 = script.Line:Clone()
            v82.Size = Vector3.new(15, 0.7, 2.8)
            v82.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 109, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - 2)
            v82.Parent = v18
            local v83 = script.Line:Clone()
            v83.Size = Vector3.new(15, 0.7, 2.8)
            v83.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 109, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + 2)
            v83.Parent = v18
        end
        if v18.Size.Z > 400 then
            for v84 = 1, 2 do
                local v85 = script.Line:Clone()
                v85.Size = Vector3.new(15, 0.7, 0.6)
                v85.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 159, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v84 * 0.9)
                v85.Parent = v18
                local v86 = script.Line:Clone()
                v86.Size = Vector3.new(15, 0.7, 0.6)
                v86.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 159, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v84 * 0.9)
                v86.Parent = v18
                local v87 = script.Line:Clone()
                v87.Size = Vector3.new(15, 0.7, 0.6)
                v87.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 159, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v84 * 0.9)
                v87.Parent = v18
                local v88 = script.Line:Clone()
                v88.Size = Vector3.new(15, 0.7, 0.6)
                v88.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 159, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v84 * 0.9)
                v88.Parent = v18
            end
        end
        if v18.Size.Z > 500 then
            for v89 = 1, 2 do
                local v90 = script.Line:Clone()
                v90.Size = Vector3.new(15, 0.7, 0.6)
                v90.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 209, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v89 * 0.9)
                v90.Parent = v18
                local v91 = script.Line:Clone()
                v91.Size = Vector3.new(15, 0.7, 0.6)
                v91.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 209, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v89 * 0.9)
                v91.Parent = v18
                local v92 = script.Line:Clone()
                v92.Size = Vector3.new(15, 0.7, 0.6)
                v92.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 209, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v89 * 0.9)
                v92.Parent = v18
                local v93 = script.Line:Clone()
                v93.Size = Vector3.new(15, 0.7, 0.6)
                v93.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 209, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v89 * 0.9)
                v93.Parent = v18
            end
        end
        if v18.Size.Z > 600 then
            for v94 = 1, 1 do
                local v95 = script.Line:Clone()
                v95.Size = Vector3.new(15, 0.7, 0.6)
                v95.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 259, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v94 * 0.9)
                v95.Parent = v18
                local v96 = script.Line:Clone()
                v96.Size = Vector3.new(15, 0.7, 0.6)
                v96.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 259, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v94 * 0.9)
                v96.Parent = v18
                local v97 = script.Line:Clone()
                v97.Size = Vector3.new(15, 0.7, 0.6)
                v97.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 259, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v94 * 0.9)
                v97.Parent = v18
                local v98 = script.Line:Clone()
                v98.Size = Vector3.new(15, 0.7, 0.6)
                v98.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 259, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v94 * 0.9)
                v98.Parent = v18
            end
        end
        if v18.Size.Z > 700 then
            for v99 = 1, 1 do
                local v100 = script.Line:Clone()
                v100.Size = Vector3.new(15, 0.7, 0.6)
                v100.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 309, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v99 * 0.9)
                v100.Parent = v18
                local v101 = script.Line:Clone()
                v101.Size = Vector3.new(15, 0.7, 0.6)
                v101.CFrame = CFrame.new(-1 * (v18.Size.Z / 2) + 309, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v99 * 0.9)
                v101.Parent = v18
                local v102 = script.Line:Clone()
                v102.Size = Vector3.new(15, 0.7, 0.6)
                v102.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 309, v18.Size.Y / 2 - 0.335, v18.Size.X / 2 - v99 * 0.9)
                v102.Parent = v18
                local v103 = script.Line:Clone()
                v103.Size = Vector3.new(15, 0.7, 0.6)
                v103.CFrame = CFrame.new(1 * (v18.Size.Z / 2) - 309, v18.Size.Y / 2 - 0.335, -(v18.Size.X / 2) + v99 * 0.9)
                v103.Parent = v18
            end
        end
    end
    local v104 = v18:GetChildren()
    for v105 = 1, #v104 do
        if v104[v105]:IsA("BasePart") then
            local v106 = Instance.new("Weld")
            v106.Name = "Weld"
            v106.Part0 = v104[v105]
            v106.Part1 = v18
            v106.C0 = v104[v105].CFrame:inverse()
            v106.C1 = v18.CFrame:inverse()
            v106.Parent = v18
        end
    end
    p15:SetPrimaryPartCFrame(v19)
end
return v1