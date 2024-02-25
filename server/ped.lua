---@param source integer
---@param fishName string
---@param amount integer
lib.callback.register('lunar_fishing:sellFish', function(source, fishName, amount)
    local item = Config.fish[fishName]
    local price = type(item.price) == 'number' and item.price or math.random(item.price.min, item.price.max)

    ---@cast price number

    if not item or amount <= 0 then return end

    local player = Framework.getPlayerFromId(source)
    
    if not player then return end
    
    if player:getItemCount(fishName) >= amount then
        SetTimeout(3000, function()
            if player:getItemCount(fishName) < amount then return end

            player:removeItem(fishName, amount)
            player:addAccountMoney(Config.ped.sellAccount, price * amount)
        end)

        return true
    end

    return false
end)

---@param source integer
---@param amount integer
lib.callback.register('lunar_fishing:buy', function(source, data, amount)
    local type, index in data

    if type ~= 'fishingRods' and type ~= 'baits' then return end

    local item = Config[type][index]
    local price = item.price * amount

    if not item or amount <= 0 then return end

    local player = Framework.getPlayerFromId(source)

    if not player
    or GetPlayerLevel(player) < item.minLevel then return end

    if player:getAccountMoney(Config.ped.buyAccount) >= price then
        SetTimeout(3000, function()
            if player:getAccountMoney(Config.ped.buyAccount) < price then return end

            player:removeAccountMoney(Config.ped.buyAccount, price)
            player:addItem(item.name, amount)
        end)
        
        return true
    end

    return false
end)