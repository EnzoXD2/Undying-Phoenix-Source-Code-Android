function onCreatePost()
	initLuaShader("scroll")
	setSpriteShader('Fog',"scroll")
	
end

function onStepHit()
	if curStep == 1312 then
		setSpriteShader('treeTop',"scroll")
		setSpriteShader('treeTop2',"scroll")
		
	end
end

function onUpdate()
	setShaderFloat("Fog", "iTime", os.clock())
	setShaderFloat("treeTop", "iTime", os.clock())
	setShaderFloat("treeTop2", "iTime", os.clock())
end


-- to set the x or y speed u have to change it within the shader