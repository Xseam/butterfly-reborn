local Baustellenvar = 0

function erstelleBaustelle_func()
	if(Baustellenvar == 1) then return end
	Baustellenvar = 1
	local randomvar = math.random(0, 3)
	if(randomvar == 0) then
		Title = "Montgomery"
		Bearbeitungszeit = (math.random(5, 15)*60000)
		local Objekt1 = createObject(6964, 1324.3000488281, 309.5, 17.60000038147, 0, 0, 0)
		local Objekt2 = createObject(6964, 1315.5, 312.39999389648, 17.610000610352, 0, 0, 0)
		local Objekt3 = createObject(3515, 1313.6999511719, 311.89999389648, 16.700000762939, 336.75, 0, 280)
		local Objekt4 = createObject(4526, 1324.4000244141, 309.70001220703, 20.39999961853, 0, 0, 0)
		local Objekt5 = createObject(4526, 1311.8000488281, 317.70001220703, 20.39999961853, 0, 0, 182)
		local Objekt6 = createObject(981, 1324.5999755859, 325.10000610352, 19.5, 0, 0, 150)
		local Objekt7 = createObject(981, 1311.5, 302.79998779297, 19.5, 0, 0, 323.99633789063)
 		
		setTimer(
			function()
			destroyElement(Objekt1)
			destroyElement(Objekt2)
			destroyElement(Objekt3)
			destroyElement(Objekt4)
			destroyElement(Objekt5)
			destroyElement(Objekt6)
			destroyElement(Objekt7)
			Baustellenvar = 0
		end, Bearbeitungszeit, 1)
		
	elseif(randomvar == 1) then
			Title = "Blueberry"
			Bearbeitungszeit = (math.random(5, 15)*60000)
			local Objekt1 = createObject(3865, 229, -74.099998474121, 2.4000000953674, 0, 0, 20)
			local Objekt2 = createObject(3865, 232.39999389648, -72.400001525879, 3.5999999046326, 32, 0, 109.99514770508)
			local Objekt3 = createObject(18248, 233, -74.900001525879, 8.5, 0, 0, 320)
			local Objekt4 = createObject(4526, 234.60000610352, -78.800003051758, 2.5, 0, 0, 310)
			local Objekt5 = createObject(4526, 228.69999694824, -66.099998474121, 2.5, 0, 0, 179.99572753906)
			local Objekt6 = createObject(3578, 242.39999389648, -54.900001525879, 1.3999999761581, 0, 0, 0)
			local Objekt7 = createObject(3578, 247.5, -69.5, 1.2000000476837, 0, 0, 80)
			

			setTimer(
				function()
				destroyElement(Objekt1)
				destroyElement(Objekt2)
				destroyElement(Objekt3)
				destroyElement(Objekt4)
				destroyElement(Objekt5)
				destroyElement(Objekt6)
				destroyElement(Objekt7)
				Baustellenvar = 0
			end, Bearbeitungszeit, 1)
			
		
		elseif(randomvar == 2) then
			Title = "Red Country"
			Bearbeitungszeit = (math.random(5, 15)*60000)
			local Objekt1 = createObject(4506, 2083.8000488281, 41.599998474121, 28.200000762939, 0, 0, 180)
			local Objekt2 = createObject(3865, 2105.8999023438, 41.099998474121, 27.299999237061, 0, 0, 40)
			local Objekt3 = createObject(18248, 2107.3000488281, 44.799999237061, 32.5, 0, 0, 280)

			setTimer(
				function()
				destroyElement(Objekt1)
				destroyElement(Objekt2)
				destroyElement(Objekt3)
				Baustellenvar = 0
			end, Bearbeitungszeit, 1)
			
		elseif(randomvar == 3) then
			Title = "Palomino Creek"
			Bearbeitungszeit = (math.random(5, 15)*60000)
			local Objekt1 = createObject(4509, 776.90002441406, -529.29998779297, 18.200000762939, 0, 0, 340)
			local Objekt2 = createObject(10444, 763.20001220703, -528.90002441406, 15.199999809265, 0, 0, 86)
			local Objekt3 = createObject(9833, 760.40002441406, -533.40002441406, 12, 0, 0, 0)
			local Objekt4 = createObject(9833, 762, -526.29998779297, 11.5, 0, 334, 30)
			local Objekt5 = createObject(4509, 735.5, -530.79998779297, 18.200000762939, 0, 0, 177.99938964844)


			setTimer(
				function()
				destroyElement(Objekt1)
				destroyElement(Objekt2)
				destroyElement(Objekt3)
				destroyElement(Objekt4)
				destroyElement(Objekt5)
				Baustellenvar = 0
		end, Bearbeitungszeit, 1)
		
	end
	outputChatBox("Baustellenwarnung: Eine Baustelle befindet sich in "..Title..".", getRootElement(),0, 255, 100, false)
	outputChatBox("Bearbeitungszeit: Etwa "..(Bearbeitungszeit/60000).." Minuten.", getRootElement(),0, 255, 100, false)
	outputChatBox("Wir bitten darum, dieses Gebiet zu Umfahren!", getRootElement(),0, 255, 100, false)	
	local stringr = "Baustelle in "..Title..", Zeit: "..(Bearbeitungszeit/60000).." Minuten"
	outputDebugString(stringr, 3, 255, 255, 0)
	outputServerLog(stringr)
end

local randomBaustellenzeit = math.random(1800000, 3000000)

setTimer(erstelleBaustelle_func, randomBaustellenzeit, 0)

addCommandHandler("settobaustelle",
function(thePlayer)
local name = getPlayerName(thePlayer)
if not(name == "MuLTi") then return end
erstelleBaustelle_func()
end)