local Guivar = 0
local HFenster = {}

local commands = {
	[1] = "/fhelp",
	[2] = "/hhelp",
	[3] = "/report",
	[4] = "/rebind",
	[5] = "/invite",
	[6] = "/setcurskin",
	[7] = "/anims",
	[8] = "/handy",
	[9] = "/panel",
	[10] = "/buyprestige",
	[11] = "/sellprestige",
	[12] = "/sellcar [Slot]",
	[13] = "/givecar [Name] [Slot]",
	[14] = "/info",
	[15] = "/objecticons",
}
local commandHelp = {
	["/fhelp"] = "Hilfemenue u. Commands fuer Fraktionen",
	["/hhelp"]= "Hilfemenue u. Commands fuer Kaufbare Haeuser",
	["/rebind"]= "Falls du Verbuggt bist, ist das der Notfall-CMD.",
	["/report"]= "Damit kannst du Kontakt mit einem Admin aufnehmen",
	["/invite"]= "Fuer Leader: Spieler in Fraktion einladen.",
	["/setcurskin"]= "Zurzeitigen Skin als Standart speichern",
	["/anims"]= "Zeigt eine Lister aller Vorhandenen Animationen",
	["/handy"]= "Damit holst du dein Handy raus, falls du eins hast",
	["/panel"]= "Fuer Admins: Oeffnet das Admin Panel",
	["/buyprestige"]= "Ein Objekt kaufen",
	["/sellprestige"]= "Ein Objekt verkaufen",
	["/sellcar [Slot]"] = "Ein Auto im Slot [Slot] verkaufen",
	["/givecar [Name] [Slot]"] = "Ein Auto im Slot [Slot] an [Name] geben",
	["/info"] = "Ruft das User-Menue auf, Wo du Einstellungen bearbeiten kannst",
	["/objecticons"] = "Aktiviert/Deaktiviert die Icons von Dyn. Objekten",
}
function createHelpGuiMenue(var)
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setElementData(gMe, "Clicked", 1)
	
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

	local HTabPanel = {}
	local HTab = {}
	local HKnopf = {}
	local HLabel = {}
	local HBild = {}
	local HGrid = {}

	local X, Y, Width, Height = getMiddleGuiPosition(594,364)
	HFenster[1] = guiCreateWindow(X, Y, Width, Height, "Hilfemenue",false)
	HTabPanel[1] = guiCreateTabPanel(11,24,574,331,false,HFenster[1])
	HTab[1] = guiCreateTab("Hilfemenue",HTabPanel[1])
	HTab[2] = guiCreateTab("FAQ",HTabPanel[1])
	HTab[3] = guiCreateTab("Informationen",HTabPanel[1])
	HTab[4] = guiCreateTab("Quellen",HTabPanel[1])
	HTab[5] = guiCreateTab("Commands", HTabPanel[1])
	HGrid[1] = guiCreateGridList(9,9,556,284,false,HTab[5])
	guiGridListSetSelectionMode(HGrid[1],1)
	
	guiGridListAddColumn(HGrid[1],"Command",0.3)

	guiGridListAddColumn(HGrid[1],"Wert",0.65)
	
	guiGridListClear(HGrid[1])
	for i = 1, #commands, 1 do
		local row = guiGridListAddRow(HGrid[1])
		guiGridListSetItemText(HGrid[1], row, 1, commands[i], false, false)
		guiGridListSetItemText(HGrid[1], row, 2, commandHelp[commands[i]], false, false)
	end
	HBild[1] = guiCreateStaticImage(275,7,282,52,"data/images/logo.png",false,HTab[1])
	HLabel[1] = guiCreateLabel(13,80,553,212,"Willkommen im Butterfly-Reallife Hilfemenue!\nHier findest du Fragen und Antworten, und alle Informationen rund um dem Server.\n\nFalls du fragen hast, kannst du mit /report einen Admin kontaktieren!\n\nAktuelle Ereignisse:(Siehe Schwarzes Brett Blueberry)",false,HTab[1])
	guiSetFont(HLabel[1],"default-bold-small")
	HKnopf[1] = guiCreateButton(12,16,138,34,"Schliessen",false,HTab[1])
	HLabel[2] = guiCreateLabel(8,4,559,294,"Meist gestellte Fragen:\n\nWie kann ich einer Fraktion Beitreten?\nDafuer musst du dich im Forum bewerben. Jede Fraktion hat vorraussetzungen, \ndie du Erfuellen musst.\n\nWie bekomme ich Geld?\nGeld bekommst du, indem du Aktiv Online bist, Jobs erledigst, oder\ngesammelte Sachen verkaufst. Du bekommst auch Geld, wenn du in einer Fraktion bist.\n\nWas kann ich mit Geld machen?\nDu kannst dir mit Geld Lebensmittel, Haeuser, Fahrzeuge, Items und vieles Mehr kaufen.\n\nWas sind diese Haende an vielen Objekten?\nDiese Haende weisen darauf hin, dass dieses Objekt aufgehoben werden kann.\nUm es aufzuheben, halte 'ALT' gedrueckt, und klicke auf das Objekt.\n\nInfo: Du kannst mit Objekten, Spielern, Peds, Objekten und vieles Mehr Interaktieren.",false,HTab[2])
	guiSetFont(HLabel[2],"default-bold-small")
	HLabel[3] = guiCreateLabel(7,6,556,157,"Clanhomepage: ungaming.de\n\nForum: bf.sideboard.eu(Im Aufbau!)\n\nTeamspeak: ungaming.de:1234\n\nServer zurzeit in der Beta-Phase.",false,HTab[3])
	guiSetFont(HLabel[3],"default-bold-small")
	HLabel[4] = guiCreateLabel(7,6,556,157,"Butterfly Reallife gescriptet von MuLTi\nQuellen:\n\nIcons von www.iconfinder.com\n\nSounds von www.Freesound.org\n\nNitro Shader von NeXTreme\nShaders von wiki.multitheftauto.com",false,HTab[4])
	guiSetFont(HLabel[4],"default-bold-small")
	
	addEventHandler("onClientGUIClick", HKnopf[1],
	function()
		Guivar = 0
		destroyElement(HFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end, false)
	if(var == 1) then
		guiSetSelectedTab(HTabPanel[1], hTab[5])
	end
end
addCommandHandler("helpmenue",
function()
	if(isLoggedIn(gMe) == false) then return end
	if(Guivar == 0) then
		createHelpGuiMenue()
	elseif(Guivar == 1) then
		Guivar = 0
		destroyElement(HFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end
end)
addCommandHandler("help",
function()
	if(isLoggedIn(gMe) == false) then return end
	if(Guivar == 0) then
		createHelpGuiMenue(1)
	elseif(Guivar == 1) then
		Guivar = 0
		destroyElement(HFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end
end)
bindKey("F9", "down",
function()
	if(isLoggedIn(gMe) == false) then return end
	if(Guivar == 0) then
		createHelpGuiMenue()
	elseif(Guivar == 1) then
		Guivar = 0
		destroyElement(HFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end
end)