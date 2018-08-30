local Aktion = {}

function stopAnims(player)
	setPedAnimation(player)
end
addEvent("onInventarStatusChange", true)
addEventHandler("onInventarStatusChange", getRootElement(),
function(status)
	setElementData(source, "pStatus", status)
	outputChatBox("Du hast dein Status auf "..status.." geaendert!", source, 0, 200, 0)
end)
addEvent("onInventarAction", true)
addEventHandler("onInventarAction", getRootElement(),
function(var)
	if(Aktion[source] == true) then outputChatBox("Du fuehrst gerade eine Aktion durch!", source, 200, 0, 0, false) return end
	if(var == 1) then
		Aktion[source] = true
		local playa = source
		setTimer(function() Aktion[playa] = false end, 4000, 1)
		outputChatBox("Du rollst den Wuerfel...", source, 0, 255, 255, false)
			setTimer(
				function()
				local zahl = math.random(1, 6)
					local posX, posY, posZ = getElementPosition( playa )
					local chatSphere = createColSphere( posX, posY, posZ, 20 )
					local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
					destroyElement( chatSphere )
					for index, nearbyPlayer in ipairs( nearbyPlayers ) do
						local name = getPlayerName ( playa )
						outputChatBox ( "'"..name.." hat eine "..zahl.." gewuerfelt!", nearbyPlayer, 100, 0, 200 )
					end
				
				end, 3000, 1)
	elseif(var == 2) then
		setElementData(source, "pZigaretten", tonumber(getElementData(source, "pZigaretten"))-1)
		setElementHealth(source, getElementHealth(source)+5)
		setPedAnimation(source, "SMOKING", "M_smkstnd_loop", -1, false, true, true)
		bindKey ( source, "space", "down", stopAnims )
			local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." raucht eine Zigarette.", nearbyPlayer, 148, 222, 0 )
		end
	elseif(var == 3) then
		setElementData(source, "pBiere", tonumber(getElementData(source, "pBiere"))-1)
		setElementHealth(source, getElementHealth(source)+5)
		setPedAnimation(source, "food", "EAT_Burger",1,true,false,true)
		bindKey ( source, "space", "down", stopAnims )
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." Trinkt ein Bier.", nearbyPlayer, 148, 222, 0 )
		end
	elseif(var == 4) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." raucht Grass.", nearbyPlayer, 148, 222, 0 )
		end
		addPlayerHealth(source, math.random(5, 10))
	elseif(var == "Erstehilfe") then
		addPlayerHealth(source, 25)
		outputChatBox("Erste-Hilfe Koffer Benutzt!", source, 0, 200, 0)
		removePlayerItem(source, "pErstehilfe", 1)
	elseif(var == "Kanister") then
		local veh = getPedOccupiedVehicle(source)
		if(veh) then
			local fuelable = getElementData(veh, "fuelable")
			if(fuelable == true) then
				local fuel = tonumber(getElementData(veh, "fuel"))
				if(fuel > 85) then setElementData(veh, "fuel", 100)
				else setElementData(veh, "fuel", fuel+15) end
				outputChatBox("Benzinkanister Benutzt!", source, 0, 200, 0)
				removePlayerItem(source, "pKanister", 1)
			else
				outputChatBox("Dieses Fahrzeug kannst du nicht Befuellen!", source, 200, 0, 0)
			end
		else
			outputChatBox("Du sitzt in keinem Fahrzeug!", source, 200, 0, 0)
		end
	end
		
			
end
)

addEvent("onInventarWaffeAbgeb", true)
addEventHandler("onInventarWaffeAbgeb", getRootElement(),
function(id, ammu, object)
	local x, y, z = getElementPosition(source)
	local rand = math.random(0.01, 1.00)
	local lol = createObject ( object, x+rand, y+rand, z-0.9)
	local waffe = createObject ( 1300, x+rand, y+rand, z-1.25)
	setElementRotation(lol, 90, 0, 0)
	setElementData(waffe, "INID", id)
	setElementData(waffe, "INAMMU", ammu)
	setElementData(waffe, "parent", lol)
	setElementAlpha(waffe, 0)
	setElementCollisionsEnabled(waffe, true)
	outputChatBox("Du hast deine Waffe weggeworfen.", source, 0, 200, 0, false)
	takeWeapon(source, id)
		addEventHandler( "onElementClicked",waffe, 
		function(mouse, button, thePlayer)	
			if(mouse == "left") and (button == "down") then
				local id, ammu = tonumber(getElementData(source, "INID")), tonumber(getElementData(source, "INAMMU"))
				destroyElement(getElementData(source, "parent"))
				destroyElement(source)
				giveWeapon(thePlayer, id, ammu, true)
				outputChatBox("Du hast eine Waffe aufgehoben.", thePlayer, 0, 200, 0, false)
			end
		end) 
end)

addEvent("onInventarWaffeMats", true)
addEventHandler("onInventarWaffeMats", getRootElement(),
function(waffe)
	local id = 0
		
	if(waffe == "9mm") then id = getWeaponIDFromName("Colt 45") end
	if(waffe == "deagle") then id = getWeaponIDFromName("Deagle") end
	if(waffe == "schrotflinte") then id = getWeaponIDFromName("Shotgun") end
	if(waffe == "mp5") then id = getWeaponIDFromName("MP5") end
	if(waffe == "ak-47") then id = getWeaponIDFromName("AK-47") end
	if(waffe == "messer") then id = getWeaponIDFromName("Knife") end
	if(waffe == "gewehr") then id = getWeaponIDFromName("Rifle") end
	
			local x, y, z = getElementPosition(source)
			z = z-0.5
			local karton = createObject ( 2912, x, y, z-0.5)
			setElementData(karton, "WID", id)
			setElementData(karton, "WMUNNI", getWeaponSlotMuniMats(id))
			addEventHandler( "onElementClicked",karton, 
			function(mouse, button, thePlayer)	
				if(mouse == "left") and (button == "down") then
					local id = getElementData(source, "WID")
					local munni = getElementData(source, "WMUNNI")
					destroyElement(source)
					giveWeapon(thePlayer, id, munni, true)
					outputChatBox("Du hast die Waffe aufgenommen.", thePlayer, 0, 200, 0, false)
				end
			end) 
end)