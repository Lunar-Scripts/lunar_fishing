local function openSell()

end

do
    local function buy(index)
        local success = lib.callback.await('lunar_fishing:buyRod', false, index)

        if success then
            ShowProgressBar(locale('buying'), 3000, false, {
                dict = 'misscarsteal4@actor',
                clip = 'actor_berating_loop'
            })
            ShowNotification(locale('bought_rod'), 'success')
        else
            ShowNotification(locale('not_enough_money'), 'error')
        end
    end

    local options = {}

    for index, rod in ipairs(Config.fishingRods) do
        table.insert(options, {
            title = Utils.getItemLabel(rod.name),
            description = locale('rod_price', rod.price),
            onSelect = buy,
            args = index
        })
    end

    lib.registerContext({
        id = 'buy_rods',
        title = locale('buy_rods'),
        menu = 'fisherman',
        options = options
    })
end

lib.registerContext({
    id = 'fisherman',
    title = locale('fisherman'),
    options = {
        {
            title = locale('level', GetCurrentLevel()),
            description = locale('level_desc'),
            progress = GetCurrentLevelProgress(),
            colorScheme = 'lime'
        },
        {
            title = locale('buy_rods'),
            description = locale('buy_rods_desc'),
            menu = 'buy_rods'
        },
        {
            title = locale('sell_fish'),
            description = locale('sell_fish_desc'),
            onSelect = openSell
        }
    }
})

for _, coords in ipairs(Config.ped.locations) do
    Utils.createPed(coords, Config.ped.model, {
        {
            label = locale('open_fisherman'),
            icon = 'fish',
            onSelect = function()
                lib.showContext('fisherman')
            end
        }
    })
end