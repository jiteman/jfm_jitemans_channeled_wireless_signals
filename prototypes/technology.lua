require( "names" )

data:extend( {
    {
        type = "technology",
        name = "jitemans-channeled-wireless-signals-technology",
        icon = this_mode_path .. "/graphics/".. "jitemans-channeled-wireless-signals-technology-icon" .. ".png",
        icon_size = 128,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "jitemans-channeled-signal-transmitter"
            },
            {
                type = "unlock-recipe",
                recipe = "jitemans-channeled-signal-receiver"
            }
        },
        prerequisites = { "circuit-network", "advanced-electronics-2" },
        unit = {
            count = 300,
            ingredients = {
                { "science-pack-1", 1 },
                { "science-pack-2", 1 },
                { "science-pack-3", 1 },
            },
            time = 45
        },
        order = "a-d-e",
    }
} )
