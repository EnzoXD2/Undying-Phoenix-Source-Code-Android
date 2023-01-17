function onCreate()
	-- background shit
	makeLuaSprite('sky', 'dsStage/DS_sky', -300, -200);
	scaleObject('sky', 1.1,1.1)
	setScrollFactor('sky', 0.3,0.3)
	addLuaSprite('sky', false);

	makeLuaSprite('mountain', 'dsStage/DS_mount', -300, -200);
	scaleObject('mountain', 1.1,1.1)
	setScrollFactor('mountain', 0.5,0.5)
	addLuaSprite('mountain', false);

	makeLuaSprite('fog', 'dsStage/DS_fog', -300, -190);
	scaleObject('fog', 1.1,1.1)
	setScrollFactor('fog', 0.9,0.95)
	addLuaSprite('fog', false);

	makeLuaSprite('field', 'dsStage/DS_fiel', -300, -200);
	scaleObject('field', 1.1,1.1)
	addLuaSprite('field', false);

	makeLuaSprite('trees', 'dsStage/DS_trees', -300, -200);
	scaleObject('trees', 1.1,1.1)
	addLuaSprite('trees', false);

	makeLuaSprite('bush', 'dsStage/DS_bush', -230, -130);
	setScrollFactor('bush',0.2,0.2)
	scaleObject('bush', 0.95,0.95)

	makeLuaSprite('stagewall', 'dsStage/DS_stageback', -450, -200);
	scaleObject('stagewall', 1.15, 1.1)
	setScrollFactor('stagewall', 0.25, 0.25)
	addLuaSprite('stagewall', false);

	makeLuaSprite('curtains', 'dsStage/DS_stageCurtain', -550, -280);
	scaleObject('curtains', 1.25, 1.2)
	setScrollFactor('curtains', 0.7, 0.7)
	addLuaSprite('curtains', true);

	makeLuaSprite('stage', 'dsStage/DS_stageground', -600, -120);
	scaleObject('stage', 1.35, 1.3)
	addLuaSprite('stage', false);

	makeLuaSprite('darkness', 'YCR_black', -300, -200);
	scaleObject('darkness', 2, 2);
	precacheImage('darkness');
	setObjectCamera('darkness', 'other');
	
end

function onCreatePost()
	setProperty('gf.visible', false)
	doTweenColor('score', 'scoreTxt', '003030', 0.01)
    doTweenColor('time', 'timeTxt', '005050', 0.01)
    doTweenColor('time2', 'timeBar', '003030', 0.01)
end

function onUpdate(elapsed)
	setTextString("botplayTxt", "Leaks\nIP")
end

function onBeatHit()
	if curBeat == 194 then
		setProperty('defaultCamZoom', 0.7)
	end
	if curBeat == 195 then
		addLuaSprite('darkness', true)
	end
	if curBeat == 196 then
		setProperty('defaultCamZoom', 0.8)
		addLuaSprite('bush' ,true)
		doTweenAlpha('stageGone', 'curtains', 0, 0.2, 'linear')
		doTweenAlpha('stageGone2', 'stage', 0, 0.2, 'linear')
		doTweenAlpha('stageGone3', 'stagewall', 0, 0.2, 'linear')
		doTweenAlpha('stageGone4', 'darkness', 0, 0.2, 'linear')
		doTweenColor('score', 'scoreTxt', 'df3030', 0.5)
		doTweenColor('time', 'timeTxt', 'ff5050', 0.5)
		doTweenColor('time2', 'timeBar', 'df3030', 0.5)
	end
	if curBeat == 228 then
		doTweenColor('score', 'scoreTxt', 'ba3030', 2)
		doTweenColor('time', 'timeTxt', 'd45050', 2)
		doTweenColor('time2', 'timeBar', 'ba3030', 2)
	end
	if curBeat == 260 then
		doTweenAlpha('stageGone', 'mountain', 0, 1.5, 'linear')
		doTweenColor('score', 'scoreTxt', '953030', 2)
		doTweenColor('time', 'timeTxt', 'a95050', 2)
		doTweenColor('time2', 'timeBar', '953030', 2)
	end
	if curBeat == 276 then
		doTweenAlpha('stageGone', 'trees', 0, 1.5, 'linear')
		doTweenColor('score', 'scoreTxt', '703030', 2)
		doTweenColor('time', 'timeTxt', '7e5050', 2)
		doTweenColor('time2', 'timeBar', '703030', 2)
	end
	if curBeat == 284 then
		doTweenAlpha('stageGone', 'fog', 0, 1.5, 'linear')
		doTweenAlpha('stageGone2', 'bush', 0, 1.5, 'linear')
		doTweenColor('score', 'scoreTxt', '4b3030', 2)
		doTweenColor('time', 'timeTxt', '535050', 2)
		doTweenColor('time2', 'timeBar', '4b3030', 2)
	end
	if curBeat == 292 then
		doTweenAlpha('stageGone', 'sky', 0, 1.5, 'linear')
		doTweenColor('score', 'scoreTxt', '263030', 2)
		doTweenColor('time', 'timeTxt', '285050', 2)
		doTweenColor('time2', 'timeBar', '263030', 2)
	end
	if curBeat == 308 then
		doTweenAlpha('stageSpawn', 'darkness', 1, 0.001, 'linear')
		doTweenColor('score', 'scoreTxt', '003030', 2)
		doTweenColor('time', 'timeTxt', '005050', 2)
		doTweenColor('time2', 'timeBar', '003030', 2)
	end
end