function addBadEffect()
	if isTimer(badEffectTimer) then
	 killTimer(badEffectTimer)
	else
	 toogleBadEffect(true)
	end
badEffectTimer = setTimer(toogleBadEffect,1000,1,false)

end
addEventHandler('onClientPlayerChoke',root,addBadEffect)

local sx, sy = guiGetScreenSize()
interface = {}
local images = {}



local effectStates = {cl=1,sxx,syy,state=false}

function toogleBadEffect(state)
effectStates.state = state
end

function render()
		if effectStates.state then
			if effectStates.cl > 0.1 then
			 effectStates.cl = effectStates.cl - 0.01
			end
		 dxUpdateScreenSource(screen)
		 dxDrawImage(0,0,sx,sy,interface.shader)
		 effectStates.realState = true
		elseif effectStates.realState then
			if effectStates.cl < 1 then
			 effectStates.cl = effectStates.cl + 0.01
			else
			 effectStates.realState = false
			end
		 dxUpdateScreenSource(screen)
		 dxDrawImage(0,0,sx,sy,interface.shader)
		end
	local tick = getTickCount()
	dxSetShaderValue(interface.shader,'pX',1/sx*math.random(0,30)/10*(1/effectStates.cl)+sx*tick%30/10)
	dxSetShaderValue(interface.shader,'pY',1/sy*math.random(0,30)/10*(1/effectStates.cl)+sy*tick%30/10)
	--dxSetShaderValue(interface.shader,'cr',effectStates.cl)
	dxSetShaderValue(interface.shader,'cb',effectStates.cl)
	dxSetShaderValue(interface.shader,'cg',effectStates.cl)
end

addEventHandler('onClientResourceStart',resourceRoot,function()
	interface.shader = dxCreateShader('client/choke/shad.fx')
	screen = dxCreateScreenSource(sx,sy)
	dxUpdateScreenSource(screen)
	dxSetShaderValue(interface.shader,'screenSource',screen)
	dxSetShaderValue(interface.shader,'cr',1)
	dxSetShaderValue(interface.shader,'cg',1)
	dxSetShaderValue(interface.shader,'cb',1)
	dxSetShaderValue(interface.shader,'pX',1/sx)
	dxSetShaderValue(interface.shader,'pY',1/sy)
	addEventHandler('onClientHUDRender',root,render)
end)