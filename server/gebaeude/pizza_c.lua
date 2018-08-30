local pizzaMarker = createMarker(376.71002197266, -118.97424316406, 1001.4995117188, "corona", 1.0, 255, 255, 255, 255) setElementInterior(pizzaMarker, 5)
local ped1 = createPed(155, 373.9296875, -117.27885437012, 1001.4995117188) setElementInterior(ped1, 5)
setElementRotation(ped1, -0, 0, 180)
setElementHealth(ped1, 1000)
setElementFrozen(ped1, true)

local ped2 = createPed(155, 376.69906616211, -117.27862548828, 1001.4921875) setElementInterior(ped2, 5)
setElementRotation(ped2, -0, 0, 180)
setElementHealth(ped2, 1000)
setElementFrozen(ped2, true)


addEventHandler("onClientPedDamage", getRootElement(),
function()
	if(source == ped1) or (source == ped2) then
		setElementHealth(source, 1000)
	end
end)

local Guivar = 0
addEventHandler("onClientPreRender", getRootElement(),
function()
	if(Guivar == 1) then showCursor(true) end
end)

local pizzaLeben = {
	["Pizza Margherita"] = 5,
	["Pizza Salami"] = 10,
	["Pizza 4 Kaese"] = 14,
	["Pizza Schinken"] = 19,
	["Pizza Hawaii"] = 21,
	["Pizza a la Serva"] = 25,
	["Familienpizza"] = 40,
}

local pizzaPreise = {
	["Pizza Margherita"] = 20,
	["Pizza Salami"] = 25,
	["Pizza 4 Kaese"] = 27,
	["Pizza Schinken"] = 30,
	["Pizza Hawaii"] = 32,
	["Pizza a la Serva"] = 35,
	["Familienpizza"] = 47,
}
function createPizzaMenue()
if (Guivar == 1) then return end
	Guivar = 1
	showCursor(true)

	local Pizzafenster = {}
	local Pizzaknopf = {}
	local Pizzalabel = {}
	local Pizzagrid = {}
	local Pizzabild = {}
	
	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 539,468
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

	Pizzafenster[1] = guiCreateWindow(X, Y, Width, Height,"Pizza",false)
	Pizzabild[1] = guiCreateStaticImage(10,26,515,158,"data/images/pizza/logo.png",false,Pizzafenster[1])
	Pizzalabel[1] = guiCreateLabel(25,199,359,41,"Herzlich Willkommen bei The Well Stacked Pizza Co!\nWas koennen wir fuer sie tuen?",false,Pizzafenster[1])
	guiSetFont(Pizzalabel[1],"default-bold-small")
	Pizzaknopf[1] = guiCreateButton(32,423,110,36,"Bestellen",false,Pizzafenster[1])
	Pizzaknopf[2] = guiCreateButton(151,424,110,35,"Abbrechen",false,Pizzafenster[1])
	Pizzagrid[1] = guiCreateGridList(15,237,514,180,false,Pizzafenster[1])
	guiGridListSetSelectionMode(Pizzagrid[1],1)

	guiGridListAddColumn(Pizzagrid[1],"Pizza",0.5)

	guiGridListAddColumn(Pizzagrid[1],"Mit extra Kaese",0.2)

	guiGridListAddColumn(Pizzagrid[1],"Preis",0.15)

	guiGridListAddColumn(Pizzagrid[1],"Anzahl",0.1)

	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Pizza Margherita",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Ja",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"20 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)

	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Pizza Salami",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Nein",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"25 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)	
	
	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Pizza 4 Kaese",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Ja",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"27 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)	

	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Pizza Schinken",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Nein",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"30 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)	

	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Pizza Hawaii",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Ja",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"32 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)	

	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Pizza a la Serva",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Ja",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"35 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)	

	local row = guiGridListAddRow ( Pizzagrid[1] )
	guiGridListSetItemText(Pizzagrid[1],row,1,"Familienpizza",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,2,"Ja",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,3,"47 $",false,false)
	guiGridListSetItemText(Pizzagrid[1],row,4,"1 Stk.",false,false)	

	addEventHandler("onClientGUIClick", Pizzaknopf[1],
	function()
		local pizza = guiGridListGetItemText (Pizzagrid[1], guiGridListGetSelectedItem ( Pizzagrid[1] ), 1 )
		if(pizza == " ") or (pizza == "") then outputChatBox("Du musst eine Pizza auswaehlen, und dann auf Bestellen klicken!", 255, 0, 0, false) return end
		local preis = (pizzaPreise[pizza]+1)
		if(getPlayerMoney(gMe) < preis) then outputChatBox("Du kannst dir diese Pizza nicht Leisten.", 255, 0, 0, false) return end
		guiSetVisible(Pizzafenster[1], false)
		Guivar = 0
		showCursor(false)
		toggleAllControls(false)
		fadeCamera(false, 2.0, 255, 255, 255)
		setTimer(
		function()
			fadeCamera(true, 2.0, 255, 255, 255)
			setElementHealth(gMe, (getElementHealth(gMe)+pizzaLeben[pizza]))
			outputChatBox("Vielen Dank fuer ihren Einkauf!", 0, 255, 0, false)
			toggleAllControls(true)
			givePlayerMoney(-(preis+1))
			--aktualisiereMoney()
			setPedAnimation(gMe, "food", "EAT_Burger",1,true,false,true)
			addHunger(10)
		end, 3000, 1)
	end, false)
	
	addEventHandler("onClientGUIClick", Pizzaknopf[2],
	function()
		guiSetVisible(Pizzafenster[1], false)
		Guivar = 0
		showCursor(false)
	end, false)

end

addEventHandler("onClientMarkerHit", pizzaMarker,
function(hitElement)
	if (hitElement ~= gMe) then return end
		createPizzaMenue()
end)