---------------------------------------------------------------------------------
--
-- Nitro shader
--
--
---------------------------------------------------------------------------------


-- This function will set the new color of the nitro
function updateNitroColor(r,g,b)
	if nitroShader then
		if r and g and b then
			engineApplyShaderToWorldTexture (nitroShader,"smoke")
			dxSetShaderValue (nitroShader, "gNitroColor", r/255, g/255, b/255 )
		end
	end
end

-- This function will reset the nitro back to the original
function resetNitroColor()
	if nitroShader then
		engineRemoveShaderFromWorldTexture(nitroShader,"smoke")
	end
end


addEventHandler("onClientResourceStart",resourceRoot,
function()
	nitroShader = dxCreateShader("shaders/nitro/nitro.fx")
	updateNitroColor(75,0,255)
end)
