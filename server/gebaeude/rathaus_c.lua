local fahrstuhltuer = createObject(3051,1712.60327148,-1641.43737793,20.58095360,0.00000000,0.00000000,179.49462891)  setElementInterior(fahrstuhltuer, 18)--object(lift_dr) (3) 
local fahrvar = 0
local Tante = createPed(194, 1732.1010742188, -1651.4517822266, 20.234569549561)
setElementInterior(Tante, 18)
setPedRotation(Tante, 90)

addEventHandler("onClientPedDamage", getRootElement(), function() if(source == Tante) then cancelEvent() end end)


function fahrstuhl_aufzu()
	if fahrvar == 0 then
		moveObject( fahrstuhltuer, 700, 1712.2623291016, -1641.810546875, 20.580953598022)
		fahrvar = 1
	elseif fahrvar == 1 then
		fahrvar = 2
	elseif fahrvar == 2 then
		moveObject( fahrstuhltuer, 700, 1712.6376953125, -1641.41015625, 20.580953598022)
		fahrvar = 0
	end
end 
setTimer(fahrstuhl_aufzu, 700, 0)

function add_sparks_rathaus()
	fxAddBulletImpact ( 1712.2623291016, -1641.810546875, 20.580953598022-0.5, 0, 0, 2, 4, 1, 1 )
	fxAddBulletImpact ( 1712.2623291016, -1641.810546875, 20.580953598022-0.5, 0, 0, 2, 4, 1, 1 )
	fxAddBulletImpact ( 1712.2623291016, -1641.810546875, 20.580953598022-0.5, 0, 0, 2, 4, 1, 1 )
	fxAddSparks( 1712.2623291016, -1641.810546875, 20.580953598022, 0, 0, 2, 1, 2, 0, 0, 0, true, 1, 1 )
	fxAddSparks( 1712.2623291016, -1641.810546875, 20.580953598022, 0, 0, 2, 1, 2, 0, 0, 0, true, 1, 1 )
	fxAddSparks( 1712.6376953125, -1641.41015625+0.5, 20.580953598022, 0, 0, 2, 1, 5, 0, 0, 0, true, 1, 1 )
	fxAddSparks( 1712.6376953125, -1641.41015625+0.3, 20.580953598022, 0, 0, 2, 1, 5, 0, 0, 0, true, 1, 1 )
end

addEventHandler("onClientRender", getRootElement(), add_sparks_rathaus)

local Guivar = 0



function createRathausGuiMenue()
if(Guivar == 1) then return end
	Guivar = 1
	setElementData(gMe, "Clicked", 1)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	
	local RATFenster = {}
	local RATTabPanel = {}
	local RATTab = {}
	local RATKnopf = {}
	RATLabel = {}
	
	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 469,273
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	local perso = tonumber(getElementData(gMe, "pPerso"))

	RATFenster[1] = guiCreateWindow(X, Y, Width, Height, "Rathaus",false)
	RATTabPanel[1] = guiCreateTabPanel(10,24,449,209,false,RATFenster[1])
	RATTab[1] = guiCreateTab("Optionen",RATTabPanel[1])
	RATTab[2] = guiCreateTab("Statistiken",RATTabPanel[1])
	RATTab[3] = guiCreateTab("Serverstatistiken",RATTabPanel[1])
	RATLabel[1] = guiCreateLabel(57,3,327,57,"Willkommen in der Stadthalle!\nHier kannst du ein Personalausweis fuer dich Beantragen,\noder Statistiken von dir oder dem Server ansehen.",false,RATTab[1])
	guiLabelSetHorizontalAlign(RATLabel[1],"center",false)
	guiSetFont(RATLabel[1],"default-bold-small")
	RATLabel[2] = guiCreateLabel(17,69,136,14,"Personalausweis:",false,RATTab[1])
	guiSetFont(RATLabel[2],"default-bold-small")
	RATLabel[3] = guiCreateLabel(15,74,136,14,"____________________________",false,RATTab[1])
	guiLabelSetColor(RATLabel[3],0, 255, 255)
	guiSetFont(RATLabel[3],"default-bold-small")
	RATKnopf[1] = guiCreateButton(18,96,128,28,"Beantragen",false,RATTab[1])
	RATLabel[4] = guiCreateLabel(171,82,216,37,"Du hast noch kein Personalausweis.\nDu kannst ihn fuer 50$ Beantragen.",false,RATTab[1])
	guiSetFont(RATLabel[4],"default-bold-small")
	if(perso == 1) then
		guiSetText(RATLabel[4], "Du hast bereits ein Personalausweis.")
		guiSetEnabled(RATKnopf[1], false)
	end
	if(getElementData(gMe, "pPAntrag") == true) then
		guiSetText(RATLabel[4], "Du hast bereits Beantragt.")
		guiSetEnabled(RATKnopf[1], false)
	end
	if(perso == 0) then
		RATLabel[5] = guiCreateLabel(15,11,351,21,"Du hast noch kein Personalausweis! Du musst ein Beantragen.",false,RATTab[2])
		guiSetFont(RATLabel[5],"default-bold-small")
	else
		local name = getPlayerName(gMe)
		local spielzeit = getElementData(gMe, "pSpielzeit")
		if not (spielzeit) then spielzeit = "N/A" end
		local fraktion = fraktionNamen[tonumber(getElementData(gMe, "pFraktion"))]
		if not (fraktion) then fraktion = "N/A" end
		local rang = tonumber(getElementData(gMe, "pFraktionsrang"))
		if not (rang) then rang = "N/A" end
		local status = getElementData(gMe, "pStatus")
		if not(status) then status = "N/A" end
		local hgeld = tonumber(getElementData(gMe, "pHGeld"))
		if not(hgeld) then hgeld = "N/A" end
		local bgeld = tonumber(getElementData(gMe, "pBGeld"))
		if not(bgeld) then bgeld = "N/A" end
		local wanteds = tonumber(getElementData(gMe, "pWanteds"))
		if not(wanteds) then wanteds = "N/A" end
		local stvos = tonumber(getElementData(gMe, "pSTVO"))
		if not(stvos) then stvos = "N/A" end
		local adminlevel = tonumber(getElementData(gMe, "pAdminlevel"))
		if not(adminlevel) then adminlevel = "N/A" end
		local tode = tonumber(getElementData(gMe, "pTode"))
		if not(tode) then tode = "N/A" end
		local morde = tonumber(getElementData(gMe, "pMorde"))
		if not(morde) then morde = "N/A" end
		RATLabel[5] = guiCreateLabel(12,6,366,19,"Statistiken vom Spieler "..name..":",false,RATTab[2])
		guiSetFont(RATLabel[5],"default-bold-small")
		RATLabel[6] = guiCreateLabel(12,11,366,19,"_______________________________________________________________________",false,RATTab[2])
		guiLabelSetColor(RATLabel[6],0, 255, 255)
		guiSetFont(RATLabel[6],"default-bold-small")
		RATLabel[7] = guiCreateLabel(17,33,162,19,"Spielzeit: "..spielzeit,false,RATTab[2])
		guiSetFont(RATLabel[7],"default-bold-small")
		RATLabel[8] = guiCreateLabel(17,49,162,19,"Fraktion: "..fraktion,false,RATTab[2])
		guiSetFont(RATLabel[8],"default-bold-small")
		RATLabel[9] = guiCreateLabel(17,63,162,19,"Fraktionsrang: "..rang,false,RATTab[2])
		guiSetFont(RATLabel[9],"default-bold-small")
		RATLabel[10] = guiCreateLabel(16,77,162,19,"Status: "..status,false,RATTab[2])
		guiSetFont(RATLabel[10],"default-bold-small")
		RATLabel[11] = guiCreateLabel(16,92,141,30,"Geld auf Hand:\n"..hgeld.."$",false,RATTab[2])
		guiSetFont(RATLabel[11],"default-bold-small")
		RATLabel[12] = guiCreateLabel(16,119,141,30,"Geld auf Bank:\n"..bgeld.."$",false,RATTab[2])
		guiSetFont(RATLabel[12],"default-bold-small")
		RATLabel[13] = guiCreateLabel(262,29,163,15,"Wanteds: "..wanteds,false,RATTab[2])
		guiSetFont(RATLabel[13],"default-bold-small")
		RATLabel[14] = guiCreateLabel(262,43,163,15,"STVO-Punkte: "..stvos,false,RATTab[2])
		guiSetFont(RATLabel[14],"default-bold-small")
		RATLabel[15] = guiCreateLabel(262,58,110,31,"Regestrierdatum:\n",false,RATTab[2])
		guiSetFont(RATLabel[15],"default-bold-small")
		RATLabel[16] = guiCreateLabel(262,89,128,17,"Adminlevel: "..adminlevel,false,RATTab[2])
		guiSetFont(RATLabel[16],"default-bold-small")
		RATLabel[17] = guiCreateLabel(262,108,172,18,"Krankenhausbesuche: "..tode,false,RATTab[2])
		guiSetFont(RATLabel[17],"default-bold-small")
		RATLabel[18] = guiCreateLabel(262,124,128,16,"Morde: "..morde,false,RATTab[2])
		guiSetFont(RATLabel[18],"default-bold-small")
	end

	RATLabel[19] = guiCreateLabel(18,8,165,18,"Allgemein:",false,RATTab[3])
	guiSetFont(RATLabel[19],"default-bold-small")
	RATLabel[20] = guiCreateLabel(15,13,165,18,"_____________________",false,RATTab[3])
	guiLabelSetColor(RATLabel[20],0, 255, 255)
	guiSetFont(RATLabel[20],"default-bold-small")
	RATLabel[21] = guiCreateLabel(16,32,166,29,"Geld im Umlauf:\n0$",false,RATTab[3])
	guiSetFont(RATLabel[21],"default-bold-small")
	RATLabel[22] = guiCreateLabel(15,60,144,17,"Autos: "..#getElementsByType("vehicle"),false,RATTab[3])
	guiSetFont(RATLabel[22],"default-bold-small")
	RATLabel[23] = guiCreateLabel(15,94,199,15,"Spieler in Fraktionen:",false,RATTab[3])
	guiSetFont(RATLabel[23],"default-bold-small")
	RATLabel[24] = guiCreateLabel(15,109,227,16,"Spieler ohne Fraktionen:",false,RATTab[3])
	guiSetFont(RATLabel[24],"default-bold-small")
	RATLabel[25] = guiCreateLabel(15,77,242,16,"Regestrierte Benutzer: ",false,RATTab[3])
	guiSetFont(RATLabel[25],"default-bold-small")
	RATLabel[26] = guiCreateLabel(14,123,227,16,"Zigaretten: ",false,RATTab[3])
	guiSetFont(RATLabel[26],"default-bold-small")
	RATLabel[27] = guiCreateLabel(14,137,158,15,"Biere: ",false,RATTab[3])
	guiSetFont(RATLabel[27],"default-bold-small")
	RATLabel[28] = guiCreateLabel(235,35,213,17,"Spielzeit Aller User:",false,RATTab[3])
	guiSetFont(RATLabel[28],"default-bold-small")
	RATLabel[29] = guiCreateLabel(235,49,213,17,"User mit Fuererschein:",false,RATTab[3])
	guiSetFont(RATLabel[29],"default-bold-small")
	RATLabel[30] = guiCreateLabel(235,64,213,17,"User mit Privatautos:",false,RATTab[3])
	guiSetFont(RATLabel[30],"default-bold-small")
	RATLabel[31] = guiCreateLabel(234,80,213,17,"Eroeffnete Konten:",false,RATTab[3])
	guiSetFont(RATLabel[31],"default-bold-small")
	triggerServerEvent("onRathausStatistikenNeed", gMe)
	addEvent("onRathausStatistikenNeedBack", true)
	addEventHandler("onRathausStatistikenNeedBack", getRootElement(),
	function(meinregister, geld, autos, playerinfaction, playerohnefaction, regestrierte, zigaretten, biere, spielzeit, userfuehrerschein, userprivatautos, konten)
		guiSetText(RATLabel[21], "Geld im Umlauf:\n"..geld.."$")
		--guiSetText(RATLabel[22], "Autos: "..autos)
		guiSetText(RATLabel[23], "Spieler in Fraktionen: "..playerinfaction)
		guiSetText(RATLabel[24], "Spieler ohne Fraktionen: "..playerohnefaction)
		guiSetText(RATLabel[25], "Regestrierte Benutzer: "..regestrierte)
		guiSetText(RATLabel[26], "Zigaretten: "..zigaretten)
		guiSetText(RATLabel[27], "Biere: "..biere)
		guiSetText(RATLabel[28], "Spielzeit Aller User: "..spielzeit)
		guiSetText(RATLabel[29], "User mit Fuehrerschein: "..userfuehrerschein)
		guiSetText(RATLabel[30], "User mit Privatautos: "..userprivatautos)
		guiSetText(RATLabel[31], "Eroeffnete Konten: "..konten)
	end)
	RATKnopf[2] = guiCreateButton(170,239,138,25,"OK",false,RATFenster[1])

	addEventHandler("onClientGUIClick", RATKnopf[1],
	function()
		local data = tonumber(getElementData(gMe, "pHGeld"))
		if(data < 51) then outputChatBox("Du benoetigst 50$ fuer den Personalausweis.", 230, 0, 0, false) return end
		setElementData(gMe, "pHGeld", data-50)
		triggerServerEvent("onRathausPersoBuy", gMe)
		guiSetText(RATLabel[4], "Du hast den Perso beantragt.")
		guiSetEnabled(RATKnopf[1], false)
	end, false)
	
	addEventHandler("onClientGUIClick", RATKnopf[2],
	function()
		guiSetVisible(RATFenster[1], false)
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		Guivar = 0
	end, false)

end

addEvent("onRathausEnter", true)
addEventHandler("onRathausEnter", getRootElement(),
function()
createRathausGuiMenue()
end)