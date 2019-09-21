
-- local testing_1= GetModConfigData("test_options_01")

---------------- test of spawn a creature----------
local Test_Spawn_A_Creature= GetModConfigData("Test_Spawn_A_Creature")

local DEBUG_KEY = GLOBAL.assert(GLOBAL.KEY_P)

local function SpawnCreature()
	local player = GLOBAL.GetPlayer()
	local x, y, z = player.Transform:GetWorldPosition()
	local creature = GLOBAL.SpawnPrefab("forest/animals/beefalo")
	creature.Transform:SetPosition( x, y, z )	
end



-----------Mod main method --------------------------
local function AfterLoadingTheWorld(player)
	local player_controller= player.components.playercontroller
	if player_controller then
		 player_controller.OnControl=(
			function()
				local onControl= player_controller.OnControl
				return function(self, ...)
					if not (DEBUG_KEY and GLOBAL.TheInput:IsKeyDown(DEBUG_KEY)) then
						return onControl(self, ...)
					end
				end
			end)()
	end
	-- SpawnCreature()
	if Test_Spawn_A_Creature =="on" then
		GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_P, SpawnCreature)
	end
end

	

--[NEW] Tell the engine to run the function "SpawnCreature" as soon as the player spawns in the world.
AddSimPostInit(AfterLoadingTheWorld)






