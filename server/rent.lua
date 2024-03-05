local pending = {}
local spawned = {}

lib.callback.register('lunar_fishing:rentVehicle', function(source, index)
    local player = Framework.getPlayerFromId(source)

    if not player then return end

    local boat = Config.renting.boats[index]

    if player:getAccountMoney(Config.renting.account) > boat.price then
        player:removeAccountMoney(Config.renting.account, boat.price)
        pending[source] = true
        return true
    end

    return false
end)

RegisterNetEvent('lunar_fishing:registerBoat', function(netId)
    local source = source

    if pending[source] then
        spawned[netId] = true
        pending[source] = nil
    end
end)

local function getBoatPrice(vehicle)
    for _, boat in ipairs(Config.renting.boats) do
        if boat.model == GetEntityModel(vehicle) then
            return boat.price
        end
    end
end

lib.callback.register('lunar_fishing:returnVehicle', function(source, netId)
    local player = Framework.getPlayerFromId(source)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local price = getBoatPrice(vehicle) / Config.renting.returnDivider

    if not player
    or not price
    or not spawned[netId]
    or GetPedInVehicleSeat(vehicle, -1) ~= GetPlayerPed(source) then
        return
    end

    player:addAccountMoney(Config.renting.account, price)
    spawned[netId] = nil

    SetTimeout(1500, function()
        DeleteEntity(vehicle)
    end)

    return true
end)