local shown = false

lib.onCache('vehicle', function(vehicle)
    if not vehicle then
        if shown then
            HideUI()
            shown = false
        end

        return
    end

    if IsPedInAnyBoat(cache.ped) then
        ShowUI(IsBoatAnchoredAndFrozen(vehicle) and locale('raise_anchor') or locale('anchor_boat'), 'anchor')
        shown = true
    end
end)

lib.addKeybind({
    name = 'anchor_toggle',
    description = 'Toggles the anchor on your boat.',
    defaultKey = 'G',
    defaultMapper = 'keyboard',
    onReleased = function()
        if not IsPedInAnyBoat(cache.ped)
        or #GetEntityVelocity(cache.vehicle) > 3.0 then return end

        if IsBoatAnchoredAndFrozen(cache.vehicle) then
            SetBoatAnchor(cache.vehicle, false)
            ShowUI(locale('anchor_boat'), 'anchor')
        else
            SetBoatFrozenWhenAnchored(cache.vehicle, true)
            SetBoatAnchor(cache.vehicle, true)
            ShowUI(locale('raise_anchor'), 'anchor')
        end
    end
})