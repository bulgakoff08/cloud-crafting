local function extractFromInventory (inventory, itemId, intention, leaveOne)
    if leaveOne then
        local available = inventory.get_item_count(itemId) - 1
        if available == 0 then
            return 0
        end
        if available < intention then
            return inventory.remove({type = "item", name = itemId, count = available})
        end
    end
    return inventory.remove({type = "item", name = itemId, count = intention })
end

local function requestItems (context, itemId, requestAmount)
    local itemsTaken = 0
    for _, chest in pairs(context.nonEmptyChests) do
        if chest.get_item_count(itemId) > 1 then
            local intention = requestAmount - itemsTaken
            itemsTaken = itemsTaken + extractFromInventory(chest, itemId, intention, true)
            if itemsTaken == requestAmount then
                return itemsTaken
            end
        end
    end
    for _, machine in pairs(context.nonEmptyMachines) do
        if machine.get_item_count(itemId) > 0 then
            local intention = requestAmount - itemsTaken
            itemsTaken = itemsTaken + extractFromInventory(machine, itemId, intention, false)
            if itemsTaken == requestAmount then
                return itemsTaken
            end
        end
    end
    return itemsTaken
end

local function insertItem (context, machine, itemId, count, multiplier)
    local required = count * multiplier
    local inventory = machine.get_inventory(defines.inventory.assembling_machine_input)
    if inventory.get_item_count(itemId) < required then
        if inventory.can_insert({type = "item", name = itemId, count = required}) then
            local requested = requestItems(context, itemId, required)
            if requested > 0 then
                inventory.insert({type = "item", name = itemId, count = requested})
            end
        end
    end
end

local function serveMachine (context, machine)
    local recipe
    if machine.type == "assembling-machine" then
        recipe = machine.get_recipe()
    end
    if machine.type == "furnace" and machine.previous_recipe then
        recipe = machine.previous_recipe.name
    end
    if recipe then
        local ingredients = recipe.ingredients
        local craftMultiplier = math.ceil(1 / recipe.energy * (machine.crafting_speed or 1)) * 2
        for _, ingredient in pairs(ingredients) do
            if ingredient.type == "item" then
                insertItem(context, machine, ingredient.name, ingredient.amount, craftMultiplier)
            end
        end
    end
end

local function serveOutput (context, output)
    for _, item in pairs(output.get_contents()) do
        local itemsLeft = item.count
        for _, chest in pairs(context.nonEmptyChests) do
            if chest.get_item_count(item.name) > 0 then
                local inserted = chest.insert({type = "item", name = item.name, count = item.count})
                if inserted > 0 then
                    itemsLeft = itemsLeft - output.remove({type = "item", name = item.name, count = inserted})
                end
            end
            if itemsLeft == 0 then
                break
            end
        end
    end
end

local function createContext (chests, machines)
    local context = {
        nonEmptyChests = {}, -- non-empty chest inventories (used to refill and output results)
        nonEmptyMachines = {}, -- non-empty output inventories (used to refill only)
        servedMachines = {} -- list of machines with cloud access module
    }
    for _, chest in pairs(chests) do
        if chest and chest.valid and not chest.get_inventory(defines.inventory.chest).is_empty() then
            table.insert(context.nonEmptyChests, chest.get_inventory(defines.inventory.chest))
        end
    end
    for _, machine in pairs(machines) do
        if machine and machine.valid and machine.get_module_inventory() and machine.get_module_inventory().get_item_count("cc-cloud-access-module") > 0 then
            table.insert(context.servedMachines, machine)
            if not machine.get_output_inventory().is_empty() then
                table.insert(context.nonEmptyMachines, machine.get_output_inventory())
            end
        end
    end
    return context
end

script.on_nth_tick(60, function()
    for _, surface in pairs(storage.surfaces or {}) do
        local context = createContext(surface.chests, surface.machines)
        for _, output in pairs(context.nonEmptyMachines) do
            serveOutput(context, output)
        end
        for _, machine in pairs(context.servedMachines) do
            serveMachine(context, machine)
        end
    end
end)

local function isEntityChest (entity)
    return entity.name == "cc-cloud-chest" or entity.name == "cc-cloud-logistic-chest"
end

local function isEntityMachine (entity)
    if entity.type == "assembling-machine" or entity.type == "furnace" then
        return entity.can_insert({name = "cc-cloud-access-module"})
    end
end

local function entityPlacementHandler (entity)
    if storage.chests then
        storage.chests = nil
    end
    if storage.machines then
        storage.machines = nil
    end
    if entity ~= nil and entity.valid then
        local surfaceIndex = entity.surface.index
        if storage.surfaces == nil then
            storage.surfaces = {}
        end
        if storage.surfaces[surfaceIndex] == nil then
            storage.surfaces[surfaceIndex] = {chests = {}, machines = {}}
        end
        if isEntityChest(entity) then
            table.insert(storage.surfaces[surfaceIndex].chests, entity)
            --game.get_player(1).print("Cloud chest registered")
            return
        end
        if isEntityMachine(entity) then
            table.insert(storage.surfaces[surfaceIndex].machines, entity)
            --game.get_player(1).print("Machine registered")
        end
    end
end

script.on_event(defines.events.on_built_entity, function(event) entityPlacementHandler(event.entity) end)
script.on_event(defines.events.on_robot_built_entity, function(event) entityPlacementHandler(event.entity) end)
script.on_event(defines.events.on_entity_cloned, function(event) entityPlacementHandler(event.destination) end)
script.on_event(defines.events.on_space_platform_built_entity, function(event) entityPlacementHandler(event.entity) end)

local function removeEntityFromIndex (index, entity)
    for counter = 1, #index do
        if index[counter] == entity then
            table.remove(index, counter)
            return true
        end
    end
    return false
end

local function entityRemovalHandler (event)
    if event.entity and event.entity.valid then
        local surfaceIndex = event.entity.surface.index
        if storage.surfaces == nil then
            return
        end
        if storage.surfaces[surfaceIndex] == nil then
            return
        end
        local surface = storage.surfaces[surfaceIndex]
        if isEntityChest(event.entity) then
            if removeEntityFromIndex(surface.chests, event.entity) then
                --game.get_player(1).print("Cloud Chest removed")
                return
            end
        end
        if isEntityMachine(event.entity) then
            if removeEntityFromIndex(surface.machines, event.entity) then
                --game.get_player(1).print("Machine removed")
                return
            end
        end
    end
end

script.on_event({
    defines.events.on_entity_died,
    defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity
}, entityRemovalHandler)