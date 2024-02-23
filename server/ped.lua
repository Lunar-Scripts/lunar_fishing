---@param source integer
---@param itemIndex integer
---@param amount integer
lib.callback.register('lunar_cryptomining:sellFish', function(source, itemIndex, amount)
    local item = Config.fish[itemIndex]
    local price = type(item.price) == 'number' and item.price or math.random(item.price.min, item.price.max)

    ---@cast price number

    if not item then return end

    local player = Framework.getPlayerFromId(source)
    
    if not player then return end
    
    if player:getItemCount(item.name) >= amount then
        SetTimeout(3000, function()
            if player:getItemCount(item.name) < amount then return end

            player:removeItem(item.name, amount)
            player:addAccountMoney(Config.ped.sellAccount, price * amount)
        end)

        return true
    end

    return false
end)

---@param source integer
---@param amount integer
lib.callback.register('lunar_fishing:buyRod', function(source, amount)
    local item = Config.fishingRods[itemIndex]
    local price = item.price * amount

    if not item then return end

    local player = Framework.getPlayerFromId(source)
    
    if not player then return end
    
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