---------------------------------|
-- 3D Text Funktion bei MuLTi! --|
---------------------------------|

function create3DText(text, x, y, z, r, g, b, thick, view, line, double, dr, dg, db)
z = z-0.3
createPickup(x, y, z, 3, 1239, 500)
addEventHandler("onClientRender", getRootElement(),
	function()
		local xp, yp, zp = getElementPosition( gMe )
		local x1, y1 = getScreenFromWorldPosition( x, y, z+0.5)
		if(getDistanceBetweenPoints3D(  x, y, z, xp, yp, zp ) < view) and (x1) then
			x1 = x1-40
			if(line == true) then
				if(isLineOfSightClear(x, y, z, xp, yp, zp, true, true, false, false, false, false, false)) then
					if(double == true) then
						dxDrawText (text, x1-1, y1 -1, x1-1, y1-1, tocolor ( dr, dg, db, 255 ), thick, "default-bold")
					end
					dxDrawText (text, x1, y1, x1, y1, tocolor ( r, g, b, 255 ), thick, "default-bold")
				end
			else
				if(double == true) then
					dxDrawText (text, x1-1, y1 -41, x1-1, y1-1, tocolor ( dr, dg, db, 255 ), thick, "default-bold")
				end
				dxDrawText (text, x1, y1, x1, y1, tocolor ( r, g, b, 255 ), thick, "default-bold")
			end
		end
	end)
end

-- Texte --

create3DText("Red Country News Reporter", 2271.1225585938, 50.255802154541, 26.484375, 0, 255, 0, 1.5, 50, true, true, 0, 0, 0)
create3DText("Yakuza", -77.632125854492, -359.84335327148, 1.4296875 , 0, 255, 0, 1.5, 50, true, true, 0, 0, 0)
create3DText("Red Country Police Department", 633.20672607422, -574.39202880859, 16.3359375 , 0, 255, 0, 1.5, 50, true, true, 0, 0, 0)
create3DText("Fahrschule", 1370.5267333984, 408.80395507813, 19.735668182373, 0, 255, 0, 1.5, 50, true, true, 0, 0, 0)

create3DText("Noobspawn", 270.052734375, -15.029965400696, 2.0660333633423, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)

create3DText("Schwarzes Brett Blueberry", 224.17422485352, -44.485458374023, 1.578125, 0, 200, 200, 1.2, 50, true, true, 50, 50, 50)
create3DText("Schwarzes Brett Montgomery", 1314.8294677734, 290.31860351563, 19.5546875, 0, 200, 200, 1.2, 50, true, true, 50, 50, 50)
create3DText("Schwarzes Brett Dillmore", 632.85205078125, -559.123046875, 16.3359375, 0, 200, 200, 1.2, 50, true, true, 50, 50, 50)

create3DText("Ankaeufer", 167.95755004883, -34.960422515869, 1.578125,255, 255, 0, 1.5, 50, true, true, 20, 20, 20)
--create3DText("Hier entsteht in kuerze etwas.", 357.61801147461, -92.490898132324, 1.3797740936279, 0, 255, 0, 1.5, 50, true, true, 20, 20, 20)
create3DText("Schmied", 662.59149169922, -683.70513916016, 15.65154838562, 255, 255, 0, 1.5, 50, true, true, 20, 20, 20)

create3DText("Bushaltestelle\nDillmore", 655.54010009766, -593.93133544922, 16.253309249878, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)
create3DText("Bushaltestelle\nBlueberry", 238.57955932617, -1.9719109535217, 2.3729372024536, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)
create3DText("Bushaltestelle\nRed Country", 1304.2667236328, -84.243118286133, 36.563926696777, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)
create3DText("Bushaltestelle\nMontgomery", 1335.9840087891, 311.49728393555, 19.5546875, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)
create3DText("Bushaltestelle\nPalomino Creek", 2287.8696289063, -68.247299194336, 26.484375, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)


create3DText("Parkplatz\nInformation", 189.81288146973, -323.85238647461, 1.578125, 0, 255, 255, 1.5, 50, true, true, 20, 20, 20)


-- -- -- 