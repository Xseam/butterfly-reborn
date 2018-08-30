function txd ()
	pistoltxd = engineLoadTXD( "tazer/silenced.txd" ) 
	engineImportTXD( pistoltxd, 347 )
end 
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), txd )

function dff ()

	pistoldff = engineLoadDFF( "tazer/silenced.dff", 347 ) 
	engineReplaceModel ( pistoldff, 347 )

end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), dff )

function dff ()

	fbitruck = engineLoadDFF( "tazer/fbitruck.dff", 528 ) 
	engineReplaceModel ( fbitruck, 528 )

end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), dff )