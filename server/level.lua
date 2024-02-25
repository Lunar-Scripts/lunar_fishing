---@type table<string, number>
local levels = {}

MySQL.ready(function()
    local data = MySQL.query.await('SELECT * FROM lunar_fishing')

    for _, entry in ipairs(data) do
        levels[entry.user_identifier] = entry.xp
    end
end)

local function save()
    local query = 'UPDATE lunar_fishing SET xp = ? WHERE user_identifier = ?'
    local parameters = {}
    local size = 0

    for identifier, level in pairs(levels) do
        size += 1
        parameters[size] = {
            level,
            identifier
        }
    end

    if size > 0 then
        print('Saving player progress.')
        MySQL.prepare.await(query, parameters)
    end
end

lib.cron.new('*/10 * * * *', save)
AddEventHandler('txAdmin:events:serverShuttingDown', save)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining ~= 60 then return end

	save()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == cache.resource then
		save()
	end
end)


local function createPlayer(identifier)
    levels[identifier] = 1.0
    MySQL.insert.await('INSERT INTO lunar_fishing (user_identifier, xp) VALUES(?, ?)', { identifier, levels[identifier] })
end

lib.callback.register('lunar_fishing:getLevel', function(source)
    local player = Framework.getPlayerFromId(source)

    if not player then return end

    local identifier = player:getIdentifier()

    if not levels[identifier] then
        createPlayer(identifier)
    end

    return levels[identifier]
end)

---@param player Player
---@param amount number
function AddPlayerLevel(player, amount)
    local identifier = player:getIdentifier()
    local level = math.floor(levels[identifier])

    levels[identifier] += amount

    if math.floor(levels[identifier]) - level > 0 then
        TriggerClientEvent('lunar_fishing:showNotification', player.source, locale('unlocked_level'), 'success')
    end

    TriggerClientEvent('lunar_fishing:updateLevel', player.source, levels[identifier])
end

---@param player Player
function GetPlayerLevel(player)
    return levels[player:getIdentifier()]
end