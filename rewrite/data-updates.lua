local mods = script.active_mods

local beltTiers = { -- List of tiers that are present for one or more given mods. beltTiers[mod][tier] will be nil if the belt tier doesn't exist.
    boblogistics = {
        basic = data.raw["transport-belt"]["basic-transport-belt"] and true, -- lua logical operators are funny. These expressions are true if the belt in question exists, and nil if not.
        turbo = data.raw["transport-belt"]["turbo-transport-belt"] and true,
        ultimate = data.raw["transport-belt"]["ultimate-transport-belt"] and true
    }
}

local resourceTiers = {
    circuit = {},
    gear = {},
    inserter = {},
    intermediate = {},
    plate = {}
}

-- Circuits
do
    local circuit = resourceTiers.circuit
    -- base
    circuit.basic = {{"copper-cable", .8}, {"wood", .8}} -- all these values will get rounded when they are used
    circuit.regular = {{"electronic-circuit", 1}}
    circuit.fast = {{"electronic-circuit", 1}}
    circuit.express = {{"advanced-circuit", 1}}
    circuit.turbo = {{"processing-unit", 1}}
    circuit.ultimate = {{"processing-unit", 1}}

    if mods["bobelectronics"] then
        circuit.ultimate = {{"advanced-processing-unit", 1}}
    end
    if mods["CircuitProcessing"] then
        circuit.regular = {{"basic-circuit-board", 1}}
    end
    if mods["SeaBlock"] then
        circuit.basic = {{"copper-cable", .8}}
    end
end

-- Gears
do
    local gear = resourceTiers.gear
    -- base
    gear.basic = {{"iron-gear-wheel", 1}}
    gear.regular = table.deepcopy(gear.basic)
    gear.fast = table.deepcopy(gear.basic)
    gear.express = table.deepcopy(gear.basic)
    gear.turbo = table.deepcopy(gear.basic)
    gear.ultimate = table.deepcopy(gear.basic)
    

end

-- Inserters
do
    local inserter = resourceTiers.inserter
    -- base
    if settings.startup["bobmods-logistics-inserteroverhaul"].value then -- tiered inserters!
        inserter.basic = {{"iron-gear-wheel", 1}, {"iron-plate", 1}} -- don't force people to make burner inserters like an evil person
        inserter.regular = {{"inserter", 1}}
        inserter.fast = {{"red-stack-inserter", .5}} -- all these values will get rounded when they are used
        inserter.express = {{"stack-inserter", .5}}
        inserter.turbo = {{"turbo-stack-inserter", .5}}
        inserter.ultimate = {{"express-stack-inserter", .5}} -- why the hell does bobslogistics name their ultimate stack inserter like this
    else -- booooooring. ./s
        
    end
end

-- Intermediates
do
    local intermediate = resourceTiers.intermediate
    -- base
    intermediate.basic = {{"iron-gear-wheel", 1}}
    
end

AAILoadersBobs = {}
AAILoadersBobs.resourceTiers = resourceTiers

-- TODO: Write out resource tier detection

for mod, _ in pairs(mods) do -- don't care what version atm
    for tier, _ in pairs(beltTiers[mod]) do -- if it doesn't exist, it won't be found by pairs bc it'd be an element set to nil (and thus deleted)
        require("aai-loaders-bobs-rewrite.prototypes." .. mod .. "." .. tier) -- create the thing!
    end
end
