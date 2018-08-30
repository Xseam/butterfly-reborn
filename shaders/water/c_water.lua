--
-- c_water.lua
--

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			return
		end

		-- Create shader
		local myShader, tec = dxCreateShader ( "shaders/water/water.fx" )

		if not myShader then

		else


			-- Set textures
			local textureVol = dxCreateTexture ( "shaders/water/images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "shaders/water/images/cube_env256.dds" );
			dxSetShaderValue ( myShader, "sRandomTexture", textureVol );
			dxSetShaderValue ( myShader, "sReflectionTexture", textureCube );

			-- Apply to global txd 13
			engineApplyShaderToWorldTexture ( myShader, "waterclear256" )

			-- Update water color incase it gets changed by persons unknown
			setTimer(	function()
							if myShader then
								local r,g,b,a = getWaterColor()
								dxSetShaderValue ( myShader, "sWaterColor", r/255, g/255, b/255, a/255 );
							end
						end
						,100,0 )
		end
	end
)
