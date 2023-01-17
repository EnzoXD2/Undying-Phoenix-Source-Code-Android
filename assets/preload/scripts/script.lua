--Sonic Exe Code Frame by Gavman22
--Rest by SuperSpeed
--Pause Hud Art by StolenMelly

local fakePaused = false
local cSelected = false
local rSelected = false
local eSelected = false
local curDadHeyTimer = null
local curGfHeyTimer = null
local curBfHeyTimer = null
local unpausingRn = false
local drowning = false
local jump = false
local jumpscare = ''

function onCreate()
		if getPropertyFromClass('PlayState', 'chartingMode') == false then
			--Custom Menus on characters
			if dadName == 'LordXDS' then
				makeLuaSprite('jumpscare', 'pauseScreen/timeOut/lordx', 0, 0)
				makeLuaSprite('pauseLeft', 'pauseScreen/lordX/pauseLeft', -800, 0)
				makeLuaSprite('pauseRight', 'pauseScreen/lordX/pauseRight', 800, 0)
				makeLuaSprite('pauseBG', 'pauseBGS/lordxBG', 0, 0)
				jumpscare = 'lordx'
			elseif dadName == 'majin' then
				makeLuaSprite('jumpscare', 'pauseScreen/timeOut/majin', 0, 0)
				makeLuaSprite('pauseLeft', 'pauseScreen/majin/pauseLeft', -800, 0)
				makeLuaSprite('pauseRight', 'pauseScreen/majin/pauseRight', 800, 0)
				makeLuaSprite('pauseBG', 'pauseBGS/majinBG', 0, 0)
				jumpscare = 'majin'
			else 
				makeLuaSprite('jumpscare', '', 0, 0)
				makeLuaSprite('pauseLeft', 'pauseScreen/pauseLeft2', -800, 0)
				makeLuaSprite('pauseRight', 'pauseScreen/pauseRight2', 800, 0)
				makeLuaSprite('pauseBG', 'pauseScreen/pauseBG2', 0, 0)
				jumpscare = 'xanthus'
			end
			if dadName == 'sunky' then
				jumpscare = 'sunky'
			end
			if dadName == 'none' then
				jumpscare = 'none'
				makeLuaSprite('jumpscare', 'pauseScreen/timeOut/nominal', 0, 0)
			end
			addLuaSprite('pauseBG', true)
			setObjectCamera('pauseBG', 'camOther')
			doTweenAlpha('bgGone', 'pauseBG', 0, 0.001, 'linear')

			-- Pause Sounds
			precacheSound('pauseSounds/pause')
			precacheSound('pauseSounds/pauseScrollMenu')
			precacheSound('pauseSounds/unpause')
			precacheSound("pauseSong")
			playSound("pauseSong", 1, 'song')
			pauseSound('song')

			--Spawn Shit
			addLuaSprite('pauseRight', true)
			setObjectCamera('pauseRight', 'camOther')
			addLuaSprite('pauseLeft', true)
			setObjectCamera('pauseLeft', 'camOther')
			makeLuaSprite('fakeTimeBar', '', -1007, 203)
			makeGraphic('fakeTimeBar', 390, 11, 'FFFFFF')
			addLuaSprite('fakeTimeBar', true)
			setObjectCamera('fakeTimeBar', 'camOther')
			makeLuaSprite('continue', 'pauseScreen/Continue', 800, -20)
			addLuaSprite('continue', true)
			setObjectCamera('continue', 'camOther')
			makeLuaSprite('restart', 'pauseScreen/Restart', 800, -20)
			addLuaSprite('restart', true)
			setObjectCamera('restart', 'camOther')
			makeLuaSprite('exist', 'pauseScreen/Exit', 800, -20)
			addLuaSprite('exist', true)
			setObjectCamera('exist', 'camOther')

			--Character Specific Pause Art
			makeLuaSprite('pauseArt', dadName, -800, 250)
			addLuaSprite('pauseArt', true)
			scaleObject('pauseArt', 0.9, 0.9)
			setObjectCamera('pauseArt', 'camOther')

		end
end
function onCreatePost()
	if getPropertyFromClass('PlayState', 'chartingMode') == false then
		makeAnimatedLuaSprite('pauseIcon', nil, -800, 140)
		loadGraphic('pauseIcon', 'icons/icon-'..getProperty('boyfriend.healthIcon'), 150)
		addAnimation('pauseIcon', 'icon/icon-'..getProperty('boyfriend.healthIcon'), {0, 1}, 0, true)
		setObjectCamera('pauseIcon', 'other')
		addLuaSprite('pauseIcon')
		setObjectOrder('pauseIcon', getObjectOrder('pauseLeft')+1)
		setProperty('pauseIcon.angle', 0)
	end
end

--Changes PauseArt on characterChange
function onEvent(N, chartype, char)
    if N == 'Change Character' then
        if chartype == 'gf' then
        elseif chartype == 'dad' or chartype == '1' then
            removeLuaSprite('pauseArt',true)
			makeLuaSprite('pauseArt', dadName, -800, 250)
			addLuaSprite('pauseArt', true)
			scaleObject('pauseArt', 0.9, 0.9)
			setObjectCamera('pauseArt', 'camOther')
        end
    end
end

-- If charting no custom pause
function onUpdate(elapsed)
	if getPropertyFromClass('PlayState', 'chartingMode') == false then
		if keyJustPressed('pause') and fakePaused == false and canPause == true and unpausingRn == false then
			openCustomSubstate('pauseMenu', true)
		end
		if inCutscene then
			canPause = false
		end
		if inGameOver then
			canPause = false
		else
			canPause = true
		end
	end
end

--Reveals shit
function onCustomSubstateCreate(tag)
	if tag == 'pauseMenu' then
		setPropertyFromClass("openfl.Lib","application.window.title","Don't make me Wait")
		if (isStoryMode) then
			changePresence('Paused - Story Mode', getProperty(songName), 'dad.healthIcon', true, '')
		else
			changePresence('Paused - Freeplay', getProperty(songName), 'dad.healthIcon', true, '')
		end
		resumeSound('song')
		runTimer('drowning', 113.3, 1) --normal time is 113.3
		runTimer('warning', 76.7, 1) --normal time is 76.7
		playSound('pauseSounds/pause', 0.8, 'pause')
		doTweenX('pauseRightTween', 'pauseRight', 0, 0.2, 'linear')
		doTweenAlpha('bgSpawb', 'pauseBG', 1, 0.2, 'linear')
		doTweenX('pauseLeftTween', 'pauseLeft', 0, 0.2, 'linear')
		doTweenX('fakeTimeBarTween', 'fakeTimeBar', 207, 0.2, 'linear')
		doTweenX('pauseIconTween7', 'pauseIcon', 65, 0.2, 'linear')
		doTweenX('pauseArtTween', 'pauseArt', 50, 0.2, 'linear')
		doTweenAngle('pauseIconTweenAng', 'pauseIcon', 0, 0.2, 'linear')
		
		doTweenX('cTween', 'continue', 20, 0.2, 'linear')
		doTweenX('rTween', 'restart', 20, 0.2, 'linear')
		doTweenX('eTween', 'exist', 20, 0.2, 'linear')
		cSelected = true
		rSelected = false
		eSelected = false
		fakePaused = true
	end
end

function onCustomSubstateUpdate(tag)
	if tag == 'pauseMenu' then
		if keyJustPressed('accept') and fakePaused == true and canPause == true and unpausingRn == false then
			plsHelp()
		end
		if cSelected == false then
			setProperty('continue.y', -20)
		end
		if cSelected == true then
			doTweenY('cTweenY', 'continue', -25, 0.07, 'circInOut')
		end
		if rSelected == false then
			setProperty('restart.y', -20)
		end
		if rSelected == true then
			doTweenY('rTweenY', 'restart', -25, 0.07, 'circInOut')
		end
		if eSelected == false then
			setProperty('exist.y', -20)
		end
		if eSelected == true then
			doTweenY('eTweenY', 'exist', -25, 0.07, 'circInOut')
		end
		scaleObject('fakeTimeBar', 1 * getProperty("songPercent"), 1)
		damnIWannaDie()
	end
end

--Menu Scroll shit
function damnIWannaDie()
	if keyJustPressed('down') and fakePaused == true and jump == false then
		if cSelected == true then
			cSelected = false
			rSelected = true
			playSound('pauseSounds/pauseScrollMenu', 1, 'pausescroll')
		elseif rSelected == true then
			rSelected = false
			eSelected = true
			playSound('pauseSounds/pauseScrollMenu', 1, 'pausescroll')
		elseif eSelected == true then
			eSelected = false
			cSelected = true
			playSound('pauseSounds/pauseScrollMenu', 1, 'pausescroll')
		end
	elseif keyJustPressed('up') and fakePaused == true and jump == false then
		if cSelected == true then
			cSelected = false
			eSelected = true
			playSound('pauseSounds/pauseScrollMenu', 1, 'pausescroll')
		elseif rSelected == true then
			rSelected = false
			cSelected = true
			playSound('pauseSounds/pauseScrollMenu', 1, 'pausescroll')
		elseif eSelected == true then
			eSelected = false
			rSelected = true
			playSound('pauseSounds/pauseScrollMenu', 1, 'pausescroll')
		end
	end
end

--Hides shit
function plsHelp()
	if cSelected == true then
		setPropertyFromClass("openfl.Lib","application.window.title","Friday Night Funkin': Psych Engine")
		pauseSound('song')
		cancelTimer('drowning')
		cancelTimer('warning')
		stopSound('drowning')
		playSound('pauseSounds/unpause', 0.5, 'unpause')
		doTweenAlpha('bgGone', 'pauseBG', 0, 0.2, 'linear')
		doTweenX('pauseRightTween2', 'pauseRight', 800, 0.2, 'linear')
		doTweenX('pauseLeftTween2', 'pauseLeft', -800, 0.2, 'linear')
		doTweenX('pauseArtTween2', 'pauseArt', -800, 0.2, 'linear')
		doTweenX('fakeTimeBarTween2', 'fakeTimeBar', -800, 0.2, 'linear')
		doTweenX('cTween2', 'continue', 800, 0.2, 'linear')
		doTweenX('rTween', 'restart', 800, 0.2, 'linear')
		doTweenX('eTween', 'exist', 800, 0.2, 'linear')
		doTweenX('pauseIconTween', 'pauseIcon', -800, 0.2, 'linear')
		doTweenAngle('pauseIconTweenAng', 'pauseIcon', 180, 0.2, 'linear')
		cSelected = false
		rSelected = false
		eSelected = false
	elseif rSelected == true then
		playSound('pauseSounds/unpause', 0.5, 'unpause')
		setPropertyFromClass("openfl.Lib","application.window.title","Friday Night Funkin': Psych Engine")
		restartSong(true);
	elseif eSelected == true then
		playSound('pauseSounds/unpause', 0.5, 'unpause')
		setPropertyFromClass("openfl.Lib","application.window.title","Friday Night Funkin': Psych Engine")
		exitSong(true);
	end

	if drowning == true then
		stopSound('drowns')
		cancelTween('shakeArt1')
		cancelTween('shakeArt2')
		cancelTween('shakeArt3')
		cancelTween('shakeArt4')
		cancelTween('shakeArt5')
		cancelTween('shakeArt6')
		cancelTimer('fasterTween')
		cancelTimer('fastererTween')
		soundFadeIn('song', 0.005, 0, 1)
		pauseSound('song')
	end
end

function onPause()
	if getPropertyFromClass('PlayState', 'chartingMode') == false then
		return Function_Stop
	else
		return Function_Continue
	end
end

--Loops Song
function onSoundFinished(tag)
	if tag == 'song' then
		playSound('pauseSong', 1 , 'song')
	end
	if tag == 'drowns' then
		canPause = false
		cancelTween('shakeArt5')
		cancelTween('shakeArt6')
		jump = true
		if jumpscare == 'sunky' then
			playSound('jumpscares/sunk', 2, 'bruh')
			doTweenAlpha('sunkyNOOO', 'pauseArt', 0, 6, 'linear')
		else
			setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', true)
			if jumpscare == 'xanthus' then
				startVideo('xanthus_jumpscare')
				runTimer('end', 12, 1)
			elseif jumpscare == 'majin' then
				playSound('jumpscares/majinJS', 2, 'jumpscare')
			elseif jumpscare == 'lordx' then
				playSound('jumpscares/lordX_laugh', 2, 'jumpscare')
			elseif jumpscare == 'none' then
				playSound('jumpscares/ambiance', 2, 'jumpscare')
			end
			addLuaSprite('jumpscare', true)
			setObjectCamera('jumpscare', 'camOther')
			stopSound('song')
		end
	end
	if tag == 'jumpscare' then
		os.exit();
	end
	if tag == 'bruh' then
		loadSong('bird')
		setPropertyFromClass("openfl.Lib","application.window.title","Look what you did. He's gone and it's all your fault")
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'end' then
		os.exit();
	end
	if tag == 'warning' then
		setPropertyFromClass("openfl.Lib","application.window.title","This is your last warning.")
	end
	if tag == 'drowning' then
		drowning = true
		setPropertyFromClass("openfl.Lib","application.window.title","")
		soundFadeOut('song', 5, 0)
		doTweenX('shakeArt1', 'pauseArt', 10, 0.2, 'circInOut')
		playSound('drowns', 1, 'drowns')
		runTimer('fasterTween', 3, 1)
	end
	if tag == 'fasterTween' then
		cancelTween('shakeArt1')
		cancelTween('shakeArt2')
		doTweenX('shakeArt3', 'pauseArt', 10, 0.1, 'circInOut')
		runTimer('fastererTween', 4.5, 1)
	end
	if tag == 'fastererTween' then
		cancelTween('shakeArt3')
		cancelTween('shakeArt4')
		doTweenX('shakeArt5', 'pauseArt', 10, 0.05, 'linear')
	end
end

--Alt F4
function onTweenCompleted(tag)
	if tag == 'shakeArt1' then
		doTweenX('shakeArt2', 'pauseArt', 90, 0.2, 'circInOut')
	end
	if tag == 'shakeArt2' then
		doTweenX('shakeArt1', 'pauseArt', 10, 0.2, 'circInOut')
	end
	if tag == 'shakeArt3' then
		doTweenX('shakeArt4', 'pauseArt', 90, 0.1, 'circInOut')
	end
	if tag == 'shakeArt4' then
		doTweenX('shakeArt3', 'pauseArt', 10, 0.1, 'circInOut')
	end
	if tag == 'shakeArt5' then
		doTweenX('shakeArt6', 'pauseArt', 90, 0.05, 'linear')
	end
	if tag == 'shakeArt6' then
		doTweenX('shakeArt5', 'pauseArt', 10, 0.05, 'linear')
	end

	if tag == 'pauseIconTween' then
		unpausingRn = false
		fakePaused = false
		closeCustomSubstate()
	end
end