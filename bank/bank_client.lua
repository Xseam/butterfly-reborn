--[[ 

	|===================|
	|Script bei MuLTi&  |
	|SK_Styla! [C]!     |
	|===================|

	He, Du!
	Falls du was hiervon haben moechtest,
	Frage die Person, die das gemacht hat!(MuLTi)
	Kopieren und Einfuegen ist Scheisse.

 --]]

local Guivar = 0

local BankTFenster = {}
local BankTTabPanel = {}
local BankTTab = {}
local BankTKnopf = {}
local BankTMemo = {}
local BankTCheckbox = {}
local BankTLabel = {}
local BankTEdit = {}
	
addEventHandler("onClientRender", getRootElement(),
function()
	if(Guivar == 1) then showCursor(true) end
end)

local hasMeKonto = 0

function createBankTerminal(data)
	if(Guivar == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	if(data == "Stadt") then setElementData(gMe, "ATMVAR", "Stadt") else setElementData(gMe, "ATMVAR", nil) end
	local X, Y, Width, Height = getMiddleGuiPosition(465,245)


	BankTFenster[1] = guiCreateWindow(X, Y, Width, Height, "Bank",false)
	BankTLabel[1] = guiCreateLabel(14,25,297,34,"Geldschalter "..data..".\n_____________________________________",false,BankTFenster[1])
	guiSetFont(BankTLabel[1],"default-bold-small")
	BankTTabPanel[1] = guiCreateTabPanel(11,59,445,177,false,BankTFenster[1])

	-- TAB KONTO --

	BankTTab[6] = guiCreateTab("Konto",BankTTabPanel[1])

	BankTEdit[6] = guiCreateEdit(50,97,60,23,"",false,BankTTab[6])
	guiEditSetMasked(BankTEdit[6], true)
	BankTLabel[12] = guiCreateLabel(12,74,128,16,"4 - Stelliger PIN Code:",false,BankTTab[6])
	guiSetFont(BankTLabel[12],"default-bold-small")
	BankTEdit[7] = guiCreateEdit(164,96,60,23,"",false,BankTTab[6])
	guiEditSetMasked(BankTEdit[7], true)
	BankTLabel[13] = guiCreateLabel(144,74,137,17,"Bestaetigung:",false,BankTTab[6])
	guiSetFont(BankTLabel[13],"default-bold-small")
	BankTKnopf[1337] = guiCreateButton(286,83,117,31,"Bank Konto eroeffnen",false,BankTTab[6])
	BankTLabel[11] = guiCreateLabel(7,3,424,67,"Willkommen in der Bank!\n\nDu hast noch kein Bankkonto eroeffnet. Bitte Tippe ein PIN-Code ein!\nWICHTIG: Bitte Merke dir diesen Code genau. Falls du ihn vergessen hast,\nKannst du einen Admin fragen.",false,BankTTab[6])
	guiSetFont(BankTLabel[11],"default-bold-small")
	--
	-- EIN/ AUSZAHLEN --
	BankTTab[1] = guiCreateTab("Zahlung",BankTTabPanel[1])
	BankTLabel[2] = guiCreateLabel(7,17,288,51,"Verfuegbares Kapital:\n0 $\nAuf Hand: 0$",false,BankTTab[1])
	guiLabelSetHorizontalAlign(BankTLabel[2],"center",false)
	guiSetFont(BankTLabel[2],"default-bold-small")
	BankTEdit[1] = guiCreateEdit(84,72,157,26,"",false,BankTTab[1])
	BankTLabel[3] = guiCreateLabel(21,75,66,20,"Summe: ",false,BankTTab[1])
	guiSetFont(BankTLabel[3],"default-bold-small")
	BankTKnopf[1] = guiCreateButton(84,103,75,26,"Einzahlen",false,BankTTab[1])
	BankTKnopf[2] = guiCreateButton(163,103,75,26,"Auszahlen",false,BankTTab[1])
	BankTLabel[4] = guiCreateLabel(299,14,137,134,"Hier kannst du deine \nFinanzen ueberpruefen.\nWenn du etwas \nauszahlen moechtest,\nTippe deine Summe ein, \nund Klicke auf \n'Auszahlen'.",false,BankTTab[1])
	guiLabelSetHorizontalAlign(BankTLabel[4],"center",false)
	guiSetFont(BankTLabel[4],"default-bold-small")
	if not(data == "Stadt") then
	-- UEBERWEISEN --
	BankTTab[2] = guiCreateTab("Ueberweisen",BankTTabPanel[1])
	BankTLabel[5] = guiCreateLabel(44,15,140,20,"Ueberweisung:",false,BankTTab[2])
	guiSetFont(BankTLabel[5],"default-bold-small")
	BankTLabel[6] = guiCreateLabel(41,51,93,18,"Empfaenger:",false,BankTTab[2])
	guiSetFont(BankTLabel[6],"default-bold-small")
	BankTEdit[2] = guiCreateEdit(37,69,122,25,"",false,BankTTab[2])
	BankTLabel[7] = guiCreateLabel(170,51,93,18,"Summe: ",false,BankTTab[2])
	guiSetFont(BankTLabel[7],"default-bold-small")
	BankTEdit[3] = guiCreateEdit(166,69,122,25,"",false,BankTTab[2])
	BankTCheckbox[1] = guiCreateCheckBox(312,26,107,25,"Bestaetigung",false,false,BankTTab[2])
	BankTEdit[4] = guiCreateEdit(116,96,173,27,"",false,BankTTab[2])
	BankTLabel[8] = guiCreateLabel(11,99,107,17,"Grund: (Optional)",false,BankTTab[2])
	guiSetFont(BankTLabel[8],"default-bold-small")
	-- SPENDEN --
	BankTTab[3] = guiCreateTab("Spenden",BankTTabPanel[1])
	BankTLabel[9] = guiCreateLabel(13,28,231,80,"Spenden\n___________\nHier kannst du Spenden abgeben,\nfuer Leute, die Obdachlos sind.\nSpenden kommen dein Image sehr gut.",false,BankTTab[3])
	guiSetFont(BankTLabel[9],"default-bold-small")
	BankTLabel[10] = guiCreateLabel(262,25,161,29,"Betrag:\nDu hast "..getPlayerMoney(gMe).." $.",false,BankTTab[3])
	guiSetFont(BankTLabel[10],"default-bold-small")
	BankTEdit[5] = guiCreateEdit(259,58,156,28,"",false,BankTTab[3])
	BankTKnopf[3] = guiCreateButton(308,59,112,27,"Ueberweisen",false,BankTTab[2])
	BankTKnopf[4] = guiCreateButton(272,92,128,25,"Spenden",false,BankTTab[3])
	-- KONTOAUSZUG --
	BankTTab[4] = guiCreateTab("Auszug",BankTTabPanel[1])
	BankTMemo[1] = guiCreateMemo(5,5,436,144,"",false,BankTTab[4])
	guiMemoSetReadOnly(BankTMemo[1],true)
	-- ABRECHNUNG --
	BankTTab[5] = guiCreateTab("Abrechnung",BankTTabPanel[1])
	BankTMemo[2] = guiCreateMemo(4,5,438,145,"",false,BankTTab[5])
	guiMemoSetReadOnly(BankTMemo[2], true)
	
	addEventHandler("onClientGUIClick", BankTKnopf[4], -- Spenden
	function()
		local text = tonumber(guiGetText(BankTEdit[5]))
		if(text == " ") or (text == "") then return end
		if(text < 0) then return end
		if(text > getPlayerMoney(gMe)-1) then outputChatBox("Du hast nicht soviel!", 200, 0, 0, false) return end
		outputChatBox("Vielen Dank fuer die Spende!", 0, 225, 0, false)
		setElementData(gMe, "pBGeld", getElementData(gMe, "pBGeld")-text)
		local timed = getFormatDate()
		triggerEvent("writeToPaylog", gMe, timed.."| Du hast "..text.."$ gespendet !")
		triggerServerEvent("onBankdataNeed", gMe)
		triggerServerEvent("onBankGeldSpende", gMe, text)
	end, false)
	end
	BankTKnopf[5] = guiCreateButton(386,28,64,24,"Abmelden",false,BankTFenster[1])
	-- ENABLEDS --
	guiSetEnabled(BankTTab[1], false)
	if not(data == "Stadt") then
		guiSetEnabled(BankTTab[2], false)
		guiSetEnabled(BankTTab[3], false)
		guiSetEnabled(BankTTab[4], false)
		guiSetEnabled(BankTTab[5], false)
	end
	loadPaylog()
	loadAbrechnung()
	triggerServerEvent("onBankdataNeed", gMe)

	addEvent("onBankdataNeedBack", true)
	addEventHandler("onBankdataNeedBack", gMe,
	function(geld)
		if not(source == gMe) then return end
		guiSetText(BankTLabel[2], "Verfuegbares Kapital:\n"..geld.." $\nAuf Hand: "..getPlayerMoney(gMe).."$")
		--guiSetText(BankTLabel[10], "Betrag:\nDu hast "..getPlayerMoney(gMe).." $.")
		if(getElementData(gMe, "Konto") == true) then
		guiSetText(BankTLabel[11], "Willkommen in der Bank!/Am Automaten!\n\nDein Konto wurde gefunden. Bitte Tippe dein PIN-Code ein!\nFalls du ihn vergessen hast. kannst du einen Admin fragen.")
		guiSetVisible(BankTLabel[13], false)
		guiSetVisible(BankTEdit[7], false)
		guiSetText(BankTKnopf[1337], "Anmelden")
		end
		if(getElementData(gMe, "Konto") == false) and (getElementData(gMe, "ATMVAR") == "Stadt") then
		guiSetText(BankTLabel[11], "Willkommen am Automaten!\nDu hast noch kein Bankkonto! Bitte gehe zu der Bank,\nund erstelle eins.",false,BankTTab[6])
		guiSetVisible(BankTEdit[6], false)
		guiSetVisible(BankTLabel[12], false)
		guiSetVisible(BankTLabel[13], false)
		guiSetVisible(BankTEdit[7], false)
		guiSetVisible(BankTKnopf[1337], false)
		else
		
		end
	end)



		addEventHandler("onClientGUIClick", BankTKnopf[1337], -- Login/register
		function()
		if(getElementData(gMe, "Konto") == false) then
			local text1 = guiGetText(BankTEdit[6])
			local text2 = guiGetText(BankTEdit[7])
			if(string.len(text1) > 4) or (string.len(text1) < 4) then outputChatBox("Ungueltiger Pin!", 200, 0, 0, false) return end
			if(string.len(text2) > 4) or (string.len(text2) < 4) then outputChatBox("Ungueltiger Pin!", 200, 0, 0, false) return end
			local text1 = tonumber(text1)
			local text2 = tonumber(text2)
			if(text1 ~= text2) then outputChatBox("Die Pin Nummern stimmen nicht ueberein!", 200, 0, 0, false) return end
			triggerServerEvent("onBankkontoEroeffne", gMe, text1)
			addEvent("onBankkontoErfolgreichEroeffnet", true)
			addEventHandler("onBankkontoErfolgreichEroeffnet", gMe,
			function()
			if not(source == gMe) then return end
				outputChatBox("Du hast dich erfolgreich Regestriert! Du kannst dich nun Anmelden.", 0, 200, 0, false)
				guiSetText(BankTLabel[11], "Willkommen in der Bank!\n\nDein Konto wurde gefunden. Bitte Tippe dein PIN-Code ein!\nFalls du ihn vergessen hast. kannst du einen Admin fragen.")
				guiSetVisible(BankTLabel[13], false)
				guiSetVisible(BankTEdit[7], false)
				guiSetText(BankTKnopf[1337], "Anmelden")
				setElementData(gMe, "Konto", true)
			end)
		else
			local text1 = guiGetText(BankTEdit[6])
			if(string.len(text1) > 4) or (string.len(text1) < 4) then outputChatBox("Ungueltiger Pin!", 200, 0, 0, false) return end
			local text1 = tonumber(text1)
			triggerServerEvent("onBankkontoAnmelden", gMe, text1)
			addEvent("onBankkontoErfolgreichAnmeld", true)
			function anmeld_func()
			if not(source == gMe) then return end
				outputChatBox("Du hast dich erfolgreich Angemeldet.", 0, 200, 0, false)
				removeEventHandler("onBankkontoErfolgreichAnmeld", gMe, anmeld_func)			
				guiSetEnabled(BankTTab[1], true)
				if not(data == "Stadt") then
				guiSetEnabled(BankTTab[2], true)
				guiSetEnabled(BankTTab[3], true)
				guiSetEnabled(BankTTab[4], true)
				guiSetEnabled(BankTTab[5], true)
				end
				guiSetEnabled(BankTTab[6], false)
				guiSetSelectedTab ( BankTTabPanel[1], BankTTab[1] )
			end
			addEventHandler("onBankkontoErfolgreichAnmeld", gMe,anmeld_func)
		end
		end, false)
	if not(data == "Stadt") then
	addEventHandler("onClientGUIClick", BankTKnopf[3], -- Ueber
	function()
		local empfaenger = guiGetText(BankTEdit[2]) -- Empfaenger
		if(empfaenger == " ") or (empfaenger == "") then return end
		if not(getPlayerFromName(empfaenger)) then outputChatBox("Spieler ist nicht Online/wurde nicht gefunden!", 200, 0, 0, false) return end
		local text = tonumber(guiGetText(BankTEdit[3])) -- Wieviel
		if(text == " ") or (text == "") then return end
		if(text < 0) then return end
		local grund = guiGetText(BankTEdit[4])
		if(grund == "") or (grund == " ") then grund = "N/A" end
		if(guiCheckBoxGetSelected(BankTCheckbox[1]) == false) then outputChatBox("Du musst die Ueberweisung bestaetigen. ", 200, 0, 0, false) return end
		outputChatBox("Ueberweisung erfolgt...", 0, 200, 0, false)
		setTimer(triggerServerEvent, 3500, 1, "onBankAction", gMe, text, 3, empfaenger, grund)
		guiSetText(BankTEdit[2], "")
		guiSetText(BankTEdit[3], "")
		guiSetText(BankTEdit[4], "")
		guiCheckBoxSetSelected(BankTCheckbox[1], false)
	end, false)
	end

	addEventHandler("onClientGUIClick", BankTKnopf[2], -- Aus
	function()
		local text = tonumber(guiGetText(BankTEdit[1]))
		if(text == " ") or (text == "") then return end
		if(text < 0) then return end
		triggerServerEvent("onBankAction", gMe, text, 2)
	end, false)

	addEventHandler("onClientGUIClick", BankTKnopf[1], -- Einzahlen
	function()
		local text = tonumber(guiGetText(BankTEdit[1]))
		if(text == " ") or (text == "") then return end
		if(text > getPlayerMoney(gMe)) then outputChatBox("Du hast nicht soviel Geld!", 200, 0, 0, false) return end
		if(text < 0) then return end
		triggerServerEvent("onBankAction", gMe, text, 1)
	end, false)



	addEventHandler("onClientGUIClick", BankTKnopf[5],
	function()
	guiSetVisible(BankTFenster[1], false)
	Guivar = 0
	showCursor(false)
	setElementData(gMe, "Clicked", 0)
	end, false)

end

function loadAbrechnung()
	if not(fileExists("logs/logs/abrechnung.txt")) then 
		local file = fileCreate("logs/abrechnung.txt")
	else 
		local file = fileOpen("logs/abrechnung.txt")
		local text = fileRead(file, 1000)
		if not(getElementData(gMe, "ATMVAR") == "Stadt") then
		guiSetText(BankTMemo[2], text)
		end
		fileClose(file)
	end
end

function writeToAbrechnung_func(text)
if not(source == gMe) then return end
	if not(fileExists("logs/abrechnung.txt")) then 
		local file = fileCreate("logs/abrechnung.txt")
	end
		local file = fileOpen("logs/abrechnung.txt")
		local text2 = fileRead(file, 1000)
		if(fileGetSize ( file ) > 100) then
		fileClose(file)
		fileDelete("logs/abrechnung.txt")
		local file = fileCreate("logs/abrechnung.txt")
		fileWrite(file, text)
		fileFlush(file)
		fileClose(file)
		--loadAbrechnung()
		else
		fileClose(file)
		fileDelete("logs/abrechnung.txt")
		local file = fileCreate("logs/abrechnung.txt")
		fileWrite(file, text)
		fileFlush(file)
		fileClose(file)
		--loadAbrechnung() 
		end
	
end
addEvent("writeToAbrechnung", true)
addEventHandler("writeToAbrechnung", gMe, writeToAbrechnung_func)

function loadPaylog()
	if not(fileExists("logs/paylog.txt")) then 
		local file = fileCreate("logs/paylog.txt")
	else 
		local file = fileOpen("logs/paylog.txt")
		local text = fileRead(file, 1000)
		if not(getElementData(gMe, "ATMVAR") == "Stadt") then
		guiSetText(BankTMemo[1], text)
		end
		fileClose(file)
	end
end

function writeToPaylog_func(text, var)
if not(source == gMe) then return end
	if not(fileExists("logs/paylog.txt")) then 
		local file = fileCreate("logs/paylog.txt")
	end
		local file = fileOpen("logs/paylog.txt")
		local text2 = fileRead(file, 1000)
		if(fileGetSize ( file ) > 1000) then
		fileClose(file)
		fileDelete("logs/paylog.txt")
		local file = fileCreate("logs/paylog.txt")
		fileWrite(file, "______\n"..text)
		fileFlush(file)
		fileClose(file)
		if(var == nil) then
		loadPaylog()
		end
		else
		fileClose(file)
		fileDelete("logs/paylog.txt")
		local file = fileCreate("logs/paylog.txt")
		fileWrite(file, text2.."\n"..text)
		fileFlush(file)
		fileClose(file)
		if(var == nil) then
		loadPaylog() 
		end
		end
	
end
addEvent("writeToPaylog", true)
addEventHandler("writeToPaylog", gMe, writeToPaylog_func)


addEvent("onBankTerminalClick", true)
addEventHandler("onBankTerminalClick", gMe, 
function(data)
if not(source == gMe) then return end
createBankTerminal(data)
end)