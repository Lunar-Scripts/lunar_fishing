local function sell(index)
    local amount = lib.inputDialog(locale('sell_fish_heading', Utils.getItemLabel(item.name), item.price), {
        {
            type = 'number',
            label = locale('amount'),
            min = 1,
            required = true
        }
    })?[1] --[[@as number?]]

    if not amount then
        lib.showContext('sell_fish')
        return
    end

    local success = lib.callback.await('lunar_fishing:sellFish', false, index, amount)

    if success then
        ShowProgressBar(locale('selling'), 3000, false, {
            dict = 'misscarsteal4@actor',
            clip = 'actor_berating_loop'
        })
        ShowNotification(locale('sold_fish'), 'success')
    else
        ShowNotification(locale('not_enough_fish'), 'error')
    end
end

local function openSell()
    local options = {}

    for index, fish in ipairs(Config.fish) do
        if Framework.hasItem(fish.name) then
            table.insert(options, {
                title = Utils.getItemLabel(fish.name),
                ---@diagnostic disable-next-line: unused-function, param-type-mismatch
                description = type(fish.price) == 'number' and locale('fish_price', fish.price) 
                            or locale('fish_price2', fish.price.min, fish.price.max),
                onSelect = sell,
                args = index
            })
        end
    end

    lib.registerContext({
        id = 'sell_fish',
        title = locale('sell_fish'),
        options = options
    })
end

do
    local function buy(index)
        local item = Config.fishingRods[index]
        local amount = lib.inputDialog(locale('buy_rod_heading', Utils.getItemLabel(item.name), item.price), {
            {
                type = 'number',
                label = locale('amount'),
                min = 1,
                required = true
            }
        })?[1] --[[@as number?]]
    
        if not amount then
            lib.showContext('sell_fish')
            return
        end

        local success = lib.callback.await('lunar_fishing:buyRod', false, index, amount)

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
            progress = math.max(GetCurrentLevelProgress(), 0.1),
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