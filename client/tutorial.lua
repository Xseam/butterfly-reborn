local Guivar = 0
local Zeitvar = 30
local Tutlabel
local tutTexte = {
	[1] = "Willkommen auf Butterfly-Reallife!",
	[2] = "Ich werde dir nun die wichtigesten Sachen erklaeren. Dieser Server ist ein Reallife Server.\nAlso musst du dich auch dementsprechend Verhalten!\nDas heisst zum Beispiel: Deathmatch ist Untersagt.",
	[3] = "Du kannst mit sehr vielen Dingen Interaktieren. Du kannst Objekte, Autos\nSpieler, Peds, alles Moegliche anklicken! Halte 'ALT', um die Maus zu benutzen.",
	[4] = "Bitte verhalte dich auch im Strassenverkehr angemessen, dass heisst\nNach der STVO-Fahren, und angemessene Geschwindigkeit haben.\nDen Fuehrerschein und andere Scheine bekommst du beim Fahrlehrer.",
	[5] = "Du kannst auch Sachen sammeln, die du dann\nanschliessend bei diesem Ankaeufer verkaufen kannst.\nGesammelte Sachen findest du in deinem Inventar.",
	[6] = "Der Spielort in unserem Server sind die Orte\nBlueberry, Montgomery, Dillmore und Palomino Creek.",
	[7] = "Du hast regelmaessig Hunger, wobei du auch verhungern kannst.\nDeshalb musst du immer mal wieder etwas Essen,\num so am Leben zu bleiben.",
	[8] = "Ich glaube, ich habe dir nun das wichtigste Gesagt.\nFalls du fragen hast, kannst du /report benutzen.\nDas andere siehst du einfach, wenn du auf dem Server spielst.",
	[9] = "Wir wuenschen dir viel Spass auf Butterfly-Reallife!",
}
local Tutvar = 0
local font = guiCreateFont("data/impact.ttf", 15)
function tutorial_next_text()
	Tutvar = Tutvar+1
	guiSetText(Tutlabel, tutTexte[Tutvar])
end
--smoothMoveCamera(campos, lookat, camposmov, lookatmov)
function tutorial_cam_fertig()
	fadeCamera(false)
	setTimer(
		function()
			fadeCamera(true)
			setCameraTarget(gMe)
			guiSetVisible(Tutlabel, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))+1000)
			toggleAllControls(true)
		end, 1000, 1)
	Tutvar = 0
end

function tutorial_cam_8()
	local time = 11000
	smoothMoveCamera(447.28695678711, -89.806587219238, 42.060173034668, 475.96377563477, -66.319877624512, 44.433654785156, 454.25396728516, -54.445808410645, 48.866172790527, 411.48797607422, -69.99747467041, 46.452987670898, time)
	tutorial_next_text()
	setTimer(tutorial_cam_fertig, time+2000, 1)
end

function tutorial_cam_7()
	local time = 11000
	smoothMoveCamera(258.54013061523, -182.59762573242, 25.174787521362, 311.96670532227, -165.44534301758, 7.4265623092651, 447.28695678711, -89.806587219238, 42.060173034668, 475.96377563477, -66.319877624512, 44.433654785156, time)
	tutorial_next_text()
	setTimer(tutorial_cam_8, time+2000, 1)
end

function tutorial_cam_6()
	local time = 11000
	smoothMoveCamera(160.62240600586, -47.874565124512, 26.270992279053, 177.46662902832, -105.78684997559, 18.362333297729, 258.54013061523, -182.59762573242, 25.174787521362, 311.96670532227, -165.44534301758, 7.4265623092651, time)
	tutorial_next_text()
	setTimer(tutorial_cam_7, time+2000, 1)
end

function tutorial_cam_5()
	local time = 11000
	smoothMoveCamera(175.12814331055, -29.052280426025, 1.578125 , 169.78414916992, -32.998291015625, 1.578125, 160.62240600586, -47.874565124512, 26.270992279053, 177.46662902832, -105.78684997559, 18.362333297729, time)
	tutorial_next_text()
	setTimer(tutorial_cam_6, time+2000, 1)
end

function tutorial_cam_4()
	local time = 11000
	smoothMoveCamera(280.52679443359, -31.890497207642, 1.8713042736053, 254.94172668457, -28.806100845337, 4.6320381164551, 175.12814331055, -29.052280426025, 1.578125 , 169.78414916992, -32.998291015625, 1.578125, time)
	tutorial_next_text()
	setTimer(tutorial_cam_5, time+2000, 1)
end

function tutorial_cam_3()
	local time = 11000
	smoothMoveCamera(280.52679443359, -31.890497207642, 1.8713042736053, 280.86181640625, -36.241512298584, 2.0203013420105, 280.52679443359, -31.890497207642, 1.8713042736053, 254.94172668457, -28.806100845337, 4.6320381164551, time)
	tutorial_next_text()
	setTimer(tutorial_cam_4, time+2000, 1)
end
function tutorial_cam_2()
	local time = 8000
	smoothMoveCamera(270.16842651367, -26.670127868652, 2.0181987285614, 280.55368041992, -34.827430725098, 1.6945707798004,280.52679443359, -31.890497207642, 1.8713042736053, 280.86181640625, -36.241512298584, 2.0203013420105, time)
	tutorial_next_text()
	setTimer(tutorial_cam_3, time+2000, 1)
end


function tutorial_cam_1()
	local time = 7000
	smoothMoveCamera(232.13537597656, -15.375511169434, 1.4296875, 242.82325744629, -23.858074188232, 1.578125, 270.16842651367, -26.670127868652, 2.0181987285614, 280.55368041992, -34.827430725098, 1.6945707798004, time)
	tutorial_next_text()
	setTimer(tutorial_cam_2, time+100, 1)
end

function start_tutorial_func()
	fadeCamera(true)
	Tutlabel = guiCreateLabel(0.1948,0.7278,0.6224,0.2074,"Willkommen auf Butterfly-Reallife!",true)
	guiLabelSetHorizontalAlign(Tutlabel,"center",false)
	guiSetFont(Tutlabel, font)
	tutorial_next_text()
	local time = 10000
	smoothMoveCamera ( 231.80949401855, 24.788640975952, 2.4296875, 232.69285583496, 5.9761943817139, 2.4296875, 232.13537597656, -15.375511169434, 1.4296875, 242.82325744629, -23.858074188232, 1.578125, time )
	setTimer(tutorial_cam_1, time+1000, 1)
end
function buildWillkommensGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	local time = getRealTime()
	local hour = time.hour
	local minute = time.minute
	setTime(hour, minute)
	setWeather(0)
	local X, Y, Width, Height = getMiddleGuiPosition(460,403)
	local Fenster = guiCreateWindow(X, Y, Width, Height, "Information",false)
	local Knopf1 = guiCreateButton(48,362,130,28,"Schliessen",false,Fenster)
	local Bild = guiCreateStaticImage(11,20,439,55,"data/images/logo.png",false,Fenster)
	local Label1 = guiCreateLabel(11,75,439,20,"______________________________________________________________",false,Fenster)
	local Label2 = guiCreateLabel(14,96,436,261,"Herzlich Willkommen auf Butterfly-Reallife!\nWie wir sehen, bist du neu hier.\nDamit du nicht ins Kalte Wasser geworfen wirst, haben\nwir ein paar Informationen fuer dich.\n\nDas Forum lautet:\n\n\nDer Teamspeak-Server:\n\n\nFalls du Hilfe brauchst, benutze /report!\nAllgemeine Hilfe und Antworten auf Fragen findest du mit einem\ndruck auf 'F9'.\n\nWir wuenschen dir viel Spass auf Butterfly!\n\nDu hast jetzt noch die Moeglichkeit, ein Tutorial zu sehen.\nBitte mach das Tutorial, denn wir haben eine etwas anderes Spielprinzip!",false,Fenster)
	guiSetFont(Label2,"default-bold-small")
	local Knopf2 = guiCreateButton(288,363,130,28,"Tutorial",false,Fenster)
	setTimer(
		function()
			Zeitvar = Zeitvar-1
				guiSetText(Knopf1, "Schliessen("..Zeitvar..")")
			if(Zeitvar < 1) then
				guiSetText(Knopf1, "Schliessen")
			end
		end, 1000, 30)
	addEventHandler("onClientGUIClick", Knopf2,
	function()
			guiSetVisible(Fenster, false)
			Guivar = 0
			removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
			showCursor(false)
			setTimer(start_tutorial_func, 1000, 1)
			fadeCamera(false)
			toggleAllControls(false)
	end, false)
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		if(Zeitvar < 1) then
			Guivar = 0
			guiSetVisible(Fenster, false)
			removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
			showCursor(false)
		else
			outputChatBox("Bitte warte noch "..Zeitvar.." sekunden.", 0, 200, 200)
		end
	end, false)
end

addEvent("startWillkommenMenue", true)
addEventHandler("startWillkommenMenue", getRootElement(),
function()
	buildWillkommensGui()
end)

--[[
addCommandHandler("tutorial",
function()
	setTimer(start_tutorial_func, 1000, 1)
	fadeCamera(false)
end)

addCommandHandler("stoptut",
function()
setCameraTarget(gMe)
Tutvar = 0
end)--]]