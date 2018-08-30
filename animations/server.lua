function stopPlayerAnim(thePlayer)
	setPedAnimation(thePlayer)
	unbindKey(thePlayer, "enter", "down", stopPlayerAnim)
end
addEvent("onAnimationStop", true)
addEventHandler("onAnimationStop", getRootElement(),
function()
	stopPlayerAnim(source)
end)



addEvent("onAnimationStart", true)
addEventHandler("onAnimationStart", getRootElement(),
function(block, aim)
	if(isPedInVehicle(source)) then return end
	setPedAnimation(source, block, aim, -1, true, true, true)
	bindKey(source, "enter", "down", stopPlayerAnim, source)
	outputChatBox("Druecke Enter, um die Animation zu Beenden.", source, 0, 200, 0, false)
	if(aim == "SHP_HandsUp_Scr") then
	local playa = source
	setTimer(
		function()
			setPedAnimation(playa,"shop","SHP_Rob_HandsUp",-1,false)
		end,500,1)
	end
end)

addEvent("onAnimationStartDance", true)
addEventHandler("onAnimationStartDance", getRootElement(),
function(art)
	if(isPedInVehicle(source)) then return end
	if(art == 0) then
		local rnd = math.random ( 1, 4 )
		if rnd == 1 then
			setPedAnimation ( source, "STRIP", "STR_Loop_A",-1,true,false,false )
		elseif rnd == 2 then
			setPedAnimation ( source, "STRIP", "STR_Loop_B",-1,true,false,false )
		elseif rnd == 3 then
			setPedAnimation ( source, "STRIP", "STR_Loop_C",-1,true,false,false )
		else
			setPedAnimation ( source, "STRIP", "STR_Loop_A",-1,true,false,false )
		end
	elseif(art == 1) then
		setPedAnimation ( source, "DANCING", "dnce_M_a",-1,true,false,false )
	elseif(art == 2) then
		setPedAnimation ( source, "DANCING", "dnce_M_b",-1,true,false,false )
	elseif(art == 3) then
		setPedAnimation ( source, "DANCING", "dnce_M_c",-1,true,false,false )
	elseif(art == 4) then
		setPedAnimation ( source, "DANCING", "dnce_M_d",-1,true,false,false )
	elseif(art == 5) then
		setPedAnimation ( source, "DANCING", "dnce_M_c",-1,true,false,false )
	elseif(art == 6) then
		setPedAnimation ( source, "DANCING", "dance_loop",-1,true,false,false )
	end
	bindKey(source, "enter", "down", stopPlayerAnim, source)
	outputChatBox("Druecke Enter, um die Animation zu Beenden.", source, 0, 200, 0, false)
end)

