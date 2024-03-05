local function getVehicleLabel(model)
    local label = GetLabelText(GetDisplayNameFromVehicleModel(model))

    if label == 'NULL' then
        label = GetDisplayNameFromVehicleModel(model)
    end

    return label
end

---@param boat { model: string | number, price: integer }
local function spawnBoat(boat)
    local closest, dist = nil, math.huge

    for _, location in ipairs(Config.renting.locations) do
        local distance = #(location.coords.xyz - GetEntityCoords(cache.ped))

        if distance < dist then
            closest = location
            dist = distance
        end
    end

    if closest then
        local coords = vector3(closest.spawn.x, closest.spawn.y, closest.spawn.z - 1.0)

        Framework.spawnVehicle(boat.model, coords, closest.spawn.w, function(vehicle)
            SetVehicleOwner(GetVehicleNumberPlateText(vehicle))
            TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
            SetVehicleFuel(vehicle, 100.0)
            TriggerServerEvent('lunar_fishing:registerBoat', NetworkGetNetworkIdFromEntity(vehicle))
        end)
    end
end

local function rentVehicle(index)
    local boat = Config.renting.boats[index]
    local confirmed = lib.alertDialog({
        header = locale('rent_heading'),
        content = locale('rent_content', boat.price),
        centered = true,
        cancel = true
    }) == 'confirm'

    if not confirmed then return end

    local success = lib.callback.await('lunar_fishing:rentVehicle', false, index)

    if success then
        spawnBoat(boat)
    else
        ShowNotification(locale('not_enough_' .. Config.renting.account), 'error')
    end
end

do
    local options = {}

    for index, boat in ipairs(Config.renting.boats) do
        table.insert(options, {
            title = getVehicleLabel(boat.model),
            description = locale('rent_price', boat.price),
            image = boat.image,
            onSelect = rentVehicle,
            args = index
        })
    end

    lib.registerContext({
        id = 'rent_boat',
        title = locale('rent_boat'),
        options = options
    })
end

---@CPoint?
local point
local shown = false

local function getBoatPrice(vehicle)
    for _, boat in ipairs(Config.renting.boats) do
        if boat.model == GetEntityModel(vehicle) then
            return boat.price
        end
    end
end

local bind = lib.addKeybind({
    name = 'fishing_interaction',
    description = 'The main interaction keybind.',
    defaultKey = 'E',
    defaultMapper = 'keyboard',
    onReleased = function()
        if not point then return end

        local price = getBoatPrice(cache.vehicle)

        if not price then return end

        local confirmed = lib.alertDialog({
            header = locale('return_boat'),
            content = locale('return_content', math.floor(price / Config.renting.returnDivider)),
            cancel = true,
            centered = true
        }) == 'confirm'

        if not confirmed then return end

        local netId = NetworkGetNetworkIdFromEntity(cache.vehicle)
        local success = lib.callback.await('lunar_fishing:returnVehicle', false, netId)

        if success then
            TaskLeaveAnyVehicle(cache.ped)
            ShowNotification(locale('returned_boat'), 'success')
        end
    end
})

---@parama coords vector4
local function createSaveZone(coords)
    lib.points.new({
        coords = coords,
        distance = Config.renting.returnRadius or 10.0,
        onEnter = function(self)
            point = self

            if not getBoatPrice(cache.vehicle) then return end

            ShowUI(locale('return_boat', bind:getCurrentKey()), 'rotate-left')
            shown = true
        end,
        onExit = function(self)
            if point ~= self then return end

            point = nil

            if not shown then return end

            HideUI()
            shown = false
        end
    })
end


for _, location in ipairs(Config.renting.locations) do
    Utils.createPed(location.coords, Config.renting.model, {
        {
            label = locale('rent_boat'),
            icon = 'ship',
            onSelect = function()
                lib.showContext('rent_boat')
            end
        }
    })
    Utils.createBlip(location.coords, Config.renting.blip)
    createSaveZone(location.spawn)
end