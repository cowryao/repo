--feng huo lun
STRINGS.NAMES.NZ_WHEEL = "feng huo lun"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NZ_WHEEL = "hiii ha!"

local function GetDesc(inst)
	inst.components.inspectable.getstatus = function(inst)
		return inst.state:upper()
	end
end

local assets =
{

	Asset("ANIM","anim/nz_wheel.zip"),
	-- Asset("ATLAS", "images/inventoryimages/katanas.xml")

}


local function setupcontainer(inst, slots, bank, build, inspectslots, inspectbank, inspectbuild, inspectboatbadgepos, inspectboatequiproot)
	inst:AddComponent("container")
	inst.components.container:SetNumSlots(#slots)
	inst.components.container.type = "boat"
	inst.components.container.side_align_tip = -500
	inst.components.container.canbeopened = false

	inst.components.container.widgetslotpos = slots
	inst.components.container.widgetanimbank = bank
	inst.components.container.widgetanimbuild = build
	inst.components.container.widgetboatbadgepos = Vector3(0, 40, 0)
	inst.components.container.widgetequipslotroot = Vector3(-80, 40, 0)

	local boatwidgetinfo = {}
	boatwidgetinfo.widgetslotpos = inspectslots
	boatwidgetinfo.widgetanimbank = inspectbank
	boatwidgetinfo.widgetanimbuild = inspectbuild
	boatwidgetinfo.widgetboatbadgepos = inspectboatbadgepos
	boatwidgetinfo.widgetpos = Vector3(200, 0, 0)
	boatwidgetinfo.widgetequipslotroot = inspectboatequiproot
	inst.components.container.boatwidgetinfo = boatwidgetinfo
end

local function OnMounted(inst,data)

	inst.Physics:SetActive(false)
	--inst.onboatdelta = function () return end
	
	if data and data.driver then
		local driver = data.driver

		driver.components.temperature.hot_resistance_override =  10000
		driver.components.health.fire_damage_scale = driver.components.health.fire_damage_scale - 1
		
		inst.entity:SetParent(driver.entity) 
		inst.Transform:SetPosition(0,0,0)
		driver.Physics:ClearCollisionMask()
    	driver.Physics:CollidesWith(COLLISION.GROUND)
    	--driver.Physics:CollidesWith(COLLISION.OBSTACLES)
    	driver.Physics:CollidesWith(COLLISION.CHARACTERS)
		driver.Physics:CollidesWith(COLLISION.WAVES)
		driver.components.locomotor:AddSpeedModifier_Mult('nz_wheel',.8)
		inst:DoTaskInTime(0,function() 
			inst.Transform:SetPosition(0,0,0)
			driver.Physics:ClearCollisionMask()
    		driver.Physics:CollidesWith(COLLISION.GROUND)
    		--driver.Physics:CollidesWith(COLLISION.OBSTACLES)
    		driver.Physics:CollidesWith(COLLISION.CHARACTERS)
			driver.Physics:CollidesWith(COLLISION.WAVES)
			driver:StopUpdatingComponent(driver.components.driver)
		end)

		if not inst.pos_task then
			inst.pos_task = inst:DoPeriodicTask(0,function()
				if GetPlayer().components.mapwrapper and GetPlayer().components.mapwrapper.state == 3 then
					inst.Transform:SetPosition(0,0,0)  
				end
			end)
		end

		if not inst.rot_task then
			inst.rot_task = inst:DoPeriodicTask(0,function()
				local rot = GetPlayer().Transform:GetRotation()
				inst.ring1.Transform:SetRotation(rot)
				inst.ring2.Transform:SetRotation(rot)
			end)
		end

	end
end

local function OnDismounted(inst,data)

	inst.entity:SetParent(nil)
	inst.Physics:SetActive(true)
	if data and data.driver then

		data.driver.components.temperature.hot_resistance_override =  nil

		data.driver.components.health.fire_damage_scale = data.driver.components.health.fire_damage_scale + 1

		inst.Transform:SetPosition(data.driver:GetPosition():Get())
		data.driver.components.locomotor:AddSpeedModifier_Mult('nz_wheel',0)
	end

	if inst.pos_task then
		inst.pos_task:Cancel()
		inst.pos_task = nil
	end
	if inst.rot_task then
		inst.rot_task:Cancel()
		inst.rot_task = nil
	end

end

local function OnDropped(inst)
	inst.entity:SetParent(nil)
	inst.Physics:SetActive(true)
	if inst.pos_task then
		inst.pos_task:Cancel()
		inst.pos_task = nil
	end
end

local function ondepletedfn(inst)
	local driver = inst.components.drivable and inst.components.drivable.driver
	if driver then
		driver.components.driver:OnDismount(true)
	end
	inst:SetCold()
end

local function onhealthdelta(inst,a,b)
	local function IsCross(aa,bb,c)
		return aa < c and bb >= c 
	end
	local say
	if IsCross(a,b,.5) then
		say = 1
	elseif IsCross(a,b,.25) then
		say = 2
	elseif IsCross(a,b,.1) then
		say = 3
	end
	local driver = inst.components.drivable.driver
	if driver and say then
		if driver.prefab == 'monkey_king' then
			local lines = MK_MOD_LANGUAGE_SETTING and 
			{
				'OoO','OoO','OoO',
			} or
			{
				'俺老孙的筋斗云开始晃了',
				'这云怕是载不起俺老孙了',
				'俺老孙该落地了',
			}
			driver.components.talker:Say(lines[say])
		else
			local lines = MK_MOD_LANGUAGE_SETTING and 
			{
				'','','',
			} or
			{
				'I want to get back to the ground.',
				"I don't want to fall",
				'Get me out of here!',
			}
			driver.components.talker:Say(lines[say])
		end
	end
end

local function fn()
	print("spawning wheel !!!!")
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddFollower()
	MakeInventoryPhysics(inst)

	inst.Transform:SetEightFaced()
	inst:DoPeriodicTask(0,function(inst)
		if not inst.components.drivable.driver then
			inst.ring1.AnimState:SetScale(1,1)
			inst.ring2.AnimState:SetScale(1,1)
			return 
		end
		local face = inst.ring1.AnimState:GetCurrentFacing()
		inst.ring1:SetFaced(face)
		inst.ring2:SetFaced(face)
	end)

	inst.AnimState:SetBank("nz_wheel")
    inst.AnimState:SetBuild("nz_wheel")
    inst.AnimState:SetRayTestOnBB(true)

    local ring1 = SpawnPrefab('nz_wheel_single')
    inst:AddChild(ring1)
    ring1.Transform:SetPosition(0,0,0.3)
    ring1.wheel = inst
    inst.ring1 = ring1	

    local ring2 = SpawnPrefab('nz_wheel_single')
    inst:AddChild(ring2)
    ring2.Transform:SetPosition(0,0,-0.3)
    ring2.wheel = inst
    inst.ring2 = ring2

    inst.AnimState:SetFinalOffset(1)

	setupcontainer(inst, {}, "boat_hud_raft", "boat_hud_raft", {}, "boat_inspect_raft", "boat_inspect_raft", {x=0,y=5}, {})
	inst.components.container.CollectSceneActions = function() return end

	inst:AddComponent('inventoryitem')
	inst.components.inventoryitem.nobounce = true
	--inst.components.inventoryitem.atlasname = "images/inventoryimages/mk_cloud.xml"
	local actionfn = inst.components.inventoryitem.CollectSceneActions
	inst.components.inventoryitem.CollectSceneActions = function(self,doer,actions,right)
		if not right then actionfn(self,doer,actions) end
	end

	inst.SetHot = function(inst)
		inst.components.inventoryitem.atlasname = "images/inventoryimages/nz_wheel_hot.xml"
		inst.components.inventoryitem:ChangeImageName("nz_wheel_hot")
		inst.state = 'HOT'
		inst.ring1:Show()
		inst.ring2:Show()

		if inst.components.floatable then
			inst.components.floatable.wateranim = 'hot'
			inst.components.floatable.land_anim = 'hot'
			inst.components.floatable:UpdateAnimations()
		end
		inst.AnimState:SetMultColour(0,0,0,0)  ---   _(:з」∠)_
	end

	inst.SetCold = function(inst)
		inst.components.inventoryitem.atlasname = "images/inventoryimages/nz_wheel_cold.xml"
		inst.components.inventoryitem:ChangeImageName("nz_wheel_cold")
		inst.ring1:Hide()
		inst.ring2:Hide()
		inst.ring1:KillFireFx()
		inst.ring2:KillFireFx()
		inst.state = 'COLD'

		if inst.components.floatable then
			inst.components.floatable.wateranim = 'cold_water'
			inst.components.floatable.land_anim = 'cold'
			inst.components.floatable:UpdateAnimations()
		end
		inst.AnimState:SetMultColour(1,1,1,1)
	end

	local fueltime =  3*480  
	local rate = 100/480 
	local deltap = 1/fueltime  
	inst:AddComponent('fueled')
	inst.components.fueled.maxfuel = 3*100
	inst.components.fueled:InitializeFuelLevel(0)
	inst.components.fueled.rate = rate
	inst.components.fueled:SetDepletedFn(ondepletedfn)
	inst.components.fueled.fueltype = "NZ_WHEEL"
	inst.components.fueled.OnSave = function(self) return {fuel = self.currentfuel} end
	--inst.components.fueled.accepting = false
	--inst.components.fueled:SetPercent(0)
	inst.components.fueled.CanAcceptFuelItem = function(self, item)
		return inst.state == 'HOT' and item and item.prefab == 'redgem'
	end
	--inst.components.fueled:StartConsuming()

	inst:ListenForEvent('percentusedchange',function(inst) 
		local now = inst.components.fueled:GetPercent()
		inst:PushEvent('cloudhealthchange',{percent=now,oldpercent=now+deltap,maxhealth=inst.components.fueled.maxfuel,});
		onhealthdelta(inst,now,now+deltap)
	end)
	
	
	inst:AddComponent("drivable")
	inst.components.drivable.overridebuild = 'mk_cloudfx'
	inst.components.drivable.flotsambuild = 'mk_cloudfx'

	inst.components.drivable.prerunanimation = 'surf_pre'
	inst.components.drivable.runanimation = 'surf_loop'
	inst.components.drivable.postrunanimation = 'surf_pst'

	inst.components.drivable.sailloopanim = "sail_loop"
	inst.components.drivable.sailstartanim = "sail_pre"
	inst.components.drivable.sailstopanim = "sail_pst"

	inst.components.drivable.alwayssail = true
	inst.components.drivable.hitfx = 'mk_firefire2'

	inst.components.drivable.creaksound = ''
	inst.components.drivable.runspeed = .5
	inst.components.drivable.donothideonmounted = true
	inst.components.drivable.maprevealbonus = 3
	inst.components.drivable.candrivefn = function(inst) return inst.state == 'HOT' end

	inst:ListenForEvent('mounted',OnMounted)
	inst:ListenForEvent('dismounted',OnDismounted)
	inst:ListenForEvent('ondropped',OnDropped)

	inst:AddComponent('inspectable')

	inst:AddTag('irreplaceable')

	inst:SetCold()
	--inst:SetHot()
	inst.OnLoad = function(inst,data)
		if inst.components.fueled:IsEmpty() then
			inst:SetCold()
		else
			inst:SetHot()
		end
	end
	inst:DoTaskInTime(0,function()
		if GetPlayer().prefab ~= 'neza' then
			inst:Remove() --@--
		end
	end)
	GetDesc(inst)

	return inst
end

local function fn2()
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	inst.entity:AddPhysics()

	inst.AnimState:SetBank("nz_wheel")
    inst.AnimState:SetBuild("nz_wheel")
    inst.AnimState:Hide('center1');inst.AnimState:Hide('center2');inst.AnimState:Hide('center3')
    inst.AnimState:PlayAnimation('flying',true)
    inst.AnimState:SetRayTestOnBB(true)


    inst.SpawnFirefx = function (inst)
    	if inst.wheel and inst.wheel.state == 'COLD' then
    		return
    	end
    	if not inst.firefx then
    		local fire = SpawnPrefab('torchfire')
    		fire.entity:AddFollower()
    		fire.entity:MoveToFront()
    		fire.Follower:FollowSymbol(inst.GUID,'center3',0,0,0)
    		inst.firefx = fire
    	end
    end

    inst.KillFireFx = function(inst)
    	if inst.firefx then
    		inst.firefx:Remove()
    		inst.firefx = nil
    	end
    end

    inst:DoTaskInTime(0,function(inst)
    	if not (inst.wheel and inst.wheel:HasTag("INLIMBO"))then
    		inst:SpawnFirefx()
    	end
    	inst:ListenForEvent('enterlimbo',function(wheel)inst:KillFireFx()end,inst.wheel)
		inst:ListenForEvent('exitlimbo',function(wheel)inst:SpawnFirefx()end,inst.wheel)
    end)
    
    inst.AnimState:SetFinalOffset(-5)

	inst.Transform:SetScale(1.2, 1.2, 1.2)
	inst.Transform:SetEightFaced()
	inst.SetFaced = function(inst,face) 
		if face == FACING_LEFT or face == FACING_RIGHT then
			inst.AnimState:SetScale(1,1)
		elseif face == FACING_UP or face == FACING_DOWN then
			inst.AnimState:SetScale(.2,1)
		else
			inst.AnimState:SetScale(.5,1)
		end
	end
	inst:AddComponent('inspectable')
	inst.components.inspectable.onlyforcedinspect = true
	inst.components.inspectable.CollectSceneActions = function(self,doer, actions, right) 
    	if doer.components.driver and right and inst.wheel and inst.wheel.state == 'HOT' then
           	table.insert(actions, ACTIONS.MOUNT)
    	end
	end

	GetDesc(inst)

	return inst
end


return Prefab("nz_wheel", fn, assets),Prefab("nz_wheel_single", fn2, assets)
