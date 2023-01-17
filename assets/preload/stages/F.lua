local mountainParts = {}
function onCreate()
	-- background shit
	precacheImage('forever/F_treeTop')
	precacheImage('forever/F_stageStar')
	precacheImage('forever/F_Mountain')
	precacheImage('forever/F_Sky')
	precacheImage('forever/F_Moon')
	precacheImage('forever/F_Stors')
	precacheImage('forever/F_Fog')

	makeLuaSprite('forest', 'forever/F_Forest', -300, -70)
	addLuaSprite('forest', false)
	
	makeLuaSprite('treeTop', 'forever/F_ttsFront', -450, 750)
	scaleObject('treeTop', 1.25, 1)
	makeLuaSprite('treeTop2', 'forever/F_ttsBack', -450, 320)
	scaleObject('treeTop2', 1.25, 1)

	makeLuaSprite('sky', 'forever/F_Sky', -400, -270)
	scaleObject('sky', 1.5,1.2)
	setScrollFactor('sky', 0.7,0.7)
	
	makeLuaSprite('Moon', 'forever/F_Moon', -300, -160)
	setScrollFactor('Moon', 0.15, 0.15)

	makeLuaSprite('Stors', 'forever/F_Stors', -300, -160)
	setScrollFactor('Stors', 0.25, 0.25)

	makeLuaSprite('Fog', 'forever/F_Fog', -500, -170)
	setScrollFactor('Fog', 1.3, 1.3)
	scaleObject('Fog', 1.5,1.3)
	
	makeLuaSprite('Mountain', 'forever/F_Mountain', -350, -70)
	scaleObject('Mountain', 1.1,1.35)
	
	makeLuaSprite('carpetRide', 'forever/F_stageStar', -950, 670)
	scaleObject('carpetRide', 1.8,1.1)
	mountainParts = {'sky', 'Moon', 'Stors', 'Fog', 'Mountain'}
end

function onCreatePost()
	setProperty('gf.visible', false)
	setProperty('timeBar.color', getColorFromHex('3D9EE2'))
    doTweenColor('score', 'scoreTxt', '5ab5f5', 0.01)
    doTweenColor('time', 'timeTxt', '5ab5f5', 0.01)
    doTweenColor('bot', 'botplayTxt', '5ab5f5', 0.01)
end

function onUpdate(elapsed)
	setTextString("botplayTxt", "Limited Fun")
	if curBeat >= 328 and curBeat <= 392 then
		songPos = getSongPosition()
		local currentBeat = (songPos/1000)*(bpm/80)
		doTweenY('starFly', 'carpetRide', 200-110*math.sin((currentBeat*0.25)*math.pi),0.001)
		doTweenY('dadFlyY', 'dad', 100-110*math.sin((currentBeat*0.25)*math.pi),0.001)
		doTweenY('bfFlyY2', 'boyfriend', 220-110*math.sin((currentBeat*0.25)*math.pi),0.001)
	end
end

function onStepHit()
	if curStep == 1306 then
		setProperty('defaultCamZoom', 1)
		doTweenAlpha('stageGone', 'Mountain', 0, 1, 'linear')
		doTweenAlpha('bfGone', 'boyfriend', 0, 0.2, 'linear')
		doTweenAlpha('dadGone', 'dad', 0, 0.01, 'linear')
	end
	if curStep == 1308 then
		setProperty('defaultCamZoom', 2.5)
		doTweenX('moveOpp', 'dad', 100, 0.2, 'linear')
		doTweenX('moveBf', 'boyfriend', 870, 0.2, 'linear')
		addLuaSprite('carpetRide', false)
		doTweenX('movemoon', 'Moon', -2500, 70, 'linear')
	end
	if curStep == 1310 then
		setProperty('defaultCamZoom', 3)
	end
	if curStep == 1312 then
		setProperty('defaultCamZoom', 0.7)
		doTweenAlpha('bfSpawn', 'boyfriend', 1, 0.001, 'linear')
		doTweenAlpha('dadSpawn', 'dad', 1, 0.001, 'linear')
		addLuaSprite('treeTop', true);	
		addLuaSprite('treeTop2', false);
		setObjectOrder('treeTop2', getObjectOrder('dadGroup') - 2)
	end
end

function onBeatHit()
	if curBeat == 264 then
		setProperty('defaultCamZoom', 0.7)
		--adds mountain stuff
		for i = 0,5 do
			addLuaSprite(mountainParts[i], false);
		end
		setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') - 3)
		doTweenX('moveOpp', 'dad', 500, 0.001, 'linear');
		doTweenX('moveBf', 'boyfriend', 550, 0.001, 'linear');
		doTweenY('moveOpp2', 'boyfriend', 800, 0.001, 'linear');
		doTweenY('moveBf2', 'dad', -100, 0.001, 'linear');
		-- Fades Opponents notes
		for i = 0,3 do
			noteTweenAlpha('noteGoneOpp1'..i, i, 0, 0.2,"quartInOut")
		end
		doTweenAlpha('stageGone', 'healthBar', 0, 0.2, 'linear')
		doTweenAlpha('stageGone2', 'iconP1', 0, 0.2, 'linear')
		doTweenAlpha('stageGone3', 'iconP2', 0, 0.2, 'linear')
		doTweenColor('timeB', 'timeBar', '0000ff', 1)
		doTweenColor('score', 'scoreTxt', '0000ff', 1)
		doTweenColor('time', 'timeTxt', 'ffffff', 1)
		doTweenColor('bot', 'botplayTxt', '0000ff', 1)
	end
	if curBeat == 325 then
		doTweenY('dissapear', 'dad', 800, 0.5, 'linear')
		doTweenY('returnToSender3', 'forest', 1250, 0.001, 'linear')
		setProperty('timeBar.color', getColorFromHex('3D9EE2'))
		doTweenColor('timeB', 'timeBar', '3d9ee2', 1)
		doTweenColor('score', 'scoreTxt', '5ab5f5', 1)
		doTweenColor('time', 'timeTxt', '5ab5f5', 1)
		doTweenColor('bot', 'botplayTxt', '5ab5f5', 1)
	end
	if curBeat == 355 then
		doTweenY('movemountainY', 'Mountain', -340, 0.001, 'linear')
		doTweenX('movemountainX', 'Mountain', 1500, 0.001, 'linear')
	end
	if curBeat == 360 then
		setObjectOrder('Mountain', getObjectOrder('boyfriendGroup') - 5)
		setObjectOrder('forest', getObjectOrder('dadGroup') - 2)
		doTweenAlpha('stageGone3', 'Fog', 0, 2, 'linear')
		doTweenAlpha('stageAppear', 'Mountain', 1, 2, 'linear')
		doTweenX('movemountainX2', 'Mountain', -2500, 15, 'linear')
	end
	if curBeat == 388 then 
		setProperty('defaultCamZoom', 0.9)
		doTweenY('returnToSender', 'treeTop', -1200, 2.3, 'linear')
		doTweenY('returnToSender2', 'treeTop2', -1530, 2, 'linear')
		doTweenY('returnToSender3', 'forest', -70, 1.9, 'linear')
	end
	if curBeat == 389 then
		setObjectOrder('forest', getObjectOrder('dadGroup') - 1)
	end
	if curBeat == 391 then
		doTweenAlpha('carpetGone', 'carpetRide', 0, 0.2, 'linear')
	end
	if curBeat == 392 then 
		doTweenAlpha('stageGone', 'sky', 0, 0.2, 'linear')
		doTweenAlpha('stageGone2', 'Stors', 0, 0.2, 'linear')
		doTweenAlpha('stageGone3', 'Moon', 0, 0.2, 'linear')
		doTweenAlpha('stageGone4', 'Mountain', 0, 0.2, 'linear')
	end
end