createPickup(1242.3405761719, 328.13677978516, 19.7555103302, 3, 1240)
local healthcorona = createMarker(1242.3405761719, 328.13677978516, 19.7555103302, "corona", 1.0, 255, 0, 0, 0)
local x,y = guiGetScreenSize()

local kHausguivar = 0
function createKrankenhausMenue()
	if(kHausguivar == 1) then return end
	
	kHausguivar = 1
	showCursor(true)
	
	local leben = getElementHealth(gMe)
	local dauer = (math.ceil(100-leben)/2)
	local kFenster = guiCreateWindow(x/2-183.5,y/2-56,367,112,"Krankenhaus",false)
	local kLabel1 = guiCreateLabel(13,26,321,56,"Willkommen beim Crippen Memorial Krankenhaus!\n\nDu kannst dich hier Heilen lassen.\nDauer: "..dauer.." Sekunden.",false,kFenster)
	guiLabelSetColor(kLabel1,200, 255, 255)
	guiSetFont(kLabel1,"default-bold-small")

	local kosten = (math.ceil(100-leben*1.6)+25)
	local kLabel2 = guiCreateLabel(15,88,221,17,"Kosten: "..kosten.." $",false,kFenster)
	guiLabelSetColor(kLabel2,255, 255, 0)
	guiSetFont(kLabel2,"default-bold-small")
	local kKnopf1 = guiCreateButton(152,90,121,13,"Heilung Beantragen",false,kFenster)
	local kLabel3 = guiCreateLabel(11,74,221,17,"__________________",false,kFenster)
	guiLabelSetColor(kLabel3,255,255,0)
	guiSetFont(kLabel3,"default-bold-small")
	local kKnopf2 = guiCreateButton(277,90,81,13,"Abbrechen",false,kFenster)	
	if(leben > 90) then
	guiSetText(kLabel1, "Willkommen beim Crippen Memorial Krankenhaus!\n\nDu bist kerngesund!\nKomm wann anderst wieder.")
	guiSetText(kLabel2, "Kosten: N/A $")
	end
	addEventHandler("onClientGUIClick", kKnopf1,
	function()
		if(leben > 90) then outputChatBox("Du brauchst nicht geheilt zu werden!", 255, 0, 0, false) return end
		local geld = getPlayerMoney()
		if(geld < kosten+1) then outputChatBox("Du hast nicht genug Geld dafuer!", 255, 0, 0, false) return end
		givePlayerMoney(-kosten)
		guiSetVisible(kFenster, false)
		kHausguivar = 0
		showCursor(false)
		toggleAllControls ( false )
		outputChatBox("Du wirst nun geheilt.", 0, 255, 0, false)
		fadeCamera(false, 1.0, 255, 255, 255)
		setPlayerHudComponentVisible ( "all", false )
		setTimer(
			function()
			setElementHealth(gMe, 100)
			outputChatBox("Vielen Dank fuer ihr Besuch! Sie wurden geheilt.", 0, 255, 0, false)
			fadeCamera(true, 1.0, 255, 255, 255)
			triggerEvent("showRightHud", gMe)
			toggleAllControls ( true )
			end, dauer*1000, 1)
	end, false)
	addEventHandler("onClientGUIClick", kKnopf2,
	function()
		guiSetVisible(kFenster, false)
		kHausguivar = 0
		showCursor(false)
	end, false)
end

addEventHandler("onClientMarkerHit", healthcorona, 
function(hitElement)
	if not(hitElement == getLocalPlayer()) then return end
	createKrankenhausMenue()
end)