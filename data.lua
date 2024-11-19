local GRAPHICS_PATH = "__cloud-crafting__/"

data:extend({
    {
        type = "item",
        name = "cc-fine-quartz",
        icon = GRAPHICS_PATH .. "cc-item-fine-quartz.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        stack_size = 50
    },
    {
        type = "item",
        name = "cc-resonating-crystal",
        icon = GRAPHICS_PATH .. "cc-item-resonating-crystal.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        stack_size = 50
    },
    {
        type = "item",
        name = "cc-cloud-chest",
        icon = GRAPHICS_PATH .. "cc-item-cloud-chest.png",
        icon_size = 64,
        subgroup = "storage",
        stack_size = 50,
        place_result = "cc-cloud-chest"
    },
    {
        type = "item",
        name = "cc-cloud-logistic-chest",
        icon = GRAPHICS_PATH .. "cc-item-cloud-logistic-chest.png",
        icon_size = 64,
        subgroup = "storage",
        stack_size = 50,
        place_result = "cc-cloud-logistic-chest"
    },
    {
        type = "item",
        name = "cc-cloud-storage-tank",
        icon = GRAPHICS_PATH .. "cc-item-cloud-storage-tank.png",
        icon_size = 64,
        subgroup = "storage",
        stack_size = 50,
        place_result = "cc-cloud-storage-tank"
    },
    {
        type = "module",
        name = "cc-cloud-access-module",
        icon = GRAPHICS_PATH .. "cc-item-cloud-access-module.png",
        icon_size = 64,
        subgroup = "module",
        category = "speed",
        tier = 1,
        order = "a[speed]-a[cloud-access-module]",
        stack_size = 50,
        effect = {
            speed = -0.1,
            consumption = 0.1
        },
        beacon_tint = {
            primary = {r = 0.441, g = 0.714, b = 1.000, a = 1.000},
            secondary = {r = 0.388, g = 0.976, b = 1.000, a = 1.000}
        },
        art_style = "vanilla",
        requires_beacon_alt_mode = false
    },
    {
        type = "recipe",
        name = "cc-fine-quartz",
        icon = GRAPHICS_PATH .. "cc-item-fine-quartz.png",
        subgroup = "intermediate-product",
        category = "advanced-crafting",
        energy_required = 1,
        allow_quality = false,
        ingredients = {
            {type = "item", name = "stone", amount = 5}
        },
        results = {
            {type = "item", name = "stone", amount = 2, probability = 0.75},
            {type = "item", name = "cc-fine-quartz", amount = 1, probability = 0.25}
        }
    },
    {
        type = "recipe",
        name = "cc-resonating-crystal",
        category = "advanced-crafting",
        energy_required = 60,
        allow_quality = false,
        ingredients = {
            {type = "item", name = "cc-fine-quartz", amount = 5},
            {type = "item", name = "copper-cable", amount = 50}
        },
        results = {
            {type = "item", name = "cc-resonating-crystal", amount = 1}
        }
    },
    {
        type = "recipe",
        name = "cc-cloud-access-module",
        category = "crafting",
        energy_required = 60,
        allow_quality = false,
        ingredients = {
            {type = "item", name = "cc-resonating-crystal", amount = 1},
            {type = "item", name = "electronic-circuit", amount = 15},
            {type = "item", name = "iron-plate", amount = 5}
        },
        results = {
            {type = "item", name = "cc-cloud-access-module", amount = 1}
        }
    },
    {
        type = "recipe",
        name = "cc-cloud-chest",
        category = "crafting",
        energy_required = 1,
        allow_quality = false,
        ingredients = {
            {type = "item", name = "iron-chest", amount = 1},
            {type = "item", name = "cc-resonating-crystal", amount = 1},
            {type = "item", name = "electronic-circuit", amount = 5}
        },
        results = {
            {type = "item", name = "cc-cloud-chest", amount = 1}
        }
    },
    {
        type = "recipe",
        name = "cc-cloud-logistic-chest",
        category = "crafting",
        energy_required = 1,
        allow_quality = false,
        ingredients = {
            {type = "item", name = "buffer-chest", amount = 1},
            {type = "item", name = "cc-cloud-chest", amount = 1}
        },
        results = {
            {type = "item", name = "cc-cloud-logistic-chest", amount = 1}
        }
    },
    {
        type = "recipe",
        name = "cc-cloud-storage-tank",
        category = "crafting",
        energy_required = 1,
        allow_quality = false,
        ingredients = {
            {type = "item", name = "storage-tank", amount = 1},
            {type = "item", name = "cc-resonating-crystal", amount = 1},
            {type = "item", name = "pump", amount = 1}
        },
        results = {
            {type = "item", name = "cc-cloud-storage-tank", amount = 1}
        }
    },
    {
        type = "container",
        name = "cc-cloud-chest",
        icon = GRAPHICS_PATH .. "cc-item-cloud-chest.png",
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.2, result = "cc-cloud-chest"},
        max_health = 200,
        corpse = "iron-chest-remnants",
        dying_explosion = "iron-chest-explosion",
        open_sound = {filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43},
        close_sound = {filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43},
        resistances = {
            {type = "fire", percent = 80},
            {type = "impact", percent = 30}
        },
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        fast_replaceable_group = "container",
        inventory_size = 32,
        impact_category = "metal",
        icon_draw_specification = {scale = 0.7},
        inventory_type = "with_filters_and_bar",
        gui_mode = "none",
        picture = {
            layers = {
                {
                    filename = GRAPHICS_PATH .. "cc-entity-cloud-chest.png",
                    priority = "extra-high",
                    width = 66,
                    height = 76,
                    shift = util.by_pixel(-0.5, -0.5),
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/iron-chest/iron-chest-shadow.png",
                    priority = "extra-high",
                    width = 110,
                    height = 50,
                    shift = util.by_pixel(10.5, 6),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        circuit_connector = circuit_connector_definitions["chest"],
        circuit_wire_max_distance = default_circuit_wire_max_distance
    },
    {
        type = "logistic-container",
        name = "cc-cloud-logistic-chest",
        icon = GRAPHICS_PATH .. "cc-item-cloud-logistic-chest.png",
        icon_size = 64,
        flags = {"placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "cc-cloud-logistic-chest"},
        max_health = 350,
        corpse = "iron-chest-remnants",
        dying_explosion = "buffer-chest-explosion",
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        resistances = {
            {type = "fire", percent = 90},
            {type = "impact", percent = 60}
        },
        fast_replaceable_group = "container",
        inventory_size = 48,
        inventory_type = "with_filters_and_bar",
        gui_mode = "none",
        logistic_mode = "buffer",
        open_sound = {filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43},
        close_sound = {filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43},
        animation_sound = {
            {filename = "__base__/sound/passive-provider-chest-open-1.ogg", volume = 0.3},
            {filename = "__base__/sound/passive-provider-chest-open-2.ogg", volume = 0.3},
            {filename = "__base__/sound/passive-provider-chest-open-3.ogg", volume = 0.3},
            {filename = "__base__/sound/passive-provider-chest-open-4.ogg", volume = 0.3},
            {filename = "__base__/sound/passive-provider-chest-open-5.ogg", volume = 0.3}
        },
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        opened_duration = 7,
        animation = {
            layers = {
                {
                    filename = GRAPHICS_PATH .. "cc-entity-cloud-logistic-chest.png",
                    priority = "extra-high",
                    width = 66,
                    height = 72,
                    frame_count = 7,
                    shift = util.by_pixel(0, -2),
                    scale = 0.5
                },
                {
                    filename = GRAPHICS_PATH .. "cc-entity-cloud-logistic-chest-shadow.png",
                    priority = "extra-high",
                    width = 112,
                    height = 46,
                    repeat_count = 7,
                    shift = util.by_pixel(12, 4.5),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        circuit_connector = circuit_connector_definitions["chest"],
        circuit_wire_max_distance = default_circuit_wire_max_distance
    },
    {
        type = "storage-tank",
        name = "cc-cloud-storage-tank",
        icon = GRAPHICS_PATH .. "cc-item-cloud-storage-tank.png",
        flags = {"placeable-player", "player-creation"},
        minable = {mining_time = 0.5, result = "cc-cloud-storage-tank"},
        max_health = 500,
        corpse = "storage-tank-remnants",
        dying_explosion = "storage-tank-explosion",
        collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        fast_replaceable_group = "storage-tank",
        icon_draw_specification = {scale = 1.5, shift = {0, -0.3}},
        fluid_box = {
            volume = 25000,
            pipe_covers = pipecoverspictures(),
            pipe_connections = {
                {direction = defines.direction.north, position = {-1, -1}},
                {direction = defines.direction.east, position = {1, 1}},
                {direction = defines.direction.south, position = {1, 1}},
                {direction = defines.direction.west, position = {-1, -1}}
            },
            hide_connection_info = true
        },
        two_direction_only = true,
        window_bounding_box = {{-0.125, 0.6875}, {0.1875, 1.1875}},
        pictures = {
            picture = {
                sheets = {
                    {
                        filename = GRAPHICS_PATH .. "cc-entity-cloud-storage-tank.png",
                        priority = "extra-high",
                        frames = 2,
                        width = 219,
                        height = 215,
                        shift = util.by_pixel(-0.25, 3.75),
                        scale = 0.5
                    },
                    {
                        filename = "__base__/graphics/entity/storage-tank/storage-tank-shadow.png",
                        priority = "extra-high",
                        frames = 2,
                        width = 291,
                        height = 153,
                        shift = util.by_pixel(29.75, 22.25),
                        scale = 0.5,
                        draw_as_shadow = true
                    }
                }
            },
            fluid_background = {
                filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
                priority = "extra-high",
                width = 32,
                height = 15
            },
            window_background = {
                filename = "__base__/graphics/entity/storage-tank/window-background.png",
                priority = "extra-high",
                width = 34,
                height = 48,
                scale = 0.5
            },
            flow_sprite = {
                filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
                priority = "extra-high",
                width = 160,
                height = 20
            },
            gas_flow = {
                filename = "__base__/graphics/entity/pipe/steam.png",
                priority = "extra-high",
                line_length = 10,
                width = 48,
                height = 30,
                frame_count = 60,
                animation_speed = 0.25,
                scale = 0.5
            }
        },
        flow_length_in_ticks = 360,
        impact_category = "metal-large",
        open_sound = {filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43},
        close_sound = {filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43},
        working_sound = {
            sound = {filename = "__base__/sound/storage-tank.ogg", volume = 0.6},
            match_volume_to_activity = true,
            audible_distance_modifier = 0.5,
            max_sounds_per_type = 3
        },
        circuit_connector = circuit_connector_definitions["storage-tank"],
        circuit_wire_max_distance = default_circuit_wire_max_distance,
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/storage-tank/storage-tank-reflection.png",
                priority = "extra-high",
                width = 24,
                height = 24,
                shift = util.by_pixel(5, 35),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    }
})