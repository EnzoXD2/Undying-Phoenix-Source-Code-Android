function onCreate()
	makeLuaSprite("hiBar", "black"); makeLuaSprite("loBar", "black")
	scaleObject("hiBar", screenWidth, 1); scaleObject("loBar", screenWidth, 1)
	setProperty("hiBar.x", 0); setProperty("loBar.x", 0) --since the rescaling moved their pos, put them back in their place
	setObjectCamera("hiBar", "hud"); setObjectCamera("loBar", "hud")
	setObjectOrder("hiBar", 1); setObjectOrder("loBar", 2) --get em behind the arrows
	addLuaSprite("hiBar", true); addLuaSprite("loBar", true)
end

function onEvent(tag, p1, p2)
	if tag == "letterbox" then
		doTweenY("upperBarTween", "hiBar.scale", p1, p2, "cubeOut")
		doTweenY("lowerBarTween", "loBar.scale", p1, p2, "cubeOut")
	end
end
--extra offsets cuz it prevents the bar from accidentally showing the bg if it's too fast
function onUpdate()
	setProperty("hiBar.y", -40); setProperty("loBar.y", screenHeight - getProperty("loBar.height")+40)
	updateHitbox("hiBar"); updateHitbox("loBar")
end --20 lines pog