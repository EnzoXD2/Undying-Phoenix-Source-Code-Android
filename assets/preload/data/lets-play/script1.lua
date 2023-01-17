songStarted = false
canSkip = true

function onCreate() --most of these are self explanatory, no need to comment, last 2 params are x and y
    --TODO, FIX ANIMATIONS TO TITLE, SPACE AND RING EXPLANATION
    canPause = false;
    makeLuaSprite("background", "focus/tutorial/MajinMenuBackground", 0, 0)
    makeAnimatedLuaSprite("boy", "focus/tutorial/FocusMajin", 0, 300) --won't be tweened, since boy starts off on-screen already
    addAnimationByPrefix("boy", "snap", "MAJINTHEBOY", 24, false)
    makeAnimatedLuaSprite("title", "focus/tutorial/Focus Title")
    addAnimationByPrefix("title", "anim", "focus", 24)
    makeAnimatedLuaSprite("spaceExplanation", "focus/tutorial/FocusSpace")
    addAnimationByPrefix("spaceExplanation", "anim", "SpaceBar", 15, false)
    makeAnimatedLuaSprite("ringExplanation", "focus/tutorial/FocusRings", screenWidth, 0)
    addAnimationByPrefix("ringExplanation", "anim", "RINGS", 24, false)
    makeAnimatedLuaSprite("ring", "focus/spin", screenWidth, 500)
    addAnimationByPrefix("ring", "spin", "Symbol", 24)

    precacheSound("Focus_Tutorial_inst")
    precacheSound("Focus_Tutorial_voices")

    scaleObject("boy", 0.5, 0.5)
    scaleObject("title", 0.64, 0.64)
    scaleObject("spaceExplanation", 0.64, 0.64)
    scaleObject("ringExplanation", 0.64, 0.64)
    scaleObject("ring", 2, 2)

    --setProperty("boy.antialiasing", false)
    --setProperty("title.antialiasing", false)
    --setProperty("spaceExplanation.antialiasing", false)
    --setProperty("ringExplanation.antialiasing", false)
    --setProperty("ring.antialiasing", false)

    screenCenter("title", "x")
    screenCenter("boy", "x")
    screenCenter("spaceExplanation", "y")
    screenCenter("ringExplanation", "y")

    setProperty("boy.x", getProperty("boy.x") + 40)
    setProperty("boy.y", getProperty("boy.y") + 45)
    setProperty("title.y", 0-getProperty("title.height"))
    setProperty("spaceExplanation.y", getProperty("spaceExplanation.y") + 100)
    setProperty("ringExplanation.y", getProperty("ringExplanation.y") + 100)
    setProperty("spaceExplanation.x", 0-getProperty("spaceExplanation.width"))
    setProperty("ring.y", getProperty("ringExplanation.y") + getProperty("ringExplanation.height"))

    setObjectCamera("background", "hud")
    setObjectCamera("boy", "hud")
    setObjectCamera("title", "hud")
    setObjectCamera("spaceExplanation", "hud")
    setObjectCamera("ringExplanation", "hud")
    setObjectCamera("ring", "hud")

    addLuaSprite("background", true)
	addLuaSprite("boy", true)
	addLuaSprite("title", true)
	addLuaSprite("spaceExplanation", true)
	addLuaSprite("ringExplanation", true)
    addLuaSprite("ring", true)
   -- setObjectOrder("ring", 10) --ring stays behind the bg for some odd reason

    playAnim("title", "anim")
    playAnim("spaceExplanation", "anim")
    playAnim("ringExplanation", "anim")
    playAnim("ring", "spin")
end

function onUpdate()
    if inCutscene then
        canSkip = false
    else
        canSkip = true
    end

    if (not songStarted) then
        if keyJustPressed("space") and canSkip then --press space to skip the tutorial screen
			if (not luaTextExists("hitSpace")) then
				makeLuaText("hitSpace", "hit space to skip tutorial", 300, -300, 650)
				setTextAlignment("hitSpace", "center")
				setTextItalic("hitSpace", true)
				setTextFont("hitSpace", "sonecFont.ttf")
				setTextSize("hitSpace", 24)
				addLuaText("hitSpace")
				doTweenX("moveSpaceText", "hitSpace", screenWidth, 3, "linear") 
			elseif luaTextExists("hitSpace") then
				songStarted = true
				startCountdown()
			end
        end
    end
end

function onStartCountdown()
    if (not songStarted and isStoryMode) then --if tutorial screen hasn't finished yet, or you didn't press space...
        tutorialScreenHandler() --... handle tutorial screen...    
        return Function_Stop --... and don't start the song
    else
        quitTutorialScreen()
        return Function_Continue
    end
end

function tutorialScreenHandler()
    --handle tutorial screen tweens here
    runTimer("startMUSIK", 0.3)
    runTimer("boySnap", 0.3, 0) --infinite timer 
    runTimer("title", 2.1)
    runTimer("space", 4.5)
    runTimer("ringE", 6.9)
    runTimer("ring", 9.3)
    --SWEET POTATOES IT TOOK ME SO LONG TO GET THE TIMING RIGHT HOLY COW
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == "startMUSIK" then
        playSound("Focus_Tutorial_inst", 1, "inst")
        playSound("Focus_Tutorial_voices", 1, "voices")
        runTimer("space+ringE_Anims", 0.3, 0)
    end
    if tag == "boySnap" then
        playAnim("boy", "snap")
    end
    if tag == "space+ringE_Anims" then
        playAnim("spaceExplanation", "anim")
        playAnim("ringExplanation", "anim")
    end
    if tag == "title" then
        doTweenY("titleTween", "title", getProperty("title.height")-244, 0.6, "cubeOut")
    end
    if tag == "space" then
        doTweenX("spaceTween", "spaceExplanation", getProperty("spaceExplanation.width")-250, 0.6, "cubeOut")
    end
    if tag == "ringE" then
        doTweenX("ringETween", "ringExplanation", screenWidth-getProperty("ringExplanation.width")+64, 0.6, "cubeOut")
    end
    if tag == "ring" then
        doTweenX("ringTween", "ring", getProperty("ringExplanation.x") + getProperty("ring.width") + 132, 1.6, "elasticOut")
    end
end

function onTweenCompleted(tag)
    if tag == "t2" then --DISABLE STUFFS
        runTimer("boyClap", 0.001) --stop the boy from clapping once he's disappeared
        runTimer("space+ringE_Anims", 0.001) --same for space and ring
        removeLuaSprite("background")
        removeLuaSprite("boy")
        removeLuaSprite("title")
        removeLuaSprite("spaceExplanation")
        removeLuaSprite("ringExplanation")
        removeLuaSprite("ring")
		removeLuaText("hitSpace")
    end 
	if tag == "moveSpaceText" then
		removeLuaText("hitSpace")
	end
end

function onSoundFinished(tag)
    if tag == "inst" then  --once the music finishes playing, start the countdown again and let the song start
        songStarted = true
        startCountdown()
    end
end

function quitTutorialScreen() --stop the music and make everyone disappear
    canPause = true;
    stopSound("inst")
    stopSound("voices")
    doTweenAlpha("t1", "background", 0, 1, "linear")
    doTweenAlpha("t2", "boy", 0, 1, "linear")
    doTweenAlpha("t3", "title", 0, 1, "linear")
    doTweenAlpha("t4", "spaceExplanation", 0, 1, "linear")
    doTweenAlpha("t5", "ringExplanation", 0, 1, "linear")
    doTweenAlpha("t6", "ring", 0, 1, "linear")
	doTweenAlpha("t7", "hitSpace", 0, 1, "linear")
end

--Hoi, I'm Nick
--This is a cool little tutorial screen I was asked to make, the idea is REALLY good
--Glad to be working on a team with such resolve to make their mod look good, keep going guys!