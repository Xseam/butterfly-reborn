local Guivar = 0



function createRegisterMenue()
if(Guivar == 1) then return end
Guivar = 1

setElementData(gMe, "inLogin", 1)
local data = tonumber(getElementData(gMe, "scriptvar"))
if(data == 1) then return end
local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 531,300
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
Loginfenster = {}
LoginTabPanel = {}
LoginTab = {}
LoginKnopf = {}
LoginLabel = {}
LoginEdit = {}
LoginRadio = {}
LoginGrid = {}
LoginBild = {}

showCursor(true)
-- LOGIN --
Loginfenster[1] = guiCreateWindow(X, Y, Width, Height,"Willkommen!",false)
LoginTabPanel[1] = guiCreateTabPanel(9,26,513,265,false,Loginfenster[1])
LoginTab[1] = guiCreateTab("Login",LoginTabPanel[1])
LoginBild[1] = guiCreateStaticImage(8,11,489,68,"data/images/logo.png",false,LoginTab[1])
LoginLabel[1] = guiCreateLabel(99,87,301,35,"Willkommen auf XP-Reallife!\nDeine Daten wurden gefunden, bitte Logge dich ein!",false,LoginTab[1])
guiLabelSetHorizontalAlign(LoginLabel[1],"center",false)
guiSetFont(LoginLabel[1],"default-bold-small")
LoginLabel[2] = guiCreateLabel(16,122,117,17,"Passwort:",false,LoginTab[1])
guiSetFont(LoginLabel[2],"default-bold-small")
LoginEdit[1] = guiCreateEdit(15,142,471,29,"12345",false,LoginTab[1])
guiEditSetMasked(LoginEdit[1],true)
LoginKnopf[1] = guiCreateButton(158,179,183,29,"Einloggen",false,LoginTab[1])
LoginLabel[3] = guiCreateLabel(9,214,497,27,"(Falls du noch kein Account hast, Regestrier dich, oder nehme einen anderen Namen.)",false,LoginTab[1])
guiSetFont(LoginLabel[3],"default-bold-small")
-- REGISTER --
LoginTab[2] = guiCreateTab("Register",LoginTabPanel[1])
LoginLabel[4] = guiCreateLabel(17,12,228,24,"Bitte Fuelle dieses Formular aus!",false,LoginTab[2])
guiSetFont(LoginLabel[4],"default-bold-small")
LoginLabel[5] = guiCreateLabel(15,41,292,15,"Accountname: N/A",false,LoginTab[2])
guiLabelSetColor(LoginLabel[5],255, 255, 0)
guiSetFont(LoginLabel[5],"default-bold-small")
LoginLabel[6] = guiCreateLabel(15,58,211,18,"Passwort:",false,LoginTab[2])
guiLabelSetColor(LoginLabel[6],0, 255, 0)
guiSetFont(LoginLabel[6],"default-bold-small")
LoginEdit[2] = guiCreateEdit(12,77,197,23,"",false,LoginTab[2])
guiEditSetMasked(LoginEdit[2],true)
LoginEdit[3] = guiCreateEdit(11,119,197,23,"",false,LoginTab[2])
guiEditSetMasked(LoginEdit[3],true)
LoginLabel[7] = guiCreateLabel(14,103,211,18,"Bestaetigung:",false,LoginTab[2])
guiLabelSetColor(LoginLabel[7],0, 255, 0)
guiSetFont(LoginLabel[7],"default-bold-small")
LoginLabel[8] = guiCreateLabel(322,32,183,18,"Alter:(Kein Geburtstdatum)",false,LoginTab[2])
guiLabelSetColor(LoginLabel[8],255, 255, 0)
guiSetFont(LoginLabel[8],"default-bold-small")
LoginEdit[4] = guiCreateEdit(330,55,69,23,"",false,LoginTab[2])
LoginLabel[9] = guiCreateLabel(327,98,164,17,"Sprache:",false,LoginTab[2])
guiLabelSetColor(LoginLabel[9],255,255,0)
guiSetFont(LoginLabel[9],"default-bold-small")
LoginGrid[1] = guiCreateGridList(323,119,183,97,false,LoginTab[2])
guiGridListSetSelectionMode(LoginGrid[1],2)

		guiWindowSetSizable ( Loginfenster[1], false )
		guiWindowSetMovable ( Loginfenster[1], false )

guiGridListAddColumn(LoginGrid[1],"Land",0.2)
LoginLabel[10] = guiCreateLabel(13,153,117,18,"Geschlecht:",false,LoginTab[2])
guiLabelSetColor(LoginLabel[10],255, 255,0 )
guiSetFont(LoginLabel[10],"default-bold-small")
LoginRadio[1] = guiCreateRadioButton(15,175,114,21,"Maennlich",false,LoginTab[2])
guiRadioButtonSetSelected(LoginRadio[1],true)
LoginRadio[2] = guiCreateRadioButton(14,195,114,21,"Weiblich",false,LoginTab[2])
LoginKnopf[2] = guiCreateButton(169,187,134,30,"Registrieren",false,LoginTab[2])

-- EVENTS --

addEventHandler("onClientGUIClick", LoginKnopf[1],
function()
	local pw = guiGetText(LoginEdit[1])
	if (pw == " ") or (pw == "") then outputChatBox("Falsches Passwort!", 255, 0, 0, false) return end
	outputChatBox("PW: "..pw, 255, 255, 255, false)
	guiSetVisible(Loginfenster[1], false)
	Guivar = 0
	showCursor(false)
	resetAmbient()
	infolabel_func("Du hast dich erfolgreich Eingeloggt!", 0, 255, 0, 4000)

end, false)

end
-- AMBIENT --
function resetAmbient()
	removeEventHandler("onClientRender", getRootElement(), moveAmbient)
	triggerServerEvent("onXPSpawn", gMe)
	setElementData(gMe, "inLogin", 0)
	ambientZeit = 0
	moveMent = 0
end

local moveMent = 0
local ambientZeit = 0

function moveAmbient()
	local data = getElementData(gMe, "inLogin")
	if (data == 0) then return end
	moveMent = (moveMent+0.010)
	if(ambientZeit == 0) then
		setCameraMatrix(226.35038757324, -52.032470703125, 5.578125+moveMent, 232.00550842285, -68.740165710449, 5.4282329082489+moveMent)
	else
		setCameraMatrix(70.030120849609, -205.12910461426, 5.5993193387985+moveMent, 64.771110534668, -200.03796386719, 5.5992846488953+moveMent)
	end
end
function showToAmbient()
	local data = tonumber(getElementData(gMe, "scriptvar"))
	if(data == 1) then return end
	fadeCamera(false, 0, 0, 0, 0) --Sofort
	fadeCamera(true)
	setElementInterior(gMe, 0)
	local realtime = getRealTime()
	local stunde = realtime.hour
	if( stunde < 20 ) and ( stunde > 7) then
		setCameraMatrix(226.35038757324, -52.032470703125, 5.578125, 232.00550842285, -68.740165710449, 5.4282329082489)
		ambientZeit = 0
	else	
		setCameraMatrix(70.030120849609, -205.12910461426, 5.5993193387985, 64.771110534668, -200.03796386719, 5.5992846488953)
		ambientZeit = 1
	end
	setElementPosition(gMe, 0, 0, 0)
	setElementFrozen(gMe, true)
	addEventHandler("onClientRender", getRootElement(), moveAmbient)
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), createRegisterMenue )
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), showToAmbient )