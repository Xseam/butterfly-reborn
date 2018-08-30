--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

--
showvar = 0
--

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ()
	setPlayerHudComponentVisible ( "ammo", false )
	setPlayerHudComponentVisible ( "area_name", false )
	setPlayerHudComponentVisible ( "armour", false )
	setPlayerHudComponentVisible ( "breath", false )
	setPlayerHudComponentVisible ( "clock", true )
	setPlayerHudComponentVisible ( "health", false )
	setPlayerHudComponentVisible ( "money", false )
	setPlayerHudComponentVisible ( "weapon", false )
	setPlayerHudComponentVisible ( "armour", false )
	--setPlayerHudComponentVisible( "crosshair", false)
	bindKey("x", "up", hideAllHuds)
	bindKey("x", "down", showAllHuds)
	showvar = true
	fileDelete("show/hud_c.lua")
end
)

function hideAllHuds()

	setPlayerHudComponentVisible ( "ammo", false )
	setPlayerHudComponentVisible ( "area_name", false )
	setPlayerHudComponentVisible ( "armour", false )
	setPlayerHudComponentVisible ( "breath", false )
	--setPlayerHudComponentVisible ( "clock", false )
	setPlayerHudComponentVisible ( "health", false )
	setPlayerHudComponentVisible ( "money", false )
	setPlayerHudComponentVisible ( "weapon", false )
	setPlayerHudComponentVisible ( "armour", false )
	hideHunger()
	showvar = true

end

function showAllHuds()
	setPlayerHudComponentVisible ( "all", true )
	showvar = false
	showHunger()
end
function showLebenKurz()
	setPlayerHudComponentVisible( "health", true)
	setPlayerHudComponentVisible( "armour", true)
	if(isTimer(health_timer)) then killTimer(health_timer) else
	health_timer = setTimer(
	function()
	setPlayerHudComponentVisible( "health", false)
	setPlayerHudComponentVisible( "armour", false)
	end, 3000, 1)
	end
end
addEvent("showRightHud", true)
addEventHandler("showRightHud", getRootElement(),
function()
	setPlayerHudComponentVisible ( "all", true )
	setPlayerHudComponentVisible ( "ammo", false )
	setPlayerHudComponentVisible ( "area_name", false )
	setPlayerHudComponentVisible ( "armour", false )
	setPlayerHudComponentVisible ( "breath", false )
	setPlayerHudComponentVisible ( "clock", true )
	setPlayerHudComponentVisible ( "health", false )
	setPlayerHudComponentVisible ( "money", false )
	setPlayerHudComponentVisible ( "weapon", false )
	setPlayerHudComponentVisible ( "armour", false )
	
end)
local gFired = 0
addEventHandler( "onClientPlayerWeaponFire", getLocalPlayer(),
    function (  weapon, ammo, ammoinclip, hitX, hitY, hitZ, hitElement)
		
		local x, y, z = getElementPosition(gMe)
		if(gFired == 0) then
			createExplosion(x, y, z-15, 5, false, 0.15, false)
			gFired = 1
			setTimer(function() gFired = 0 end, 150, 1)
		end
        setPlayerHudComponentVisible( "weapon", true)
		setPlayerHudComponentVisible( "ammo", true)
		if(isTimer(scroll_timer)) then killTimer(scroll_timer) end
		scroll_timer = setTimer(
			function()
			setPlayerHudComponentVisible( "weapon", false)
			setPlayerHudComponentVisible( "ammo", false)
			end, 3000, 1)
    end
)
 
function Blood_on_Damage( attacker, weapon, bodypart, loss )
   if loss > 25 then
      local x, y, z = getElementPosition( source )
      local randombloodamount = math.random( 1, 3 )
      fxAddBlood ( x, y, z-2, 0.00000, 0.00000, 0.00000, randombloodamount, 1 )
	  fxAddBlood ( x, y, z-2, 0.00000, 0.00000, 0.00000, randombloodamount, 1 )
	  fxAddBlood ( x, y, z-2, 0.00000, 0.00000, 0.00000, randombloodamount, 1 )
	  fxAddBlood ( x, y, z-2, 0.00000, 0.00000, 0.00000, randombloodamount, 1 ) 
	  fxAddBlood ( x, y, z-2, 0.00000, 0.00000, 0.00000, randombloodamount, 1 )
   end
end
addEventHandler( "onClientPlayerDamage", getRootElement(), Blood_on_Damage ) 
local wrongWeapons = {
	[1] = true,
	[2] = true,
	[3] = true,
	[4] = true,
	[5] = true,
	[6] = true,
	[7] = true,
	[8] = true,
	[9] = true,
	[16] = true,
	[17] = true,
	[18] = true,
	[39] = true,
	[41] = true,
	[42] = true,
	[43] = true,
	[10] = true,
	[11] = true,
	[12] = true,
	[14] = true,
	[15] = true,
	[44] = true,
	[45] = true,
	[46] = true,
	[40] = true,
	[35] = true,
	[36] = true
}
addEventHandler("onClientPlayerWeaponFire", getRootElement(),
function(weapon, ammo, clip, hitX, hitY, hitZ, element)
	if(wrongWeapons[weapon] == true) then return end
	local x, y, z = getPedWeaponMuzzlePosition(gMe)
	fxAddPunchImpact(x, y, z, 0, 0, 0)
	if(element == nil) then
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
		fxAddPunchImpact ( hitX, hitY, hitZ, 1, 1, 1)
		fxAddBulletImpact ( hitX, hitY, hitZ, 1, 1, 1)
		
		local rand = math.random(0, 5)
			if(rand == 0) or (rand == 1) or (rand == 2) or (rand == 3) or (rand == 4) or (rand == 5) then -- Sinnlos, eigentlich sollte es zufall sein
				local ra = math.random(1, 5)
				local sound = playSound3D("sounds/bullets/bul"..ra..".mp3", hitX, hitY, hitZ)
				setSoundVolume(sound, 0.5)
				setSoundMaxDistance(sound, 20)
			end

	else
		if(getElementType(element) == "vehicle") then
				local rand = math.random(0, 20)
				if(rand == 0) then
					local ra = math.random(1, 7)
					local sound = playSound3D("sounds/glas/glas"..ra..".mp3", hitX, hitY, hitZ)
					setSoundVolume(sound, 0.2)
					setSoundMaxDistance(sound, 20)
				end
		end
		if(getElementType(element) == "player") or (getElementType(element) == "ped") then else
				local rand = math.random(0, 5)
				if(rand == 0) or (rand == 1) or (rand == 2) or (rand == 3) or (rand == 4) or (rand == 5) then -- Sinnlos, eigentlich sollte es zufall sein
					local ra = math.random(1, 5)
					local sound = playSound3D("sounds/bullets/bul"..ra..".mp3", hitX, hitY, hitZ)
					setSoundVolume(sound, 0.5)
					setSoundMaxDistance(sound, 20)
				end
		end
		if(getElementType(element) ~= "player") and (getElementType(element) ~= "ped") then
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddSparks ( hitX, hitY, hitZ, 1, 1, 1, 1, 3, 0, 0, 0, false, 2, 1)
			fxAddPunchImpact ( hitX, hitY, hitZ, 1, 1, 1)
			fxAddBulletImpact ( hitX, hitY, hitZ, 1, 1, 1)
		end
	end
end)

addEventHandler( "onClientPlayerWeaponSwitch", getLocalPlayer(),
    function (pre, cur  )
        setPlayerHudComponentVisible( "weapon", true)
		setPlayerHudComponentVisible( "ammo", true)
		if(isTimer(fire_timer)) then killTimer(fire_timer) end
		fire_timer = setTimer(
			function()
			setPlayerHudComponentVisible( "weapon", false)
			setPlayerHudComponentVisible( "ammo", false)
			end, 3000, 1)
		if(getPedWeapon(gMe, cur) == 43) then
			showChat(false)
		else
			showChat(true)
		end
    end
)

function aktualisiereMoney_func()
		if not(source) then
        setPlayerHudComponentVisible( "money", true)
		if(isTimer(money_timer)) then killTimer(money_timer) end
		money_timer = setTimer(
			function()
			setPlayerHudComponentVisible( "money", false)
			end, 4500, 1)
		else
		if not(source == gMe) then return end
		setPlayerHudComponentVisible( "money", true)
		if(isTimer(money_timer)) then killTimer(money_timer) end
		money_timer = setTimer(
			function()
			setPlayerHudComponentVisible( "money", false)
			end, 4500, 1)
		end
end

addEvent("aktualisiereMoney", true)
addEventHandler("aktualisiereMoney", getRootElement(), aktualisiereMoney_func)
local healthvar = 0
local hTimer1
local hTimer2

addEventHandler("onClientPlayerDamage", gMe,
function()
	if(healthvar == 0) then
		setPlayerHudComponentVisible( "health", true)
		setPlayerHudComponentVisible( "armour", true)
		healthvar = 1
		hTimer1 = setTimer(setPlayerHudComponentVisible, 5000, 1, "health", false)
		hTimer2 = setTimer(setPlayerHudComponentVisible, 5000, 1, "armour", false)
		setTimer(function() healthvar = 0 end, 5000, 1)
	end
end)
addCommandHandler("rebind", function() healthvar = 0 killTimer(hTimer1) killTimer(hTimer2) end)
function check_for_live_hud()
	if(getElementHealth(gMe) < 15) then
		setPlayerHudComponentVisible( "health", true)
		setPlayerHudComponentVisible( "armour", true)
	end
	if(isTimer(hTimer1)) or (isTimer(hTimer2)) then
		setPlayerHudComponentVisible( "health", true)
		setPlayerHudComponentVisible( "armour", true)
	end
end
addEventHandler("onClientRender", getRootElement(), check_for_live_hud)

function check_for_water_hud()
	if(isElementInWater(gMe)) then
		setPlayerHudComponentVisible( "breath", true)
	else
		setPlayerHudComponentVisible( "breath", false)
	end
end
addEventHandler("onClientRender", getRootElement(), check_for_water_hud)

local fireWeapons = {
[0]=false,
[1]=false,
[2]=true,
[3]=true,
[4]=true,
[5]=true,
[6]=true,
[7]=true
}


function check_hud_func()
		if(isPedInVehicle(gMe) == true) then return end
		local Gun = getPedWeapon ( gMe )
		if not(Gun) then return end
		if not(fireWeapons[getSlotFromWeapon(Gun)]) then return end
		local w, h = guiGetScreenSize ()
		local x, y, z = getPedTargetEnd ( gMe )
		if not(x) or not(y) or not(z) then return end
			local sx, sy = getScreenFromWorldPosition(x, y, z+0.55)
			local sx2, sy2 = getScreenFromWorldPosition(x, y, z-0.8)
			local sx3, sy3 = getScreenFromWorldPosition(x, y, z)
			local ducked = 0
			if(isPedDucked(gMe) == true) then 
				ducked = 0.2
			end
		if(Gun == 22) or (Gun == 23) or (Gun == 24) then
			sx, sy = getScreenFromWorldPosition(x, y, z+0.35)
			sx2, sy2 = getScreenFromWorldPosition(x, y, z-0.6)
			sx3, sy3 = getScreenFromWorldPosition(x, y, z)
		elseif(Gun == 25) or (Gun == 26) or (Gun == 27) then
			sx, sy = getScreenFromWorldPosition(x, y, z+0.25)
			sx2, sy2 = getScreenFromWorldPosition(x, y, z-0.5)
			sx3, sy3 = getScreenFromWorldPosition(x, y, z)
		elseif(Gun == 30) or (Gun == 31) then
			sx, sy = getScreenFromWorldPosition(x, y, z+0.75)
			sx2, sy2 = getScreenFromWorldPosition(x, y, z-1)
			sx3, sy3 = getScreenFromWorldPosition(x, y, z)
		elseif(Gun == 33)then
			sx, sy = getScreenFromWorldPosition(x, y, z+0.3)
			sx2, sy2 = getScreenFromWorldPosition(x, y, z-0.5)
			sx3, sy3 = getScreenFromWorldPosition(x, y, z)
		elseif(Gun == 35) or (Gun == 36) then
			sx, sy = getScreenFromWorldPosition(x, y, z+0.55)
			sx2, sy2 = getScreenFromWorldPosition(x, y, z-0.8)
			sx3, sy3 = getScreenFromWorldPosition(x, y, z)
		else
			sx, sy = getScreenFromWorldPosition(x, y, z+0.55)
			sx2, sy2 = getScreenFromWorldPosition(x, y, z-0.8)
			sx3, sy3 = getScreenFromWorldPosition(x, y, z)
		end
		
		if not(sx) or not(sy) then return end	
		if not(sx2) or not(sy2) then return end	
		if not(sx3) or not(sy3) then return end	
		dxDrawLine(sx, sy-8.9-ducked, sx, sy, tocolor(0, 0, 255), 2)
		dxDrawLine(sx2, sy2-8.9-ducked, sx2, sy2, tocolor(0, 0, 255), 2)
		dxDrawLine(sx3-22.9, sy3, sx3-14.9, sy3, tocolor(0, 0, 255), 2)
		dxDrawLine(sx3+22.9, sy3, sx3+14.9, sy3, tocolor(0, 0, 255), 2)
		
		dxDrawLine(sx, sy-8-ducked, sx, sy, tocolor(0, 255, 0), 2)
		dxDrawLine(sx2, sy2-8-ducked, sx2, sy2, tocolor(0, 255, 0), 2)
		dxDrawLine(sx3-22, sy3, sx3-14, sy3, tocolor(0, 255, 0), 2)
		dxDrawLine(sx3+22, sy3, sx3+14, sy3, tocolor(0, 255, 0), 2)
		dxDrawLine(sx3, sy3-0.3, sx3, sy3+0.3, tocolor(255, 0, 0), 3)
	
end

--[[
function check_hud_func()
	--if(getPedControlState ( gMe, "aim_weapon" ) == false) then return end
		local Gun = getPedWeapon ( gMe )
		if not(Gun) then return end
		local w, h = guiGetScreenSize ()
		local x, y, z = getPedTargetEnd ( gMe )
		if not(x) or not(y) or not(z) then return end
		local sx, sy = getScreenFromWorldPosition(x, y, z)
		if not(sx) or not(sy) then return end
		dxDrawLine(sx-10, sy, sx+10, sy+20, tocolor(0, 255, 0), 2)
		dxDrawLine(sx+5, sy, sx-5, sy-7, tocolor(0, 255, 0), 2)
end
--]]
addEventHandler("onClientRender", getRootElement(), check_hud_func)