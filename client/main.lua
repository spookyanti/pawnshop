local options = {}
local options2 = {}
lib.locale()

exports.ox_target:addBoxZone({
    coords = Config.Target.pos,
    size = Config.Target.size,
    rotation = Config.Target.heading,
    debug = Config.Target.debug,
    options = {
        {
            name = 'spy_jobcenter',
            event = 'spy_pawnshop:menu1',
            icon = Config.Target.icon,
            label = locale("target_label"),
        }
    }
})


Citizen.CreateThread(function()
    for i,v in pairs(Config.MenuSellItems) do
        table.insert(options, {
            title = v.label,
            icon = v.icon,
            args = {
                item = i,
                price = v.price
            },
            description = tostring(v.price.." $"),
            serverEvent = "spy_pawnshop:sell",
        }) 
    end
    lib.registerContext({
        id = 'kar',
        title = locale("sellmenu_title"),
        options = options
    })
    for k,z in pairs(Config.MenuBuyItems) do
        table.insert(options2, {
            title = z.label,
            icon = z.icon,
            args = {
                item = k,
                price = z.price,
                source = cache.ped
            },
            description = tostring(z.price.." $"),
            serverEvent = "spy_pawnshop:buy",
        }) 
    end
    lib.registerContext({
        id = 'buymenu',
        title = locale("buymenu_title"),
        options = options2
    })
end)

RegisterNetEvent("spy_pawnshop:menu1")
AddEventHandler("spy_pawnshop:menu1", function()
    local coords = Config.Target.pos
    local pcoords = GetEntityCoords(cache.ped)

    if #(pcoords - coords) <= 3 then
        lib.showContext("wbmenu")
    else
        print("Tried to open menu")
    end
end)

lib.registerContext({
    id = 'wbmenu',
    title = locale("menu1_title"),
    options = {
      {
        title = locale("menu1_option1"),
        description = locale("menu1_option1_desc"),
        icon = Config.MenuIcons.buy,
        onSelect = function()
            lib.showContext("buymenu")
        end,
      },
      {
        title = locale("menu1_option2"),
        description = locale("menu1_option2_desc"),
        icon = Config.MenuIcons.sell,
        onSelect = function()
            lib.showContext("kar")
        end,
      },
    }
})