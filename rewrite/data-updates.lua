local mods = script.active_mods
local util = require("utils")
local resourceTiers = require("resource-tiers")
local techRequirements = require("technology-requirements")

local beltTiers = { -- List of tiers that are present for one or more given mods. beltTiers[mod][tier] will be nil if the belt tier doesn't exist.
    boblogistics = {
        basic = data.raw["transport-belt"]["basic-transport-belt"] and true, -- true if the belt exists, nil if not 
        regular = true, -- basegame belts
        fast = true,
        express = true,
        turbo = data.raw["transport-belt"]["turbo-transport-belt"] and true,
        ultimate = data.raw["transport-belt"]["ultimate-transport-belt"] and true
    }
}
local tierColors = {
    boblogistics = { -- defaults from AAILoaders and Bob's Logistics
        basic = util.color("7d7d7d"),
        regular = {255, 217, 85},
        fast = {255, 24, 38},
        express = {90, 190, 255},
        turbo = util.color("a510e5"),
        ultimate = util.color("16f263")
    }
}

if mods["reskins-library"] and not (reskins.bobs and (reskins.bobs.triggers.logistics.entities == false)) then
    tierColors.boblogistics.basic = reskins.lib.belt_tint_index[0]
    tierColors.boblogistics.regular = reskins.lib.belt_tint_index[1]
    tierColors.boblogistics.fast = reskins.lib.belt_tint_index[2]
    tierColors.boblogistics.express = reskins.lib.belt_tint_index[3]
    tierColors.boblogistics.turbo = reskins.lib.belt_tint_index[4]
    tierColors.boblogistics.ultimate = reskins.lib.belt_tint_index[5]
end

local migrations = { -- this is a list of scripts to run in the migrations folder. Should be true whenever the associated mod is present, and nil otherwise. 
    ["aai-loaders"] = true -- dependency, always true
}

local earlyLube = false -- probably going to stay false, but just in case...
for _, effect in pairs(data.raw.technology["oil-processing"].effects) do
    if effect.recipe == "lubricant-from-crude-oil" then
        earlyLube = true
    end
end

for mod, _ in pairs(mods) do -- don't care what version atm
    for tier, _ in pairs(beltTiers[mod]) do -- if it doesn't exist, it won't be found by pairs bc it'd be an element set to nil (and thus deleted)
        
    end
end
