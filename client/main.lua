---@param first { price: integer }
---@param second { price: integer }
local function sortByPrice(first, second)
    return first.price < second.price
end

table.sort(Config.fishingRods, sortByPrice)
table.sort(Config.baits, sortByPrice)

---@type { normal: number, radius: number }[], CZone[]
local blips, zones = {}, {}
---@type { index: integer, locationIndex: integer }?
local currentZone

---@param level number
local function updateBlips(level)
    for _, blip in ipairs(blips) do
        RemoveBlip(blip.normal)
        RemoveBlip(blip.radius)
    end

    table.wipe(blips)

    for _, zone in ipairs(Config.fishingZones) do
        if zone.blip and zone.minLevel <= level then
            for _, coords in ipairs(zone.locations) do
                local blip = Utils.createBlip(coords, {
                    name = zone.blip.name,
                    sprite = zone.blip.sprite,
                    color = 0,
                    scale = zone.blip.scale
                })
                local radiusBlip = Utils.createRadiusBlip(coords, zone.radius, zone.blip.color)
                
                table.insert(blips, { normal = blip, radius = radiusBlip })
            end
        end
    end
end

---@param level number
local function updateZones(level)
    for _, zone in ipairs(zones) do
        zone:remove()
    end

    table.wipe(zones)

    for index, data in ipairs(Config.fishingZones) do
        if data.minLevel <= level then
            for locationIndex, coords in ipairs(data.locations) do
                local zone = lib.zones.sphere({
                    coords = coords,
                    radius = data.radius,
                    onEnter = function()
                        if currentZone?.index == index and currentZone?.locationIndex == index then return end

                        currentZone = { index = index, locationIndex = locationIndex }
    
                        if data.message then
                            ShowNotification(data.message.enter, 'success')
                        end
                    end,
                    onExit = function()
                        if currentZone?.index ~= index
                        or currentZone?.locationIndex ~= locationIndex then return end
    
                        currentZone = nil

                        if data.message then
                            ShowNotification(data.message.exit, 'inform')
                        end
                    end
                })
    
                table.insert(zones, zone)
            end
        end
    end
end

---@param level integer
function Update(level)
    updateBlips(level)
    updateZones(level)
end

local function createRodObject()
    local model = `prop_fishing_rod_01`

    lib.requestModel(model)

    local coords = GetEntityCoords(cache.ped)
    local object = CreateObject(model, coords.x, coords.y, coords.z, true, true, false)
    local boneIndex = GetPedBoneIndex(cache.ped, 18905)

    AttachEntityToEntity(object, cache.ped, boneIndex, 0.1, 0.05, 0.0, 70.0, 120.0, 160.0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(model)

    return object
end

local function hasWaterInFront()
    if IsPedSwimming(cache.ped) or IsPedInAnyVehicle(cache.ped, true) then
        return false
    end
    
    local headCoords = GetPedBoneCoords(cache.ped, 31086, 0.0, 0.0, 0.0)
    local coords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 45.0, -27.5)
    local hasWater = TestProbeAgainstWater(headCoords.x, headCoords.y, headCoords.z, coords.x, coords.y, coords.z)

    if not hasWater then
        ShowNotification(locale('no_water'), 'error')
    end

    return hasWater
end

lib.callback.register('lunar_fishing:getCurrentZone', function()
    return hasWaterInFront(), currentZone
end)

local function setCanRagdoll(state)
    SetPedCanRagdoll(cache.ped, state)
    SetPedCanRagdollFromPlayerImpact(cache.ped, state)
    SetPedRagdollOnCollision(cache.ped,statefalse)
end

---@param bait FishingBait
---@param fish Fish
lib.callback.register('lunar_fishing:itemUsed', function(bait, fish)
    local zone = Config.fishingZones[currentZone] or Config.outside

    local object = createRodObject()
    lib.requestAnimDict('mini@tennis')
    lib.requestAnimDict('amb@world_human_stand_fishing@idle_a')
    setCanRagdoll(false)
    ShowUI(locale('cancel'), 'ban')

    local p = promise.new()

    local interval = SetInterval(function()
        if IsControlPressed(0, 38)
        or (not IsEntityPlayingAnim(cache.ped, 'mini@tennis', 'forehand_ts_md_far', 3)
        and not IsEntityPlayingAnim(cache.ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 3)) then
            HideUI()
            p:resolve(false)
        end
    end, 100) --[[@as number?]]

    local function wait(milliseconds)
        Wait(milliseconds)

        return p.state == 0
    end

    CreateThread(function()
        TaskPlayAnim(cache.ped, 'mini@tennis', 'forehand_ts_md_far', 3.0, 3.0, 1.0, 16, 0, false, false, false)

        if not wait(1500) then return end

        TaskPlayAnim(cache.ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 3.0, 3.0, -1, 11, 0, false, false, false)

        if not wait(math.random(zone.waitTime.min, zone.waitTime.max) / bait.waitDivisor * 1000) then return end

        ShowNotification(locale('felt_bite'), 'warn')
        HideUI()

        if interval then
            ClearInterval(interval)
            interval = nil
        end

        if not wait(math.random(2000, 4000)) then return end

        local success = lib.skillCheck(fish.skillcheck, { 'e' })

        if not success then
            ShowNotification(locale('catch_failed'), 'error')
        end

        p:resolve(success)
    end)

    local success = Citizen.Await(p)

    if interval then
        ClearInterval(interval)
        interval = nil
    end

    DeleteEntity(object)
    ClearPedTasks(cache.ped)
    setCanRagdoll(true)

    return success
end)