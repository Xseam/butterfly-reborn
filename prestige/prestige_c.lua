local Guivar = 0

addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

function createPrestigeErstell()
if(Guivar == 1) then return end
Guivar = 1
showCursor(true)
guiSetInputMode("no_binds_when_editing")


		local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 344,262
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
		
		PREFenster = {}
		PREKnopf = {}
		PRELabel = {}
		PREEdit = {}

		PREFenster[1] = guiCreateWindow(836,446,234,222,"Prestige",false)
		PREKnopf[1] = guiCreateButton(13,185,87,25,"Abbrechen",false,PREFenster[1])
		PRELabel[1] = guiCreateLabel(17,83,51,17,"X, Y, Z:",false,PREFenster[1])
		guiSetFont(PRELabel[1],"default-bold-small")
		PRELabel[2] = guiCreateLabel(16,32,63,18,"Name: ",false,PREFenster[1])
		guiSetFont(PRELabel[2],"default-bold-small")
		PREEdit[1] = guiCreateEdit(64,27,119,27,"name",false,PREFenster[1])
		PREEdit[2] = guiCreateEdit(14,104,118,25,"x",false,PREFenster[1])
		PREEdit[3] = guiCreateEdit(14,131,118,25,"y",false,PREFenster[1])
		PREEdit[4] = guiCreateEdit(14,156,118,25,"z",false,PREFenster[1])
		PREKnopf[2] = guiCreateButton(140,129,81,28,"Meine Pos.",false,PREFenster[1])
		PRELabel[3] = guiCreateLabel(16,57,40,16,"Preis:",false,PREFenster[1])
		guiSetFont(PRELabel[3],"default-bold-small")
		PREEdit[5] = guiCreateEdit(64,57,119,27,"preis",false,PREFenster[1])
		PRELabel[4] = guiCreateLabel(187,60,32,22,"$",false,PREFenster[1])
		guiSetFont(PRELabel[4],"default-bold-small")
		PREKnopf[3] = guiCreateButton(107,185,87,25,"Erstellen",false,PREFenster[1])

	addEventHandler("onClientGUIClick", PREKnopf[2], -- Pos 
	function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(PREEdit[2], x)
		guiSetText(PREEdit[3], y)
		guiSetText(PREEdit[4], z)
	end, false)
		
	addEventHandler("onClientGUIClick", PREKnopf[3], -- Erstellen
	function()
		local name = guiGetText(PREEdit[1])
		local preis = tonumber(guiGetText(PREEdit[5]))
		local x = tonumber(guiGetText(PREEdit[2]))
		local y = tonumber(guiGetText(PREEdit[3]))
		local z = tonumber(guiGetText(PREEdit[4]))
		if(preis < 0) or (preis > 5000000) then outputChatBox("Ungueltiger Preis!", 200, 0, 0, false) return end
		if not(x) or not(y) or not(z) then return end
		if(name == "") or (name == " ") then outputChatBox("Ungueltiger Name!", 200, 0, 0, false) return end
		triggerServerEvent("onPrestigeErstell", gMe, name, preis, x, y, z)
	end, false)
		
	addEventHandler("onClientGUIClick", PREKnopf[1], -- Abbrechen
	function()
	Guivar = 0
	showCursor(false)
	guiSetVisible(PREFenster[1], false)
	end, false)
end

addCommandHandler("createprestige", 
function()
	if(tonumber(getElementData(gMe, "pAdminlevel")) < 4) then outputChatBox("Du bist nicht befugt.", 200, 0, 0, false) return end
	createPrestigeErstell()
end)

local scX, scY = guiGetScreenSize();
local l_w      = 64;
local l_h      = 64;
local l_ratio  = l_w / l_h;
local lscale_w = 1920 / scX;
l_w            = l_w / lscale_w;
l_h            = l_w / l_ratio;

local randomn = 0



addEventHandler( 'onClientRender', root, function()
  for i, v in ipairs( getElementsByType( 'colshape') ) do
    if getElementData( v, "PRESTIGE" ) == true then
      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
        local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
        if dist >= 5 and dist <= 35 then
          local px, py = getScreenFromWorldPosition( x, y, z + 1.3, 0.06 );
          if px then

		 
            if getElementData( v, "PBESITZER" ) == "0" or getElementData( v, "PBESITZER" ) == " " or getElementData( v, "PBESITZER" ) == "" then

			  if randomn == 0 then
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h,'data/images/prestige/statue.png', 0, 0, 0 )              
			  dxDrawText( "Prestige zu verkaufen\nPreis: "..tonumber(getElementData(v, "PPREIS")).." $\nTippe /buyprestige um es zu kaufen.", px + 1, py + scY/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 0.5, schrift, 'center', 'center', false, false )
              dxDrawText( "Prestige zu verkaufen\nPreis: "..tonumber(getElementData(v, "PPREIS")).." $\nTippe /buyprestige um es zu kaufen.", px, py + scY/38, px, py, tocolor( 255, 255, 255, 255 ), 0.5, schrift, 'center', 'center', false, false )
			 elseif randomn == 1 then
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h, 'data/images/prestige/industry.png', 0, 0, 0 )
			  dxDrawText( "Prestige zu verkaufen\nPreis: "..tonumber(getElementData(v, "PPREIS")).." $\nTippe /buyprestige um es zu kaufen.", px + 1, py + scY/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 0.5, schrift, 'center', 'center', false, false )
              dxDrawText( "Prestige zu verkaufen\nPreis: "..tonumber(getElementData(v, "PPREIS")).." $\nTippe /buyprestige um es zu kaufen.", px, py + scY/38, px, py, tocolor( 255, 255, 255, 255 ), 0.5, schrift, 'center', 'center', false, false )
			 
			 end
			  
           else
              dxDrawText( "Prestige in Besitz von\n"..getElementData(v, "PBESITZER"), px + 1, py + scY/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 0.5, schrift, 'center', 'center', false, false )
              dxDrawText( "Prestige in Besitz von\n"..getElementData(v, "PBESITZER"), px, py + scY/38, px, py, tocolor( 255, 255, 255, 255 ), 0.5, schrift, 'center', 'center', false, false )
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h, 'data/images/prestige/soldout.png', 0, 0, 0);	
			end

			end
        end
      end
    end
  end
end )


setTimer(
function()
if(randomn == 0) then
randomn = 1 
elseif(randomn == 1) then
randomn = 0 
end
end, 2500, 0)

schrift = dxCreateFont( "data/prestigeFont.ttf", 20 )   