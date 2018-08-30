local Ped = createPed(240, 43.628520965576, -2134.7749023438, 4.8090624809265)
local Marker = createMarker(41.496097564697, -2133.6052246094, 4.8090624809265, "corona", 1.0, 0, 255, 0, 200)
setPedRotation(Ped, 43)
local Keepervar = 0
setTimer(
function()
	if(Keepervar == 0) then
	Keepervar = 1
	setPedAnimation( Ped, "ped", "WALK_civi", -1, true, true, false)
	setPedRotation(Ped, 0)
	elseif(Keepervar == 1) then
	Keepervar = 2
	setPedAnimation( Ped )
	setPedRotation(Ped, 90)
	elseif(Keepervar == 2) then
	setPedAnimation( Ped, "ped", "WALK_civi", -1, true, true, false)
	Keepervar = 3
	setPedRotation(Ped, 180)
	elseif(Keepervar == 3) then
	Keepervar = 0
	setPedAnimation( Ped )
	setPedRotation(Ped, 90)
	setElementPosition(Ped, 43.628520965576, -2134.7749023438, 4.8090624809265)
	end
end, 3000, 0)

addEventHandler("onClientPedDamage", getRootElement(),
function()
	if(source == Ped) then cancelEvent() end
end)

local Guivar = 0

addEventHandler("onClientPreRender", getRootElement(),
function()
if(Guivar == 1) then showCursor(true) end
end)
local saufenLeben = {
	["Bier"] = 5,
	["Wodka"] = 10,
	["Sekt"] = 5,
	["Wein"] = 5,
	["Bacardi"] = 20, 
	["TNT-Bacardi"] = 50, 
	["Whiskey"] = 20,
}


local saufenPreis = {
	["Bier"] = 2,
	["Wodka"] = 10,
	["Sekt"] = 5,
	["Wein"] = 8,
	["Bacardi"] = 15, 
	["TNT-Bacardi"] = 50, 
	["Whiskey"] = 20,
}


function createSaufenRennenMenue()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)

	local Saufenfenster = {}
	local Saufenknopf = {}
	local Saufencheckbox = {}
	local Saufenlabel = {}
	local Saufengrid = {}
	
		local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 484,239
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

	Saufenfenster[1] = guiCreateWindow(X, Y, Width, Height,"Bar",false)
	Saufenlabel[1] = guiCreateLabel(10,27,256,19,"Willkommen an der Bar! Was darf's sein?",false,Saufenfenster[1])
	guiSetFont(Saufenlabel[1],"default-bold-small")
	Saufengrid[1] = guiCreateGridList(9,53,346,177,false,Saufenfenster[1])
	guiGridListSetSelectionMode(Saufengrid[1],1)

	guiGridListAddColumn(Saufengrid[1],"Getraenk",0.4)

	guiGridListAddColumn(Saufengrid[1],"Kosten",0.3)

	guiGridListAddColumn(Saufengrid[1],"Anzahl",0.2)


	Saufencheckbox[1] = guiCreateCheckBox(377,64,98,32,"Eiswuerfel",false,false,Saufenfenster[1])
	Saufencheckbox[2] = guiCreateCheckBox(377,87,98,32,"Strohhalm",false,false,Saufenfenster[1])
	Saufencheckbox[3] = guiCreateCheckBox(377,109,98,32,"Trinkgeld",false,false,Saufenfenster[1])
	Saufenknopf[1] = guiCreateButton(367,146,107,31,"Saufen",false,Saufenfenster[1])
	Saufenknopf[2] = guiCreateButton(366,187,107,31,"Abbrechen",false,Saufenfenster[1])
	
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"Bier",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"2 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"Wodka",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"10 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"Sekt",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"5 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"Wein",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"8 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"Bacardi",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"15 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"TNT-Bacardi",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"50 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	local row = guiGridListAddRow ( Saufengrid[1] )
	guiGridListSetItemText(Saufengrid[1],row,1,"Whiskey",false,false)
	guiGridListSetItemText(Saufengrid[1],row,2,"20 $",false,false)
	guiGridListSetItemText(Saufengrid[1],row,3,"1 Stk.",false,false)
	
	addEventHandler("onClientGUIClick", Saufenknopf[2],
	function()
		guiSetVisible(Saufenfenster[1], false)
		Guivar = 0
		showCursor(false)
	end, false)

		addEventHandler("onClientGUIClick", Saufenknopf[1],
	function()
		local drink = guiGridListGetItemText (Saufengrid[1], guiGridListGetSelectedItem ( Saufengrid[1] ), 1 )
		if(drink == " ") or (drink == "") then outputChatBox("Du musst ein Drink auswaehlen, und dann auf Bestellen klicken!", 255, 0, 0, false) return end
		local preis = (saufenPreis[drink]+1)
		if(getPlayerMoney(gMe) < preis) then outputChatBox("Du kannst dir dieses Alkoholgetraenk nicht Leisten.", 255, 0, 0, false) return end
		guiSetVisible(Saufenfenster[1], false)
		Guivar = 0
		showCursor(false)
		toggleAllControls(false)
		fadeCamera(false, 2.0, 255, 255, 255)
		setTimer(
		function()
			fadeCamera(true, 2.0, 255, 255, 255)
			setElementHealth(gMe, (getElementHealth(gMe)+saufenLeben[drink]))
			toggleAllControls(true)
			givePlayerMoney(-(preis+1))
			--aktualisiereMoney()
			setPedAnimation(gMe, "food", "EAT_Burger",1,true,false,true)
			addHunger(5+math.random(0,5))
		end, 3000, 1)
	end, false)
end


addEventHandler("onClientMarkerHit", Marker,
function(hitElement)
	if(hitElement ~= gMe) then return end
	createSaufenRennenMenue()
end)