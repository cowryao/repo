-- This information tells other players more about the mod
name = "Chicken Dinner Mod"
description = "This is a mod for 6221 class \n project link is https://github.com/zheminggu/repo/tree/master/gwu/csci_6221"
author = "chicken dinner"
version = "0.01"

-- maybe our forum thread is here
forumthread = "https://github.com/zheminggu/repo/tree/master/gwu/csci_6221"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 6

-- Compatibility
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatble =true

-- Can specify a custom icon for this mod!
icon_atlas = "ChickenDinnerIcon.xml"
icon = "ChickenDinnerIcon.tex"

-- Specify the priority
-- priority=-1

configuration_options =
{
    -- use GetModConfigData("test_options_01")
	{
        -- name for mod main to get the user
        -- serves as an id
        name = "test_options_01",
        --this will displayed to user
		label = "user side information",
		options =	{
                        -- some possible selection
                        --description: for user
                        --data: for modmain as a parameter
						{description = "User Option 1", data = "Info_Value_01"},
						{description = "User Option 2", data = "Info_Value_02"},
					},

		default = "Info_Value_01",

	},

	{
		name = "Test_On",
		label = "In Test Mode",
		options =	{
						{description = "Off", data = "off"},
						{description = "On", data = "on"},
					},

		default = "off",
	},

	{
		name = "Nezha_Hp_Regen",
		label = "Nezha Hp Regen",
		options =
		{
			{description = "0.5 per 1 sec", data = 0.5,hover = "0.5 hp every 1 seconds"},
			{description = "1 per 1 sec", data = 1,hover = "1 hp every 1 seconds"},
			{description = "2 per 1 sec", data = 2,hover = "2 hp every 1 seconds"},
			{description = "5 per 1 sec", data = 5,hover = "5 hp every 1 seconds"},
			{description = "10 per 1 sec", data = 10,hover = "10 hp every 1 seconds"},
			{description = "10000 per 1 sec", data = 10000,hover = "10000 hp every 1 seconds"},
		},
		default = 1,
	},

	{
		name = "Nezha_small_stomach_val",
		label = "Nezha small stomach val",
		options =
		{
			{description = "100", data = 100,hover = "Nezha small stomach val is 100"},
			{description = "200", data = 200,hover = "Nezha small stomach val is 200"},
			{description = "500", data = 500,hover = "Nezha small stomach val is 500"},
			{description = "1000", data = 1000,hover = "Nezha small stomach val is 1000"},
			{description = "1000000", data = 1000000,hover = "Nezha small stomach val is 1000000"},
		},
		default = 200,
	},

	{
		name = "Nezha_small_brain_val",
		label = "Nezha small brain val",
		options =
		{
			{description = "100", data = 100,hover = "Nezha small brain val is 100"},
			{description = "200", data = 200,hover = "Nezha small brain val is 200"},
			{description = "500", data = 500,hover = "Nezha small brain val is 500"},
			{description = "1000", data = 1000,hover = "Nezha small brain val is 1000"},
			{description = "1000000", data = 1000000,hover = "Nezha small brain val is 1000000"},
		},
		default = 200,
	},

	{
		name = "Nezha_small_heart_val",
		label = "Nezha small heart val",
		options =
		{
			{description = "100", data = 100,hover = "Nezha small heart val is 100"},
			{description = "200", data = 200,hover = "Nezha small heart val is 200"},
			{description = "500", data = 500,hover = "Nezha small heart val is 500"},
			{description = "1000", data = 1000,hover = "Nezha small heart val is 1000"},
			{description = "1000000", data = 1000000,hover = "Nezha small heart val is 1000000"},
		},
		default = 200,
	},

	{
		name = "Nezha_big_stomach_val",
		label = "Nezha big stomach val",
		options =
		{
			{description = "100", data = 100,hover = "Nezha big stomach val is 100"},
			{description = "200", data = 200,hover = "Nezha big stomach val is 200"},
			{description = "500", data = 500,hover = "Nezha big stomach val is 500"},
			{description = "1000", data = 1000,hover = "Nezha big stomach val is 1000"},
			{description = "1000000", data = 1000000,hover = "Nezha big stomach val is 1000000"},
		},
		default = 200,
	},

	{
		name = "Nezha_big_brain_val",
		label = "Nezha big brain val",
		options =
		{
			{description = "100", data = 100,hover = "Nezha big brain val is 100"},
			{description = "200", data = 200,hover = "Nezha big brain val is 200"},
			{description = "500", data = 500,hover = "Nezha big brain val is 500"},
			{description = "1000", data = 1000,hover = "Nezha big brain val is 1000"},
			{description = "1000000", data = 1000000,hover = "Nezha big brain val is 1000000"},
		},
		default = 200,
	},

	{
		name = "Nezha_big_heart_val",
		label = "Nezha big heart val",
		options =
		{
			{description = "100", data = 100,hover = "Nezha big heart val is 100"},
			{description = "200", data = 200,hover = "Nezha big heart val is 200"},
			{description = "500", data = 500,hover = "Nezha big heart val is 500"},
			{description = "1000", data = 1000,hover = "Nezha big heart val is 1000"},
			{description = "1000000", data = 1000000,hover = "Nezha big heart val is 1000000"},
		},
		default = 200,
	},

	{
		name = "Nezha_big_stomach_decline_rate",
		label = "Nezha big stomach decline rate",
		options =
		{
			{description = "0.1", data = 0.1,hover = "Nezha big stomach decline rate is 0.1"},
			{description = "0.5", data = 0.5,hover = "Nezha big stomach decline rate is 0.5"},
			{description = "1", data = 1,hover = "Nezha big stomach decline rate is 1"},
			{description = "3", data = 3,hover = "Nezha big stomach decline rate is 3"},
			{description = "5", data = 5,hover = "Nezha big stomach decline rate is 5"},
		},
		default = 1,
	},

	{
		name = "Nezha_big_brain_decline_rate",
		label = "Nezha big brain decline rate",
		options =
		{
			{description = "0.15", data = 0.15,hover = "Nezha big brain increase rate is 0.15"},
			{description = "0.45", data = 0.45,hover = "Nezha big brain increase rate is 0.45"},
			{description = "1", data = 1,hover = "Nezha big brain increase rate is 1"},
			{description = "1.5", data = 1.5,hover = "Nezha big brain increase rate is 1.5"},
			{description = "3", data = 3,hover = "Nezha big brain increase rate is 3"},
		},
		default = 0.15,
	},

	{
		name = "Nezha_big_heart_decline_rate",
		label = "Nezha big heart decline rate",
		options =
		{
			{description = "0.1", data = 0.1,hover = "Nezha big heart decline rate is 0.1"},
			{description = "0.5", data = 0.5,hover = "Nezha big heart decline rate is 0.5"},
			{description = "1", data = 1,hover = "Nezha big heart decline rate is 1"},
			{description = "3", data = 3,hover = "Nezha big heart decline rate is 3"},
			{description = "5", data = 5,hover = "Nezha big heart decline rate is 5"},
		},
		default = 1,
	},

	{
		name = "Nezha_small_stomach_decline_rate",
		label = "Nezha small stomach decline rate",
		options =
		{
			{description = "0.1", data = 0.1,hover = "Nezha small stomach decline rate is 0.1"},
			{description = "0.5", data = 0.5,hover = "Nezha small stomach decline rate is 0.5"},
			{description = "1", data = 1,hover = "Nezha small stomach decline rate is 1"},
			{description = "3", data = 3,hover = "Nezha small stomach decline rate is 3"},
			{description = "5", data = 5,hover = "Nezha small stomach decline rate is 5"},
		},
		default = 1,
	},

	{
		name = "Nezha_small_brain_decline_rate",
		label = "Nezha small brain decline rate",
		options =
		{
			{description = "0.05", data = 0.05,hover = "Nezha small brain increase rate is 0.05"},
			{description = "0.15", data = 0.15,hover = "Nezha small brain increase rate is 0.15"},
			{description = "0.5", data = 0.5,hover = "Nezha small brain increase rate is 0.5"},
			{description = "1", data = 1,hover = "Nezha small brain increase rate is 1"},
			{description = "3", data = 3,hover = "Nezha small brain increase rate is 3"},
		},
		default = 0.05,
	},

	{
		name = "Nezha_small_heart_decline_rate",
		label = "Nezha small heart decline rate",
		options =
		{
			{description = "0.1", data = 0.1,hover = "Nezha small heart decline rate is 0.1"},
			{description = "0.5", data = 0.5,hover = "Nezha small heart decline rate is 0.5"},
			{description = "1", data = 1,hover = "Nezha small heart decline rate is 1"},
			{description = "3", data = 3,hover = "Nezha small heart decline rate is 3"},
			{description = "5", data = 5,hover = "Nezha small heart decline rate is 5"},
		},
		default = 1,
	},

	{
		name = "Nezha_small_move_speed",
		label = "Nezha small move speed",
		options =
		{
			{description = "4", data = 4,hover = "Nezha small move speed is 4"},
			{description = "8", data = 8,hover = "Nezha small move speed is 8"},
			{description = "12", data = 12,hover = "Nezha small move speed is 12"},
			{description = "24", data = 24,hover = "Nezha small move speed is 24"},
			{description = "48", data = 48,hover = "Nezha small move speed is 48"},
		},
		default = 8,
	},

	{
		name = "Nezha_big_move_speed",
		label = "Nezha big move speed",
		options =
		{
			{description = "10", data = 10,hover = "Nezha big move speed is 10"},
			{description = "20", data = 20,hover = "Nezha big move speed is 20"},
			{description = "40", data = 40,hover = "Nezha big move speed is 40"},
			{description = "80", data = 80,hover = "Nezha big move speed is 80"},
			{description = "160", data = 160,hover = "Nezha big move speed is 160"},
		},
		default = 20,
	},

	{
		name = "Nezha_small_defence_val",
		label = "Nezha small defence val",
		options =
		{
			{description = "1", data = 1,hover = "Nezha small defence val is 1"},
			{description = "2", data = 2,hover = "Nezha small defence val is 2"},
			{description = "4", data = 4,hover = "Nezha small defence val is 4"},
			{description = "8", data = 8,hover = "Nezha small defence val is 8"},
			{description = "16", data = 16,hover = "Nezha small defence val is 16"},
		},
		default = 1,
	},

	{
		name = "Nezha_big_defence_val",
		label = "Nezha big defence val",
		options =
		{
			{description = "1", data = 1,hover = "Nezha big defence val is 1"},
			{description = "2", data = 2,hover = "Nezha big defence val is 2"},
			{description = "4", data = 4,hover = "Nezha big defence val is 4"},
			{description = "8", data = 8,hover = "Nezha big defence val is 8"},
			{description = "16", data = 16,hover = "Nezha big defence val is 16"},
		},
		default = 1,
	},

	{
		name = "Nezha_small_attack_val",
		label = "Nezha small attack val",
		options =
		{
			{description = "1", data = 1,hover = "Nezha big attack val is 1"},
			{description = "3", data = 3,hover = "Nezha big attack val is 3"},
			{description = "9", data = 9,hover = "Nezha big attack val is 9"},
			{description = "27", data = 27,hover = "Nezha big attack val is 27"},
			{description = "81", data = 81,hover = "Nezha big attack val is 81"},
		},
		default = 1,
	},

	{
		name = "Nezha_big_attack_val",
		label = "Nezha big attack val",
		options =
		{
			{description = "3", data = 3,hover = "Nezha big attack val is 3"},
			{description = "9", data = 9,hover = "Nezha big attack val is 9"},
			{description = "27", data = 27,hover = "Nezha big attack val is 27"},
			{description = "81", data = 81,hover = "Nezha big attack val is 81"},
			{description = "243", data = 243,hover = "Nezha big attack val is 243"},
		},
		default = 3,
	},


}
