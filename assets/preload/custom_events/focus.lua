--Hi! I'm Nick! I'm not the best coder but I try my best lol

local focus = { --I'd recommend not messing with these properties, except focus.bar.drain
	active = false, --so you can activate it mid-song
	canHit = true, --if you can hit enter
	cooldown = false, 
	bar = {
		value = 1, --current bar value, goes from 0 to pos.scale, changes starts off different if drain is off (scale because that's how resized tweens work ig)
		canMiss = 0, --how many notes you're allowed to miss, changes later
		pos = {x = 1155, y = 164, scale = 1.64}, --bar position, scale determines how big it is and how far the bar goes
		drain = false, --whether the bar drains or not, true = hard and broken, false = normal
		
		hitVal = 0.1, --how much focus you get when you press space on beat, changed if drain is false
		missVal = 0.20, --how much focus you lose when you use up a ring (miss a note), changed if drain is false
		
		lilHelper = false --I'd recommend not messing with this, used for covering up part of the bar
	},
	rings = {
		pos = {520, 580, 640}, --rings position
		states = {"collected", "collected", "collected"}, --current ring state, changes later
		sparkleToHide = {false, false, false} --temporary, changes later (make this be an array please)
	}
}

function onCreate()
	if (not focus.bar.drain) then focus.bar.missVal = focus.bar.pos.scale/5; focus.bar.hitVal = focus.bar.pos.scale/50 end --if drain is false, change deez
	focus.bar.value = focus.bar.pos.scale/5 --bar starts off at 1/5 (20%)
	precacheSound("ring")
	barCreate() --creating the bar
	doTweenY("barScaling", "focus_bar.scale", focus.bar.value, 1, "linear")
	--amogus sussy, starts our thing
end

function onEvent(tag, p1, p2)
	if tag == "focus" then
		if p1 == "activate" then 
			runTimer("activate_focus", 1.24)
			doTweenX("focusbartween", "focus_bar", focus.bar.pos.x, 1, "cubeOut")
			doTweenX("focusoutlinetween", "focus_outline", focus.bar.pos.x, 1, "cubeOut")
			doTweenX("percentagetween", "percentage", focus.bar.pos.x+30, 1, "cubeOut")
		elseif p1 == "deactivate" then 
			focus.active = false
			doTweenX("deactivateTweenOutline", "focus_outline", screenWidth, 1, "cubeIn")
			doTweenX("deactivateTweenBar", "focus_bar", screenWidth, 1, "cubeIn")	
			doTweenX("ring1Tween", "ring1", screenWidth, 1, "cubeIn")
			doTweenX("ring2Tween", "ring2", screenWidth, 1, "cubeIn")
			doTweenX("percentagetween", "percentage", screenWidth, 1, "cubeOut")
			setProperty("lilHelper.visible", false); updateHitbox("lilHelper")
		end
	end
end

function onUpdate()
	focusBar()
	missHandler()
	ringStateHandler()

	-- this little guy tells us how many misses we have, used for debugging purposes
	-- makeLuaText("cool", "canMiss: " .. focus.bar.canMiss, 500, 700)
	-- addLuaText("cool")

	if focus.active then
		if keyJustPressed("space") and (not focus.canHit) then --if the user hit space before he was allowed to, set a cooldown so yuo can't spam
			focus.cooldown = true
			doTweenColor("focusBarToGray", "focus_bar", "6B6B6B", 0.01) --darkening the bar while it cools down
			doTweenColor("focusOutToGray", "focus_outline", "6B6B6B", 0.01)
			doTweenColor("focusHlpToGray", "lilHelper", "6B6B6B", 0.01)
			runTimer("deactivate_cooldown", 0.5) --cooldown is half of a second
			
		elseif focus.canHit then --if space is hittable
			if keyJustPressed("space") and (not focus.cooldown) then --and you did hit it in time then
				setProperty("funi.alpha", 1) --scroll down to the barcreate func so you can understand why...
				doTweenAlpha("funiTween", "funi", 0, 0.32, "linear") --...it's called funi lol
				focus.bar.value = focus.bar.value + focus.bar.hitVal --up bar value
			end
		end
	end
end

function onBeatHit()
	if focus.active then
		if focus.bar.drain then focus.bar.value = focus.bar.value - focus.bar.pos.scale/40 end --decrease bar value per beat if drain is true
		focus.canHit = true --allow the user to hit space
		runTimer("deactivate_canHit", 0.164) --I like 64
	end
end

--all of these are pretty self explanatory so I won't comment on them
function onTimerCompleted(tag, loops, loopsleft)
	if tag == "deactivate_canHit" then --runs a bit after beatHit gets called
		focus.canHit = false 
		doTweenY("barScaling", "focus_bar.scale", focus.bar.value, 0.5, "linear") --update bar
		setTextString("percentage", strSplit(tostring(focus.bar.value/focus.bar.pos.scale*100), ".")[1] .. "%") --percentage text!
	--quite a wild ride, I know, but basically it gets how much % you have, turns it into a string, splits it based on the "." (cuz decimal) so it's not a HUGE number and only displays what's behind the "."
	end
	
	if tag == "deactivate_cooldown" then
		doTweenColor("focusBarToGray", "focus_bar", "FFFFFF", 0.12) --setting the bar color back to normal
		doTweenColor("focusOutToGray", "focus_outline", "FFFFFF", 0.12)
		doTweenColor("focusHlpToGray", "lilHelper", "FFFFFF", 0.12)
		focus.cooldown = false
	end
	
	if tag == "activate_focus" then
		focus.active = true
	end
end

function onSoundFinished(tag) --once the ring sound finishes, hide the sparkle effect
	if tag == "ringSound" then 
		local index = focus.rings.sparkleToHide
		for key in pairs({1, 2, 3}) do
			if index[key] == true then
				setProperty("sparkle" .. key .. ".visible", false); updateHitbox("sparkle" .. key) 
			end
		end
		index = nil
	end 
end

function noteMiss(id, direction, noteType, isSustainNote) --if it's broken, add "and (not isSustainNote)""
	if focus.bar.canMiss > 0 then --in case you're allowed a miss:
		addMisses(-1) --undo miss
		addScore(10) --undo score decrease
		addHealth(0.0475) --undo health loss
		focus.bar.canMiss = focus.bar.canMiss - 1 --take away a free miss
		focus.bar.value = focus.bar.value - focus.bar.missVal --decrease a lot
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if (not isSustainNote) then focus.bar.canMiss = focus.bar.canMiss + 1 end
end


--separator oooo--


function barCreate()
	makeLuaSprite("focus_outline", "focus/focus_outline", screenWidth, focus.bar.pos.y) --making the sprites
	makeLuaSprite("focus_bar", "focus/focus_bar", screenWidth, focus.bar.pos.y) -- it's +50 cuz the offsetting isn't right in the og image
	
	setObjectCamera("focus_outline", "hud"); setObjectCamera("focus_bar", "hud") --hudding them
	scaleObject("focus_outline", focus.bar.pos.scale, focus.bar.pos.scale)
	scaleObject("focus_bar", focus.bar.pos.scale, focus.bar.pos.scale) --scaling them
	setProperty("focus_bar.antialiasing", false); setProperty("focus_outline.antialiasing", false) --if antialias is on it doesn't get pixelated properly and that sucks, so i disabled it
	updateHitbox("focus_bar"); updateHitbox("focus_outline")
	
	makeLuaSprite("funi", "focus/focus_eye", 1, 1) --thing was name funi cuz it was a funi pic before, it's gone now tho
	screenCenter("funi") --i don't really feel like changing the tag though so I'll keep it as funi
	setObjectCamera("funi", "hud")
	addLuaSprite("funi")
	setProperty("funi.alpha", 0); updateHitbox("funi")
	
	makeLuaText("percentage", "25%", 64, screenWidth, focus.bar.pos.y + getProperty("focus_outline.height")-5) --percentage of how much u have
	addLuaText("percentage")
	
	for i in pairs({1, 2, 3}) do --making a for loop so I don't have do re-do all of these lines, since I have 2 rings
		makeAnimatedLuaSprite("ring" .. i, "focus/spin", screenWidth, focus.rings.pos[i])
		addAnimationByPrefix("ring" .. i, "spinny", "Symbol", 24)
		makeAnimatedLuaSprite("sparkle" .. i, "focus/collect", 1188, focus.rings.pos[i])
		addAnimationByPrefix("sparkle" .. i, "collect", "Collect", 24, false)
		setObjectCamera("ring" .. i, "hud"); setObjectCamera("sparkle" .. i, "hud")
		scaleObject("ring" .. i, 1.32, 1.32); scaleObject("sparkle" .. i, 1.32, 1.32)
		addLuaSprite("ring" .. i, true); addLuaSprite("sparkle" .. i, true)
		setProperty("sparkle" .. i .. ".visible", false); updateHitbox("sparkle" .. i)
	end --ring 1 is upper ring, ring 2 is lower ring
	
	makeLuaSprite("lilHelper", "focus/focus_bar", focus.bar.pos.x, focus.bar.pos.y + getProperty("focus_bar.height") - 84)
	setObjectCamera("lilHelper", "hud")
	scaleObject("lilHelper", focus.bar.pos.scale, 0.2)
	setProperty("lilHelper.antialiasing", false); setProperty("lilHelper.visible", false)
	updateHitbox("lilHelper")
	addLuaSprite("focus_bar", true); addLuaSprite("lilHelper", true); addLuaSprite("focus_outline", true) --adding the bar stuff
end

function focusBar()		
	local percent = focus.bar.value/focus.bar.pos.scale*100 --current bar percentage
	if percent >= 10 then --if bar is over 10%
		setProperty("focus_bar.y", getProperty("focus_outline.y") + getProperty("focus_outline.height") - getProperty("focus_bar.height")-16) --move it down a little bit so it doesn't go off the outline
		updateHitbox("focus_bar")
	else --else if bar is LOWER than the above percentage
		setProperty("focus_bar.y", getProperty("focus_outline.y") + getProperty("focus_outline.height") - getProperty("focus_bar.height")-23) --I'm dumb, you have NO idea how long I took to get the offsetting right
		--this -23 is so that when the value is below 15% it doesn't tween under the outline/meter
		updateHitbox("focus_bar") --but basically the line above keeps the green bar in its place, grounded
		--dang i hate how scaling tweens work
	end
	
	--In case the bar is over 50% and lilHelper is false, make it true, otherwise make it false
	if percent > 50 and (not focus.bar.lilHelper) then focus.bar.lilHelper = true 
	elseif percent < 25 and focus.bar.lilHelper then focus.bar.lilHelper = false end

	if focus.bar.lilHelper then setProperty("lilHelper.visible", true) else setProperty("lilHelper.visible", false) end
	updateHitbox("lilHelper")
	
	if focus.bar.value >= focus.bar.pos.scale then focus.bar.value = focus.bar.pos.scale elseif focus.bar.value <= 0 then focus.bar.value = 0 end --if bar is over max value then keep it at max value, and if it's below 0 set it to 0
end

function missHandler() --handles how the misses affect the canMiss variable
	local percent = focus.bar.value/focus.bar.pos.scale*100 --current bar percentage
	if percent == 100 then --if our bar is at 100%
		if focus.bar.canMiss > 3 then focus.bar.canMiss = 3 end --don't let it go past 3
	elseif percent >= 75 then --if our bar is at 75%
		if focus.bar.canMiss > 2 then focus.bar.canMiss = 2 end --don't let it go past 2
	elseif percent >= 50 then --if our bar is at 50%
		if focus.bar.canMiss > 1 then focus.bar.canMiss = 1 end --don't let it go past 1
	elseif percent < 50 then --if our bar is less than 50%
		if focus.bar.canMiss > 0 then focus.bar.canMiss = 0 end --don't let it go past 0 
	end
	percent = nil --freeing
end

function ringStateHandler() --handles ring state
	--there are 2 states for each ring: spinning and collected
	for i in pairs({1, 2, 3}) do --1 loop for each ring
		if focus.rings.states[i] == "spinning" then
			if focus.bar.canMiss == i-1 then --checks if you have freebies
				ringCollect(i)
			end
		
		elseif focus.rings.states[i] == "collected" then --check for ring state
			if focus.bar.canMiss == i then --if canMiss is 1 then do the code below for ring 1, and so on for canMiss 2
				focus.rings.states[i] = "spinning" --set ring state to spinning
				playAnim("ring" .. i, "spinny") --play the spinning animation
				doTweenX("ringtween".. i, "ring" .. i, focus.bar.pos.x + getProperty("focus_outline.width")/2/2+5, 1, "cubeOut") --tween it to the screen, funny math cuz booboo
			end
		end

		--stupid check because my code isn't working and sometimes the rings don't disappear properly
		--sorry i really don't know what's causing this :C
		local percent = focus.bar.value/focus.bar.pos.scale*100 
		if percent < 100 and getProperty("ring3.x") ~= screenWidth then --if percent is less than 75 but ring2 is still onscreen
			ringCollect(3)
		end
		if percent < 75 and getProperty("ring2.x") ~= screenWidth then --if percent is less than 75 but ring2 is still onscreen
			ringCollect(2)
		end
		if percent < 50 and getProperty("ring" .. i .. ".x") ~= screenWidth then
			ringCollect(i)
		end
		percent = nil
	end

end --HOLY CRAB IT ACTUALLY WORKED FIRST TRY??? WHAT???!????!??!??!1111
--I am fr surprised lmao

function ringCollect(ring)
	focus.rings.states[ring] = "collected"
	setProperty("sparkle" .. ring .. ".visible", true); updateHitbox("sparkle" .. ring) --make sparkle visible
	focus.rings.sparkleToHide[ring] = true --tells the onSoundFinished() function which sparkle to hide
	doTweenX("ring" .. ring .. "tween", "ring" .. ring, screenWidth, 0.001, "linear") --shoot ring offscreen
	playAnim("sparkle" .. ring, "collect") --play its animation
	playSound("ring", 1, "ringSound") --sound, volume, tag
end

function strSplit(inputstr, sep) --splits a string
	if sep == nil then
		sep = "%s"
	end
	
	local t={}
	
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	
	return t
end

--So, I realized I could have done this whole thing way better if I used another invisible object as a reference for the bar position, instead of the meter outline, I had to code in a lot of extra lines just cuz I was dumb
--I'm too lazy to redo everything though, so I'll keep it like this
--So don't be dumb like me, think over your code before you start actually doing anything!