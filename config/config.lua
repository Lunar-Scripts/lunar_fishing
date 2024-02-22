Config = {}

---@type false | string | string[]
Config.requiredJob = false

---@class Fish 
---@field name string
---@field price integer | { min: integer, max: integer }
---@field chance integer Percentage chance
---@field skillcheck SkillCheckDifficulity }

---@type Fish[]
Config.fish = {
    { name = 'trout', price = { min = 20, max = 50 }, chance = 20, skillcheck = { 'easy', 'medium' } },
}

---@class FishingRod
---@field name string
---@field price integer
---@field level integer The minimal level
---@field chanceMultiplier number
---@field breakChance integer Percentage chance

---@type FishingRod[]
Config.fishingRods = {
    { name = 'normal_rod', price = 1000, level = 1, chanceMultiplier = 1.0, breakChance = 5 }
}

---@class FishingZone
---@field coords vector3
---@field radius number
---@field minLevel integer
---@field includeOutside boolean Whether you can also catch fish from Config.outside
---@field blip BlipData?
---@field fish string[]

---@type FishingZone[]
Config.fishingZones = {
    {
        coords = vector3(0.0, 0.0, 0.0),
        radius = 3.0,
        minLevel = 1,
        includeOutside = true,
        fish = {}
    }
}

-- Outside of all zones
Config.outside = {
    chance = 25, -- The chance to catch a fish

    ---@type string[]
    items = {
        'trout', 'anchovy'
    }
}


Config.ped = {
    model = `s_m_m_cntrybar_01`,

    ---@type vector4[]
    locations = {

    }
}