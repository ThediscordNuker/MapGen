-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local v1 = {}
tileSize = 512
initialResolution = 40075016.68557849 / tileSize
originShift = 20037508.342789244
function Resolution(p2)
    return initialResolution / math.pow(2, p2)
end
function v1.ConvertLatLongToTile(_, p3, p4, p5) --[[ Line: 19 ]]
    local v6 = p4 * originShift / 180
    local v7 = (90 + p3) * 3.141592653589793 / 360
    local v8 = math.tan(v7)
    local v9 = math.log(v8) / 0.017453292519943295 * originShift / 180
    local v10 = Resolution(p5)
    local v11 = (v6 + originShift) / v10 - v10 / 2
    local v12 = (v9 + originShift) / v10 - v10 / 2
    local v13 = v11 / tileSize
    local v14 = math.ceil(v13) - 1
    local v15 = v12 / tileSize
    return v14, math.ceil(v15) - 1
end
function v1.ConvertLatLongToPixA(_, p16, p17, p18) --[[ Line: 36 ]]
    local v19 = p17 * originShift / 180
    local v20 = (90 + p16) * 3.141592653589793 / 360
    local v21 = math.tan(v20)
    local v22 = math.log(v21) / 0.017453292519943295 * originShift / 180
    local v23 = Resolution(p18)
    return (v19 + originShift) / v23 - v23 / 2, (v22 + originShift) / v23 - v23 / 2
end
function v1.ConvertLatLongToPix(_, p24, p25, p26) --[[ Line: 49 ]]
    local v27 = p25 * originShift / 180
    local v28 = (90 + p24) * 3.141592653589793 / 360
    local v29 = math.tan(v28)
    local v30 = math.log(v29) / 0.017453292519943295 * originShift / 180
    local v31 = Resolution(p26)
    local v32 = (v27 + originShift) / v31 - v31 / 2
    local v33 = (v30 + originShift) / v31 - v31 / 2
    local v34 = 65536 / math.pow(2, p26)
    return v32 * v34, v33 * v34
end
return v1