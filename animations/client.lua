local animTable = {
	[1] = "handsup",
	[2] = "drunk",
	[3] = "bomb",
	[4] = "robman",
	[5] = "getarrested",
	[6] = "laught",
	[7] = "lookout",
	[8] = "crossarms",
	[9] = "lay",
	[10] = "hide",
	[11] = "vomit",
	[12] = "wave",
	[13] = "slapass",
	[14] = "deal",
	[15] = "crack",
	[16] = "ground",
	[17] = "fucku",
	[18] = "chat",
	[19] = "taichi",
	[20] = "chairsit",
	[21] = "piss",
	[22] = "wank",
	[23] = "dance"
}

local animThings = {
	["handsup"] = "shop,SHP_HandsUp_Scr",
	["drunk"] = "ped,WALK_drunk",
	["bomb"] = "bomber,BOM_Plant_In",
	["robman"] = "shop,ROB_Loop_Threat",
	["getarrested"] = "ped,ARRESTgun",
	["laught"] = "rapping,Laugh_01",
	["lookout"] = "shop,ROB_Shifty",
	["crossarms"] = "cop_ambient,Coplook_loop",
	["lay"] = "beach,bather",
	["hide"] = "ped,cower",
	["vomit"] = "food,EAT_Vomit_P",
	["wave"] = "ON_LOOKERS,wave_loop",
	["slapass"] = "sweet,sweet_ass_slap",
	["deal"] = "dealer,dealer_deal",
	["crack"] = "crack,crckdeth2",
	["ground"] = "beach,ParkSit_M_loop",
	["fucku"] = "ped,fucku",
	["chat"] = "ped,IDLE_chat",
	["taichi"] = "park,Tai_Chi_Loop",
	["chairsit"] = "BEACH,SitnWait_loop_W",
	["piss"] = "PAULNMAC,Piss_loop",
	["wank"] = "PAULNMAC,wank_loop"
}
-- Alle Commands
for i = 1, #animTable, 1 do
	addCommandHandler(animTable[i], function(cmd, typ)
		
			if(animTable[i] == "dance") then
				local art = tonumber(typ)
				if not(art) then art = 0 --[[outputChatBox("Fehlerhafte Tanzart!", 200, 0, 0)]] end
				if(art < 0) or (art > 6) then outputChatBox("Deine Tanzart darf nicht unter 0 und ueber 6 Sein!", 200, 0, 0) return end
				triggerServerEvent("onAnimationStartDance", gMe, art)
			else
				local block, aim = gettok(animThings[animTable[i]], 1, ","), gettok(animThings[animTable[i]], 2, ",")
				if(block) and (aim) then
					triggerServerEvent("onAnimationStart", gMe, block, aim)
				else
					
					outputChatBox("Fehler!", 200, 0, 0, false)
				end
			end
	end)
end

local Guivar = 0
local AFenster = {}
local timer


function createAnimGui()
	if(Guivar == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	showCursor(true)
	timer = setTimer(function() if(Guivar == 1) then showCursor(true) end end, 50, 0)

	local AKnopf = {}
	local ALabel = {}
	local AEdit = {}
	local AGrid = {}
	
	local X, Y, Width, Height = getMiddleGuiPosition(244,271)
	AFenster[1] = guiCreateWindow(X, Y, Width, Height,"Animations",false)
	AGrid[1] = guiCreateGridList(9,24,131,236,false,AFenster[1])
	guiGridListSetSelectionMode(AGrid[1],1)

	guiGridListAddColumn(AGrid[1],"Animationsname",0.6)
	AKnopf[1] = guiCreateButton(146,43,86,28,"Animation Starten",false,AFenster[1])
	AKnopf[2] = guiCreateButton(146,123,85,28,"Animation Stoppen",false,AFenster[1])
	ALabel[1] = guiCreateLabel(149,75,69,18,"Tanzart:",false,AFenster[1])
	guiSetFont(ALabel[1],"default-bold-small")
	AEdit[1] = guiCreateEdit(149,93,77,22,"",false,AFenster[1])
	guiEditSetMaxLength(AEdit[1],1)
	AKnopf[3] = guiCreateButton(142,225,85,28,"Schliessen",false,AFenster[1])
	local function loadList()
		for i = 1,  #animTable, 1 do
			local row = guiGridListAddRow(AGrid[1])
			guiGridListSetItemText(AGrid[1], row, 1, animTable[i], false, false)
		end
	end
	
	loadList()
	addEventHandler("onClientGUIClick", AKnopf[1],
	function()
		local item = guiGridListGetItemText(AGrid[1], guiGridListGetSelectedItem(AGrid[1]), 1, false, false)
		if(item == "") or (item == " ") then outputChatBox("Du musst eine Animation auswaehlen!", 200, 0, 0, false) return end
		destroyElement(AFenster[1])
		Guivar = 0
		killTimer(timer)
		showCursor(false)
		if(item == "dance") then
			local art = tonumber(guiGetText(AEdit[1]))
			if not(art) then art = 0 --[[outputChatBox("Fehlerhafte Tanzart!", 200, 0, 0)]] end
			if(art < 0) or (art > 6) then outputChatBox("Deine Tanzart darf nicht unter 0 und ueber 6 Sein!", 200, 0, 0) return end
			triggerServerEvent("onAnimationStartDance", gMe, art)
		else
			local block, aim = gettok(animThings[item], 1, ","), gettok(animThings[item], 2, ",")
			if(block) and (aim) then
				triggerServerEvent("onAnimationStart", gMe, block, aim)
			else
				outputChatBox("Fehler!", 200, 0, 0, false)
			end
		end

	end, false)
	addEventHandler("onClientGUIClick", AKnopf[2],
	function()
		destroyElement(AFenster[1])
		Guivar = 0
		killTimer(timer)
		showCursor(false)
		triggerServerEvent("onAnimationStop", gMe)
	end, false)
	addEventHandler("onClientGUIClick", AKnopf[3],
	function()
		destroyElement(AFenster[1])
		Guivar = 0
		killTimer(timer)
		showCursor(false)
	end, false)
	
end

addCommandHandler("anims",
function()
	if(Guivar == 0) then
		createAnimGui()
	elseif(Guivar == 1) then
		destroyElement(AFenster[1])
		Guivar = 0
		killTimer(timer)
		showCursor(false)
	end
end)
