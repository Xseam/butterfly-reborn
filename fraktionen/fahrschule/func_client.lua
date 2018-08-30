local Guivar = 0
local Guivar2 = 0
addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

	local F2Fenster = {}
	local F2Knopf = {}
	local F2Label = {}
	local F2Edit = {}

function createFahrschulTafel(f1, f2, f3, f4, f5, f6, f7)
if(Guivar == 1) then return end
Guivar = 1
showCursor(true)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 500,264
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

local FFenster = guiCreateWindow(X, Y, Width, Height, "Fahrschule",false)
local FLabel = guiCreateLabel(15,28,476,31,"Willkommen an der Fahrschule Werbetafel!\nHier siehst du die Aktuellsten Preise.",false,FFenster)
guiSetFont(FLabel,"default-bold-small")
local FKnopf = guiCreateButton(16,221,80,32,"OK",false,FFenster)
local FGrid = guiCreateGridList(11,61,480,152,false,FFenster)
guiGridListSetSelectionMode(FGrid,1)

guiGridListAddColumn(FGrid,"Schein",0.7)

guiGridListAddColumn(FGrid,"Kosten",0.2)	
	 -- ROWS --
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"Fuehrerschein",false,false)
	guiGridListSetItemText(FGrid,row,2,f1.." $",false,false)
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"LKW - Schein",false,false)
	guiGridListSetItemText(FGrid,row,2,f2.." $",false,false)
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"Helikopterschein",false,false)
	guiGridListSetItemText(FGrid,row,2,f3.." $",false,false)
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"Flugzeugschein",false,false)
	guiGridListSetItemText(FGrid,row,2,f4.." $",false,false)
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"Bootsschein",false,false)
	guiGridListSetItemText(FGrid,row,2,f5.." $",false,false)
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"Angelschein",false,false)
	guiGridListSetItemText(FGrid,row,2,f6.." $",false,false)
	local row = guiGridListAddRow ( FGrid )
	guiGridListSetItemText(FGrid,row,1,"Motorradschein",false,false)
	guiGridListSetItemText(FGrid,row,2,f7.." $",false,false)
	
local FBild = guiCreateStaticImage(9,23,482,232,"data/images/tafel.jpg",false,FFenster)
if(tonumber(getElementData(gMe, "pFraktion")) == 3) and (tonumber(getElementData(gMe, "pFraktionsrang")) > 4) then
local FKnopf2 = guiCreateButton(405,220,80,32,"Bearbeiten",false,FFenster)
	addEventHandler("onClientGUIClick", FKnopf2, 
	function()
	if(Guivar2 == 1) then return end
	Guivar2 = 1
	guiSetInputMode("no_binds_when_editing")
	
		
		local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 332,270
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)


	F2Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Bearbeitung",false)
	F2Label[1] = guiCreateLabel(12,191,105,17,"Angelschein:",false,F2Fenster[1])
	guiSetFont(F2Label[1],"default-bold-small")
	F2Edit[1] = guiCreateEdit(114,186,100,27,f6,false,F2Fenster[1])
	F2Knopf[1] = guiCreateButton(247,187,74,26,"Setzen",false,F2Fenster[1])
	F2Label[2] = guiCreateLabel(221,191,32,16,"$",false,F2Fenster[1])
	guiSetFont(F2Label[2],"default-bold-small")
	F2Knopf[2] = guiCreateButton(248,32,74,26,"Setzen",false,F2Fenster[1])
	F2Label[3] = guiCreateLabel(13,36,105,17,"Fuehrerschein: ",false,F2Fenster[1])
	guiSetFont(F2Label[3],"default-bold-small")
	F2Label[4] = guiCreateLabel(222,36,32,16,"$",false,F2Fenster[1])
	guiSetFont(F2Label[4],"default-bold-small")
	F2Edit[2] = guiCreateEdit(115,31,100,27,f1,false,F2Fenster[1])
	F2Knopf[3] = guiCreateButton(248,64,74,26,"Setzen",false,F2Fenster[1])
	F2Label[5] = guiCreateLabel(13,68,105,17,"LKWSchein:",false,F2Fenster[1])
	guiSetFont(F2Label[5],"default-bold-small")
	F2Label[6] = guiCreateLabel(222,68,32,16,"$",false,F2Fenster[1])
	guiSetFont(F2Label[6],"default-bold-small")
	F2Edit[3] = guiCreateEdit(115,63,100,27,f2,false,F2Fenster[1])
	F2Knopf[4] = guiCreateButton(248,94,74,26,"Setzen",false,F2Fenster[1])
	F2Label[7] = guiCreateLabel(13,98,105,17,"Helischein:",false,F2Fenster[1])
	guiSetFont(F2Label[7],"default-bold-small")
	F2Label[8] = guiCreateLabel(222,98,32,16,"$",false,F2Fenster[1])
	guiSetFont(F2Label[8],"default-bold-small")
	F2Edit[4] = guiCreateEdit(115,93,100,27, f3,false,F2Fenster[1])
	F2Knopf[5] = guiCreateButton(248,125,74,26,"Setzen",false,F2Fenster[1])
	F2Label[9] = guiCreateLabel(13,129,105,17,"Flugschein:",false,F2Fenster[1])
	guiSetFont(F2Label[9],"default-bold-small")
	F2Label[10] = guiCreateLabel(222,129,32,16,"$",false,F2Fenster[1])
	guiSetFont(F2Label[10],"default-bold-small")
	F2Edit[5] = guiCreateEdit(115,124,100,27,f4,false,F2Fenster[1])
	F2Knopf[6] = guiCreateButton(248,158,74,26,"Setzen",false,F2Fenster[1])
	F2Label[11] = guiCreateLabel(13,162,105,17,"Bootsschein:",false,F2Fenster[1])
	guiSetFont(F2Label[11],"default-bold-small")
	F2Label[12] = guiCreateLabel(222,162,32,16,"$",false,F2Fenster[1])
	guiSetFont(F2Label[12],"default-bold-small")
	F2Edit[6] = guiCreateEdit(115,157,100,27,f5,false,F2Fenster[1])
	F2Knopf[7] = guiCreateButton(109,233,108,29,"OK",false,F2Fenster[1])

	addEventHandler("onClientGUIClick", F2Knopf[1], -- Angel
	function()
	local text = tonumber(guiGetText(F2Edit[1]))
	if(text == nil) then return end
	if(text < 50) then return end
	triggerServerEvent("onFahrschulPreisAender", gMe, 6, text)
	end, false)
	
	addEventHandler("onClientGUIClick", F2Knopf[6], -- Boots
	function()
	local text = tonumber(guiGetText(F2Edit[6]))
	if(text == nil) then return end
	if(text < 50) then return end
	triggerServerEvent("onFahrschulPreisAender", gMe, 5, text)
	end, false)
	
	addEventHandler("onClientGUIClick", F2Knopf[5], -- Flug
	function()
	local text = tonumber(guiGetText(F2Edit[5]))
	if(text == nil) then return end
	if(text < 50) then return end
	triggerServerEvent("onFahrschulPreisAender", gMe, 4, text)
	end, false)
	
	addEventHandler("onClientGUIClick", F2Knopf[4], -- Heli
	function()
	local text = tonumber(guiGetText(F2Edit[4]))
	if(text == nil) then return end
	if(text < 50) then return end
	triggerServerEvent("onFahrschulPreisAender", gMe, 3, text)
	end, false)
	
	addEventHandler("onClientGUIClick", F2Knopf[3], -- LKW Schein
	function()
	local text = tonumber(guiGetText(F2Edit[3]))
	if(text == nil) then return end
	if(text < 50) then return end
	triggerServerEvent("onFahrschulPreisAender", gMe, 2, text)
	end, false)
	
	addEventHandler("onClientGUIClick", F2Knopf[2], -- FS SChein
	function()
	local text = tonumber(guiGetText(F2Edit[2]))
	if(text == nil) then return end
	if(text < 50) then return end
	triggerServerEvent("onFahrschulPreisAender", gMe, 1, text)
	end, false)
	
	addEventHandler("onClientGUIClick", F2Knopf[7],
	function()
	Guivar2 = 0
	destroyElement(F2Fenster[1])
	end, false)
	end, false)
end

guiMoveToBack(FBild)
guiSetAlpha(FBild, 0.5)
addEventHandler("onClientGUIClick", FBild, function() guiMoveToBack(FBild) end, false)

addEventHandler("onClientGUIClick", FKnopf, 
function()
if(Guivar2 == 1) then return end
destroyElement(FFenster)
Guivar = 0
showCursor(false)
setElementData(gMe, "Clicked", 0)
end, false)

end



addEvent("onFahrschulTafelClick", true)
addEventHandler("onFahrschulTafelClick", getRootElement(),
function(f1, f2, f3, f4, f5, f6, f7)
if not(source == gMe) then return end
createFahrschulTafel(f1, f2, f3, f4, f5, f6, f7)
end)

