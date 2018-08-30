--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

function erstelleInfoBox()
	giLabel = guiCreateLabel(0.3661,0,0.2464,0.075,"Information:",true)
	guiLabelSetHorizontalAlign(giLabel,"center",false)
	guiSetFont(giLabel,"default-bold-small")
	giBild = guiCreateStaticImage(0.3656,0,0.2474,0.0583,"data/images/dot_schwarz.png",true)
	guiMoveToBack(giBild)
	guiSetVisible(giLabel, false)
	guiSetVisible(giBild, false)
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		erstelleInfoBox()
	end
)
function infolabel_func(text, color1, color2, color3, timetoshow)
	if not(source) then
		if not(timetoshow) then timetoshow = 3000 end
		guiSetText(giLabel, text)
		guiLabelSetColor(giLabel, color1, color2, color3)
		guiSetVisible(giLabel, true)
		guiSetVisible(giBild, true)
		
		setTimer(guiSetVisible, timetoshow, 1, giLabel, false)
		setTimer(guiSetVisible, timetoshow, 1, giBild, false)
		playSound("sounds/use.wav", false)
	else
		if not(source == gMe) then
			if not(timetoshow) then timetoshow = 3000 end
			guiSetText(giLabel, text)
			guiLabelSetColor(giLabel, color1, color2, color3)
			guiSetVisible(giLabel, true)
			guiSetVisible(giBild, true)
			
			setTimer(guiSetVisible, timetoshow, 1, giLabel, false)
			setTimer(guiSetVisible, timetoshow, 1, giBild, false)
			playSound("sounds/use.wav", false)
		end
	end
end
addEvent("infolabel_starten", true)
addEventHandler("infolabel_starten", getRootElement(), infolabel_func)

function infolabel_func_server(text, color1, color2, color3, timetoshow)

	if not(timetoshow) then timetoshow = 3000 end
	guiSetText(giLabel, text)
	guiLabelSetColor(giLabel, color1, color2, color3)
	guiSetVisible(giLabel, true)
	guiSetVisible(giBild, true)
		
	setTimer(guiSetVisible, timetoshow, 1, giLabel, false)
	setTimer(guiSetVisible, timetoshow, 1, giBild, false)
	playSound("sounds/use.wav", false)
	
end
addEvent("infolabel_starten_server", true)
addEventHandler("infolabel_starten_server", getRootElement(), infolabel_func_server)
