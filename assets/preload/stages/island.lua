function onCreate()
	-- background shit
	makeLuaSprite('sky', 'island/LP_sky', -400, -170);
	setScrollFactor('sky', 0.5, 0.5);
	scaleObject('sky', 1.2, 1.2)
	addLuaSprite('sky', false);

	makeLuaSprite('trees', 'island/LP_trees', -450, -170);
	setScrollFactor('trees', 0.7, 0.7);
	scaleObject('trees', 1.2, 1.2)
	addLuaSprite('trees', false);
	
	makeLuaSprite('floor', 'island/LP_floor', -350, -100);
	setScrollFactor('floor', 1, 1);
	scaleObject('floor', 1.2, 1.2)
	addLuaSprite('floor', false);

	makeLuaSprite('corpses', 'island/LP_corpses', -350, -100);
	setScrollFactor('corpses', 1, 1);
	scaleObject('corpses', 1.2, 1.2)
	addLuaSprite('corpses', false);

end

function onCreatePost()
    doTweenColor('bars', 'timeBar', '000080', 0.01)
    doTweenColor('score', 'scoreTxt', '3a3aa2', 0.01)
    doTweenColor('time', 'timeTxt', '4a4ab2', 0.01)
end