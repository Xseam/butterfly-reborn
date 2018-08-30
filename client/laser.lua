function check_for_laser(thePlayer)
	if(IsPlayerWeaponValidForLaser(thePlayer) == true) then
		if(isPedInVehicle(thePlayer) == false) then
			if(isPlayerAiming(thePlayer) == true) then
				local weapon = getPedWeapon(thePlayer)
				local x1, y1, z1 = getPedWeaponMuzzlePosition (  thePlayer )
				local x2, y2, z2 = getPedTargetEnd( thePlayer )
				dxDrawLine3D(x1, y1, z1, x2, y2, z2, tocolor( 255, 0, 0), 1)
			end
		end
	end
end

addEventHandler("onClientRender", getRootElement(), 
function()
	for index, player in pairs(getElementsByType("player")) do
		if(getElementData(player, "pLaser.on") == true) then
			check_for_laser(player)
		end
	end
end )

function IsPlayerWeaponValidForLaser(thePlayer)
	local weapon = getPedWeapon(thePlayer)
	if(weapon == 0) then return false end
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

function isPlayerAiming(thePlayer)
	local stat = getPedControlState(thePlayer, "aim_weapon")
	local stat2 = getPedControlState(thePlayer, "sprint")
	if(stat ~= false) and (stat2 == false)then return true end
	return false
end

addCommandHandler("setlaser", 
function(cmd)
	local state = getElementData(gMe, "pLaser.on")
	if(state ~= true) then
		setElementData(gMe, "pLaser.on", true)
		outputChatBox("Laser wurde angeschaltet!", 0, 200, 0, false)
	else
		setElementData(gMe, "pLaser.on", false)
		outputChatBox("Laser wurde ausgeschaltet,", 0, 200, 0, false)
	end
end)