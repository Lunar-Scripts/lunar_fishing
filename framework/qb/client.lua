if GetResourceState('qb-core') ~= 'started' then return end

Framework = { name = 'qb-core' }
local sharedObject = exports['qb-core']:GetCoreObject()

function Framework.isPlayerLoaded()
    return next(sharedObject.Functions.GetPlayerData()) ~= nil
end

---@diagnostic disable-next-line: duplicate-set-field
function Framework.getJob()
    if not Framework.isPlayerLoaded() then
        return false
    end

    return sharedObject.Functions.GetPlayerData().job.name
end

Framework.hasItem = sharedObject.Functions.HasItem

function Framework.spawnVehicle(model, coords, heading, cb)
    sharedObject.Functions.SpawnVehicle(model, cb, vector4(coords.x, coords.y, coords.z, heading), true)
end

function Framework.spawnLocalVehicle(model, coords, heading, cb)
    sharedObject.Functions.SpawnVehicle(model, cb, vector4(coords.x, coords.y, coords.z, heading), false)
end

Framework.deleteVehicle = sharedObject.Functions.DeleteVehicle

Framework.getPlayersInArea = sharedObject.Functions.GetPlayersFromCoords