local Guivar = 0
addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

local ADPreis = 50

function createADGui()
if(Guivar == 1) then return end
Guivar = 1
guiSetInputMode("no_binds_when_editing")

showCursor(true)
setElementData(gMe, "Clicked", 1)
local ADFenster = {}
local ADKnopf = {}
local ADCheckbox = {}
local ADLabel = {}
local ADEdit = {}

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 520,194
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

ADFenster[1] = guiCreateWindow(X, Y, Width, Height, "Werbung",false)
ADLabel[1] = guiCreateLabel(15,22,242,21,"Hier kannst du deine Werbung angeben.",false,ADFenster[1])
guiSetFont(ADLabel[1],"default-bold-small")
ADLabel[2] = guiCreateLabel(9,41,86,18,"Kosten: "..ADPreis.."$.",false,ADFenster[1])
guiLabelSetColor(ADLabel[2],255, 100, 100)
guiSetFont(ADLabel[2],"default-bold-small")
ADLabel[3] = guiCreateLabel(26,92,76,16,"Ich verkaufe:",false,ADFenster[1])
guiSetFont(ADLabel[3],"default-bold-small")
ADEdit[1] = guiCreateEdit(20,110,134,28,"",false,ADFenster[1]) -- Ich Verkaufe
ADLabel[4] = guiCreateLabel(165,92,76,16,"Wo:(Option.)",false,ADFenster[1])
guiSetFont(ADLabel[4],"default-bold-small")
ADEdit[2] = guiCreateEdit(159,111,134,28,"",false,ADFenster[1]) -- Wo
ADLabel[5] = guiCreateLabel(300,92,76,16,"Anzahl:",false,ADFenster[1])
guiSetFont(ADLabel[5],"default-bold-small")
ADEdit[3] = guiCreateEdit(298,110,53,28,"",false,ADFenster[1])
ADLabel[6] = guiCreateLabel(361,93,76,16,"Preis:",false,ADFenster[1])
guiSetFont(ADLabel[6],"default-bold-small")
ADEdit[4] = guiCreateEdit(355,110,134,28,"",false,ADFenster[1]) -- Preis
ADEdit[5] = guiCreateEdit(160,142,332,29,"",false,ADFenster[1]) -- Manuell
ADCheckbox[1] = guiCreateCheckBox(21,145,136,24,"Manuell: ",false,false,ADFenster[1])
ADKnopf[1] = guiCreateButton(318,23,97,28,"Werbung veroeffentlichen",false,ADFenster[1])
ADKnopf[2] = guiCreateButton(419,24,92,28,"Abbrechen",false,ADFenster[1])
ADLabel[7] = guiCreateLabel(16,68,487,15,"________________________________________________________________________________________________________________",false,ADFenster[1])
guiLabelSetColor(ADLabel[7],255, 255, 255)
guiSetFont(ADLabel[7],"default-bold-small")
guiWindowSetSizable(ADFenster[1], false)
	addEventHandler("onClientGUIClick", ADKnopf[1], 
	function()
		local geld = getPlayerMoney(gMe)
		if(geld < ADPreis+1) then infolabel_func("Du hast nicht so Viel Geld!\nDu braucht "..ADPreis.." $!", 255, 0, 0, 3000) return end
		local text1 = guiGetText(ADEdit[1])
		local text2 = guiGetText(ADEdit[2])
		local text3 = guiGetText(ADEdit[3])
		local text4 = guiGetText(ADEdit[4])
		local text5 = guiGetText(ADEdit[5])
		local checkbox = guiCheckBoxGetSelected(ADCheckbox[1])
		if(checkbox == true) then
		if(text5 == " ") or (text5 == "") then infolabel_func("Ungueltige\nEingabe!", 255, 0, 0, 3000) return end
			if(string.len(text5) > 64) then infolabel_func("Ungueltige\nEingabe!", 255, 0, 0, 3000) return end
		else
		if(text1 == " ") or (text1 == "") then infolabel_func("Ungueltige\nEingabe!", 255, 0, 0, 3000) return end
		if(text2 == " ") or (text2 == "") then text2 = "N/A" end
		if(text3 == " ") or (text3 == "") then infolabel_func("Ungueltige\nEingabe!", 255, 0, 0, 3000) return end
		if(text4 == " ") or (text4 == "") then infolabel_func("Ungueltige\nEingabe!", 255, 0, 0, 3000) return end
		end
		local text = "N/A"
		text = "#00FF40Verkaufe #00FF5E"..text3..". #00FF5E"..text1.." #00FF40in/am #00FF5E"..text2.." #00FF40fuer #00FF5E"..text4.."" 
		if(checkbox) then
			text = "#00FF40"..text5
		end
		setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-ADPreis)
		triggerServerEvent("onADAbschick", gMe, text)
		--
		Guivar = 0
		destroyElement(ADFenster[1])
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end, false)
	
	addEventHandler("onClientGUIClick", ADKnopf[2], 
	function()
		Guivar = 0
		destroyElement(ADFenster[1])
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end, false)

end

addCommandHandler("ad", createADGui)