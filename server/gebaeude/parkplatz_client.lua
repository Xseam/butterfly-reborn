local Infocol = createColSphere(189.81288146973, -323.85238647461, 1.578125, 1.5)
local Guivar = 0
local Fenster, Label1, Label2, Label3

addEventHandler("onClientColShapeHit", Infocol,
function(hitElement)
	if(hitElement ~= gMe) then return end
	if(Guivar == 1) then return end
	local X, Y, Width, Height = getMiddleGuiPosition(353,307)
	
	Fenster = guiCreateWindow(X, Y, Width, Height,"Parkplatzinformation",false)
	Label1 = guiCreateLabel(14,23,132,19,"Information:",false,Fenster)
	guiSetFont(Label1,"default-bold-small")
	Label2 = guiCreateLabel(12,28,146,17,"________________________",false,Fenster)
	guiLabelSetColor(Label2,0, 255, 255)
	guiSetFont(Label2,"default-bold-small")
	Label3 = guiCreateLabel(10,55,332,245,"Willkommen auf dem Parkplatz in Blueberry!\n\nHier kannst du dein Fahrzeug abstellen, und dort auch \nabgestellt lassen.\n\n______\nOeffnungszeiten:\nMo-So, 0-23h\n______\n\nBite Parke dein Fahrzeug ordentlich!\nNicht Ordentlich abgstellte Fahrzeuge\nkoennen geloescht werden!\nFalls du Fragen hast, kannst du gerne\nein Admin mit /report kontaktieren.\n\n\nGeniesse das freie Parken!",false,Fenster)
	guiLabelSetHorizontalAlign(Label3,"center",false)
	guiSetFont(Label3,"default-bold-small")
	Guivar = 1
end)

addEventHandler("onClientColShapeLeave", Infocol,
function(hitElement)
	if(hitElement ~= gMe) then return end
	destroyElement(Fenster)
	Guivar = 0
end)

