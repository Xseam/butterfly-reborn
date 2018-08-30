local Guivar = 0

function createHausErstellenGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")

	local HAUSFenster = {}
	local HAUSKnopf = {}
	local HAUSLabel = {}
	local HAUSEdit = {}

		local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 391,253
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)

	HAUSFenster[1] = guiCreateWindow(X, Y, Width, Height, "Create a Haus",false)
	HAUSKnopf[1] = guiCreateButton(17,216,84,24,"Abbrechen",false,HAUSFenster[1])
	HAUSKnopf[2] = guiCreateButton(249,217,84,24,"Haus erstellen",false,HAUSFenster[1])
	HAUSLabel[1] = guiCreateLabel(10,29,53,16,"X, Y, Z:",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[1],"default-bold-small")
	HAUSEdit[1] = guiCreateEdit(10,47,122,23,"x",false,HAUSFenster[1])
	HAUSEdit[2] = guiCreateEdit(10,73,122,23,"y",false,HAUSFenster[1])
	HAUSEdit[3] = guiCreateEdit(10,98,122,23,"z",false,HAUSFenster[1])
	HAUSKnopf[3] = guiCreateButton(24,128,97,29,"Meine Position",false,HAUSFenster[1])
	HAUSLabel[2] = guiCreateLabel(226,33,82,19,"Interior:",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[2],"default-bold-small")
	HAUSEdit[4] = guiCreateEdit(224,50,56,19,"int",false,HAUSFenster[1])
	HAUSLabel[3] = guiCreateLabel(227,71,56,23,"INT X, Y, Z:",false,HAUSFenster[1])
	HAUSEdit[5] = guiCreateEdit(224,88,122,23,"xi",false,HAUSFenster[1])
	HAUSEdit[6] = guiCreateEdit(224,114,122,23,"yi",false,HAUSFenster[1])
	HAUSEdit[7] = guiCreateEdit(225,139,122,23,"zi",false,HAUSFenster[1])
	HAUSLabel[4] = guiCreateLabel(227,167,80,25,"Preis:",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[4],"default-bold-small")
	HAUSEdit[8] = guiCreateEdit(226,191,122,23,"preis",false,HAUSFenster[1])
	guiEditSetMaxLength(HAUSEdit[8],9999)
	HAUSLabel[5] = guiCreateLabel(354,195,23,19,"$",false,HAUSFenster[1])
	HAUSLabel[6] = guiCreateLabel(7,168,217,17,"Typ: (0 = Klein, 1 = Normal, 2 = Gross)",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[6],"default-bold-small")
	HAUSEdit[9] = guiCreateEdit(32,188,122,23,"typ",false,HAUSFenster[1])
	guiEditSetMaxLength(HAUSEdit[9],1)
	
	addEventHandler("onClientGUIClick", HAUSKnopf[2],
	function()
		local x, y, z, int, intx, inty, intz, preis, typ = tonumber(guiGetText(HAUSEdit[1])), tonumber(guiGetText(HAUSEdit[2])), tonumber(guiGetText(HAUSEdit[3])), tonumber(guiGetText(HAUSEdit[4])), tonumber(guiGetText(HAUSEdit[5])), tonumber(guiGetText(HAUSEdit[6])), tonumber(guiGetText(HAUSEdit[7])), tonumber(guiGetText(HAUSEdit[8])), tonumber(guiGetText(HAUSEdit[9]))
		if(typ < 1) or (typ > 3) then return end
		triggerServerEvent("onHausSystemCreateHaus", gMe, x, y, z, int, intx, inty, intz, preis, typ)
	end, false)
	
	
	addEventHandler("onClientGUIClick", HAUSKnopf[3],
	function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(HAUSEdit[1], x)
		guiSetText(HAUSEdit[2], y)
		guiSetText(HAUSEdit[3], z)
	end, false)
	
	addEventHandler("onClientGUIClick", HAUSKnopf[1],
	function()
		Guivar = 0
		guiSetVisible(HAUSFenster[1], false)
		showCursor(false)

	end, false)

end

addCommandHandler("createhaus", 
function()
if(tonumber(getElementData(gMe, "pAdminlevel")) < 4) then return end
createHausErstellenGui()
end)


local scX, scY = guiGetScreenSize();
local l_w      = 64;
local l_h      = 64;
local l_ratio  = l_w / l_h;
local lscale_w = 1920 / scX;
l_w            = l_w / lscale_w;
l_h            = l_w / l_ratio;



addEventHandler( 'onClientRender', root, function()
  for i, v in ipairs( getElementsByType( 'pickup', getResourceRootElement(), true ) ) do
    if getElementData( v, "HAUS" ) == true then
      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v ) then
        local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
        if dist >= 5 and dist <= 35 then
          local px, py = getScreenFromWorldPosition( x, y, z + 1.3, 0.06 );
          if px then

				dxDrawText( "Haus im Besitz von:\n"..getElementData(v, "HBESITZER").."\nPreis: "..tonumber(getElementData(v, "HPREIS")).." $\nMieter: "..getElementData(v, "HMIETER"), px + 1, py + scY/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 0.5, schrift, 'center', 'center', false, false )
              dxDrawText( "Haus im Besitz von:\n"..getElementData(v, "HBESITZER").."\nPreis: "..tonumber(getElementData(v, "HPREIS")).." $\nMieter: "..getElementData(v, "HMIETER"), px, py + scY/38, px, py, tocolor( 255, 255, 255, 255 ), 0.5, schrift, 'center', 'center', false, false )

			  if randomn == 0 then
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h,'data/images/prestige/statue.png', 0, 0, 0 )              
			 elseif randomn == 1 then
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h, 'data/images/prestige/industry.png', 0, 0, 0 )
			 
			 end
			  
			end
        end
      end
    end
  end
end )

schrift = dxCreateFont( "data/prestigeFont.ttf", 20 )   