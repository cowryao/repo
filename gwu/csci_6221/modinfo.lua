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
		name = "Test_Spawn_A_Creature",
		label = "Spawn Creature Test",
		options =	{
						{description = "Off", data = "off"},
						{description = "On", data = "on"},
					},

		default = "off",
	},

}