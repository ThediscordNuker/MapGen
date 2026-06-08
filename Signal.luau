-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium.

return {
    ["Create"] = function() --[[ Name: Create, Line 25 ]]
        print("Hi")
        local v1 = {}
        local u2 = Instance.new("BindableEvent")
        u2.Parent = workspace
        local u3 = nil
        local u4 = nil
        function v1.fire(_, ...) --[[ Line: 35 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
                [3] = u2
            --]]
            u3 = { ... }
            u4 = select("#", ...)
            u2:Fire()
        end
        function v1.connect(_, u5) --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
            --]]
            if not u5 then
                error("connect(nil)", 2)
            end
            return u2.Event:connect(function() --[[ Line: 43 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v6 = u3
                local v7 = u4
                u5(unpack(v6, 1, v7))
            end)
        end
        function v1.wait(_) --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
            --]]
            u2.Event:wait()
            local v8 = u3
            assert(v8, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
            local v9 = u3
            local v10 = u4
            return unpack(v9, 1, v10)
        end
        return v1
    end
}