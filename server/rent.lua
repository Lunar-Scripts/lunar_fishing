lib.callback.register('lunar_fishing:rentVehicle', function(source, index)
    local player = Framework.getPlayerFromId(source)

    if not player then return end

    local boat = Config.renting.boats[index]

    if player:getAccountMoney(Config.renting.account) > boat.price then
        player:removeAccountMoney(Config.renting.account, boat.price)
        return true
    end

    return false
end)