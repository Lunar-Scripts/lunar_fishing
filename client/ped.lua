local function sell(fishName)
    local fish = Config.fish[fishName]
    local heading = type(fish.price) == 'number' 
                    and locale('sell_fish_heading', Utils.getItemLabel(fishName), fish.price)
                    or locale('sell_fish_heading2', Utils.getItemLabel(fishName), fish.price.min, fish.price.max)
    local amount = lib.inputDialog(heading, {
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

    local success = lib.callback.await('lunar_fishing:sellFish', false, fishName, amount)

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

local function sellFish()
    local options = {}

    for fishName, fish in pairs(Config.fish) do
        if Framework.hasItem(fishName) then
            table.insert(options, {
                title = Utils.getItemLabel(fishName),
                ---@diagnostic disable-next-line: unused-function, param-type-mismatch
                description = type(fish.price) == 'number' and locale('fish_price', fish.price)
                            or locale('fish_price2', fish.price.min, fish.price.max),
                image = GetInventoryIcon(fishName),
                onSelect = sell,
                price = type(fish.price) == 'number' and fish.price or fish.price.min,
                args = fishName
            })
        end
    end

    if #options == 0 then
        ShowNotification(locale('nothing_to_sell'), 'error')
        return
    end

    table.sort(options, function(a, b)
        return a.price < b.price
    end)

    lib.registerContext({
        id = 'sell_fish',
        title = locale('sell_fish'),
        menu = 'fisherman',
        options = options
    })

    Wait(60)

    lib.showContext('sell_fish')
end

---@param data { type: string, index: integer }
local function buy(data)
    local type, index in data
    local item = Config[type][index]
    local amount = lib.inputDialog(locale('buy_heading', Utils.getItemLabel(item.name), item.price), {
        {
            type = 'number',
            label = locale('amount'),
            min = 1,
            required = true
        }
    })?[1] --[[@as number?]]

    if not amount then
        lib.showContext(type == 'fishingRods' and 'buy_rods' or 'buy_baits')
        return
    end

    local success = lib.callback.await('lunar_fishing:buy', false, data, amount)

    if success then
        ShowProgressBar(locale('buying'), 3000, false, {
            dict = 'misscarsteal4@actor',
            clip = 'actor_berating_loop'
        })
        ShowNotification(locale('bought_item'), 'success')
    else
        ShowNotification(locale('not_enough_' .. Config.ped.buyAccount), 'error')
    end
end

local function buyRods()
    local options = {}

    for index, rod in ipairs(Config.fishingRods) do
        table.insert(options, {
            title = Utils.getItemLabel(rod.name),
            description = locale('rod_price', rod.price),
            image = GetInventoryIcon(rod.name),
            disabled = rod.minLevel > GetCurrentLevel(),
            onSelect = buy,
            args = { type = 'fishingRods', index = index }
        })
    end

    lib.registerContext({
        id = 'buy_rods',
        title = locale('buy_rods'),
        menu = 'fisherman',
        options = options
    })

    Wait(60)

    lib.showContext('buy_rods')
end

local function buyBaits()
    local options = {}

    for index, bait in ipairs(Config.baits) do
        table.insert(options, {
            title = Utils.getItemLabel(bait.name),
            description = locale('bait_price', bait.price),
            image = GetInventoryIcon(bait.name),
            disabled = bait.minLevel > GetCurrentLevel(),
            onSelect = buy,
            args = { type = 'baits', index = index }
        })
    end

    lib.registerContext({
        id = 'buy_baits',
        title = locale('buy_baits'),
        menu = 'fisherman',
        options = options
    })

    Wait(60)

    lib.showContext('buy_baits')
end

local function open()
    local level, progress = GetCurrentLevel(), GetCurrentLevelProgress() * 100

    lib.registerContext({
        id = 'fisherman',
        title = locale('fisherman'),
        options = {
            {
                title = locale('level', level),
                description = locale('level_desc', math.floor(100 - progress)),
                icon = 'chart-simple',
                progress = math.max(progress, 0.01),
                colorScheme = 'lime'
            },
            {
                title = locale('buy_rods'),
                description = locale('buy_rods_desc'),
                icon = 'dollar-sign',
                arrow = true,
                onSelect = buyRods
            },
            {
                title = locale('buy_baits'),
                description = locale('buy_baits_desc'),
                icon = 'worm',
                arrow = true,
                onSelect = buyBaits
            },
            {
                title = locale('sell_fish'),
                description = locale('sell_fish_desc'),
                icon = 'fish',
                arrow = true,
                onSelect = sellFish
            }
        }
    })

    lib.showContext('fisherman')
end

for _, coords in ipairs(Config.ped.locations) do
    Utils.createPed(coords, Config.ped.model, {
        {
            label = locale('open_fisherman'),
            icon = 'comment',
            onSelect = open
        }
    })
    Utils.createBlip(coords, Config.ped.blip)
end