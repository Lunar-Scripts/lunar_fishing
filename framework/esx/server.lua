if GetResourceState('es_extended') ~= 'started' then return end

Framework = { name = 'es_extended' }
local sharedObject = exports['es_extended']:getSharedObject()
local player = {}
local saved = {}

---@diagnostic disable-next-line: duplicate-set-field
Framework.getPlayerFromId = function(id)
    if saved[id] then return saved[id] end

    local player = setmetatable({}, { __index = player })
    player.xPlayer = sharedObject.GetPlayerFromId(id)
    if not player.xPlayer then return end
    player.source = id

    saved[id] = player
    return player
end

Framework.registerUsableItem = sharedObject.RegisterUsableItem

Framework.getPlayers = sharedObject.GetExtendedPlayers

local ox_inventory = GetResourceState('ox_inventory') == 'started'
local qs_inventory = GetResourceState('qs-inventory') == 'started'

function Framework.getItemLabel(item)
    if ox_inventory then
        return exports.ox_inventory:Items()[item]?.label
    elseif qs_inventory then
        return exports['qs-inventory']:GetItemList()[item]?.label
    end
    return sharedObject.GetItemLabel(item)
end

function Framework.getItems()
    if ox_inventory then
        return exports.ox_inventory:Items()
    elseif qs_inventory then
        return exports['qs-inventory']:GetItemList()
    end
    return exports['es_extended']:getSharedObject().Items
end

function player:hasGroup(name)
    return self.xPlayer.getGroup() == name
end

function player:hasOneOfGroups(groups)
    return groups[self.xPlayer.getGroup()] or false
end

function player:addItem(name, count)
    self.xPlayer.addInventoryItem(name, count or 1)
end

function player:removeItem(name, count)
    self.xPlayer.removeInventoryItem(name, count or 1)
end

function player:canCarryItem(name, count)
    return self.xPlayer.canCarryItem(name, count)
end

function player:getItemCount(name)
    return self.xPlayer.getInventoryItem(name)?.count or 0
end

function player:getAccountMoney(account)
    return self.xPlayer.getAccount(account)?.money or 0
end

function player:addAccountMoney(account, amount)
    self.xPlayer.addAccountMoney(account, amount)
end

function player:removeAccountMoney(account, amount)
    self.xPlayer.removeAccountMoney(account, amount)
end

function player:getJob()
    return self.xPlayer.getJob().name
end

function player:getIdentifier()
    return self.xPlayer.getIdentifier()
end

function player:getFirstName()
    return self.xPlayer.get('firstName')
end

function player:getLastName()
    return self.xPlayer.get('lastName')
end