-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

local u1 = game:GetService("HttpService")
local v2 = require(303863449)
local u3 = require(script.Signal)
local u6 = {
    ["Url"] = "https://pg-app-psd92kry07n2i7r3lzrkb0llcajzey.scalabl.cloud/1",
    ["AppId"] = "wQZjwQ4YyP2XdYP2g9oTMjNYaMSPQdVROlTiMVlr",
    ["AppName"] = "AirX",
    ["MongoDBURI"] = "mongodb://user6033a1:7724b42zyJH-ka71dde@cluster-pgrs1003-0-us-east-1-scalabledbs.cloudstrap.io:29003,cluster-pgrs1003-1-us-east-1-scalabledbs.cloudstrap.io:29003,cluster-pgrs1003-2-us-east-1-scalabledbs.cloudstrap.io:29003/pg-app-2-us-psd92kry07n2i7r3lzrkb0llcajzey?replicaSet=pgrs1003&ssl=true",
    ["ClientKey"] = "C3UaZ54t7eMWW2ihZ8GdgdrSl3i9RaTOr8QWMLYM",
    ["JavascriptKey"] = "sbclESX60qqlI3p9wihuV57STOMlaMrgWYQeRiG5",
    ["NETKey"] = "qkamWKFwGLAvmafFc5RlKIkSBirYRQOlM679MaTR",
    ["RESTKey"] = "sOnNpBAUJPZC0qFj32ko6YNSlMQrbOsTliMYoa8R",
    ["WebhookKey"] = "mTQr77Gr4ZqlZUAaVXaMZiqO7RSYaTi8il9OQMrM",
    ["FileKey"] = "psd92kry07n2i7r3lzrkb0llcajzey",
    ["MasterKey"] = "4irJdhuSPs30tcCqsu2cqNaRYXTriUUgMQOlSMGa",
    ["Queue"] = v2.new(function(p4, p5) --[[ Name: comparator, Line 20 ]]
        return p5 < p4
    end),
    ["TimeOut"] = 10,
    ["BatchLimit"] = 50
}
local u7 = 0
local u8 = false
function u6.MakeNested(_, ...) --[[ Line: 37 ]]
    local v9 = { ... }
    local v10 = {}
    for v11, _ in ipairs(v9) do
        if v11 % 2 == 1 then
            v10[v9[v11]] = v9[v11 + 1]
        end
    end
    return v10
end
function u6.MakeRequest(_, p12, p13, p14) --[[ Line: 50 ]]
    return {
        ["method"] = p12,
        ["path"] = p13,
        ["body"] = p14
    }
end
local function u20(p15) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v16 = ""
    for v17, v18 in pairs(p15) do
        if type(v18) == "table" then
            for v19 = 1, #v18 do
                v16 = v16 .. "&" .. v17 .. "=" .. v18[v19]
            end
        else
            v16 = v16 .. "&" .. v17 .. "=" .. u1:UrlEncode(v18)
        end
    end
    return v16
end
function u6.Get(_, p21) --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    return u1:GetAsync(string.format("%s/%s/%s", u6.Url, "classes", p21), false, {
        ["X-Parse-Application-Id"] = u6.AppId,
        ["X-Parse-REST-API-Key"] = u6.RESTKey
    })
end
function u6.Post(_, p22, p23) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    local v24 = string.format("%s/%s/%s", u6.Url, "classes", p22)
    local v25 = u1:JSONEncode(p23)
    local v26 = {
        ["X-Parse-Application-Id"] = u6.AppId,
        ["X-Parse-REST-API-Key"] = u6.RESTKey
    }
    return u1:PostAsync(v24, v25, Enum.HttpContentType.ApplicationJson, false, v26)
end
function u6.CloudCode(_, p27, p28) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u20
        [3] = u1
    --]]
    local v29 = string.format("%s/%s/%s", u6.Url, "functions", p27)
    local v30 = {
        ["X-Parse-Application-Id"] = u6.AppId,
        ["X-Parse-REST-API-Key"] = u6.RESTKey
    }
    return u1:PostAsync(v29, u20(p28), Enum.HttpContentType.ApplicationUrlEncoded, false, v30)
end
function u6.ListPlan(_, p31) --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    local v32 = {
        ["X-Parse-Application-Id"] = u6.AppId,
        ["X-Parse-Master-Key"] = u6.MasterKey
    }
    return u1:PostAsync("https://pg-app-o5v5wbmd6c4ccsj2yc16kdzyyfyvz7.scalabl.cloud/ListPlan", u1:JSONEncode(p31), Enum.HttpContentType.ApplicationJson, false, v32)
end
function u6.ListItem(_, p33) --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    local v34 = {
        ["X-Parse-Application-Id"] = u6.AppId,
        ["X-Parse-Master-Key"] = u6.MasterKey
    }
    return u1:PostAsync("https://pg-app-o5v5wbmd6c4ccsj2yc16kdzyyfyvz7.scalabl.cloud/ListItemNew", u1:JSONEncode(p33), Enum.HttpContentType.ApplicationJson, false, v34)
end
function u6.BatchPost(_, p35) --[[ Line: 154 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    local v36 = string.format("%s/batch", u6.Url)
    local v37 = u1:JSONEncode({
        ["requests"] = p35
    })
    print("POSTED HTTP:" .. v37)
    local v38 = {
        ["X-Parse-Application-Id"] = u6.AppId,
        ["X-Parse-REST-API-Key"] = u6.RESTKey,
        ["X-Parse-Master-Key"] = u6.MasterKey
    }
    return u1:PostAsync(v36, v37, Enum.HttpContentType.ApplicationJson, false, v38)
end
function u6.EnqueueRequest(_, p39) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
    --]]
    local v40 = u3.Create()
    local v41 = os.time()
    u6.Queue:Add({
        ["request"] = p39,
        ["signal"] = v40,
        ["timestamp"] = v41
    }, v41)
    return v40
end
function u6.ExecuteQueue(_) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    local v42 = {}
    local v43 = {}
    local v44 = {}
    local v45 = u6.Queue:Size()
    if u6.BatchLimit < v45 then
        v45 = u6.BatchLimit
    end
    for _ = 1, v45 do
        local v46 = u6.Queue:Pop()
        local v47 = v46.request
        table.insert(v42, v47)
        local v48 = v46.signal
        table.insert(v44, v48)
        local v49 = v46.timestamp
        table.insert(v43, v49)
    end
    local v50 = u1:JSONDecode((u6:BatchPost(v42)))
    for v51 = 1, #v50 do
        v44[v51]:fire(v50[v51], v43[v51])
    end
    return true
end
game:GetService("RunService").Heartbeat:Connect(function(p52) --[[ Line: 216 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
        [3] = u8
    --]]
    u7 = u7 + p52
    local v53 = u6.Queue:Size()
    if (u6.BatchLimit <= v53 or u7 >= u6.TimeOut) and (not u8 and v53 ~= 0) then
        u7 = 0
        u8 = true
        pcall(u6:ExecuteQueue())
        u8 = false
    end
end)
if not game:GetService("RunService"):IsStudio() then
    function game.OnClose() --[[ Line: 230 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u8
            [3] = u6
        --]]
        u7 = 0
        u8 = true
        pcall(u6:ExecuteQueue())
        u8 = false
    end
end
return u6