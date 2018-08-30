local boards = {}

boards[1] = createObject(7310, 123.439453125, -82.4892578125, 9.210000038147, 0, 0, 180) -- Blueberry
boards[2] = createObject(7301, 665.03997802734, -613.21002197266, 22.479999542236, 0, 0, 296) -- Dillmore
boards[3] = createObject(7301, 665.03997802734, -613.21002197266, 22.479999542236, 0, 0, 115)


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	for i = 1, #boards, 1 do
		if(i == 1) or (i == 2) then
			local board = engineLoadTXD("data/images/textures/vgsn_billboard.txd") 
			engineImportTXD(board, getElementModel(boards[i]) )
		elseif(i == 3) or (i == 4) then
			local board = engineLoadTXD("data/images/textures/vgsn_billboard.txd") 
			engineImportTXD(board, getElementModel(boards[i]) )
		end
	end
end)