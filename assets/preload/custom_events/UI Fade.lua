-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'UI Fade' then
		duration = tonumber(value1);
		if duration < 0.01 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if targetAlpha == 0 then
			x = false
		end
		if targetAlpha > 0 then
			x = true
		end
		if duration == 0 then
			setProperty('scoretxt.alpha', targetAlpha);
			setProperty('healthBar.alpha', targetAlpha);
			setProperty('healthBarBG.alpha', targetAlpha);
			setProperty('timeBar.alpha', targetAlpha);
		else
			doTweenAlpha('hudgo1', 'scoreTxt', targetAlpha, duration);
			doTweenAlpha('hudgo2', 'timeTxt', targetAlpha, duration);
			doTweenAlpha('hudgo3', 'healthBar', targetAlpha, duration);
			doTweenAlpha('hudgo4', 'healthBarBG', targetAlpha, duration);
			doTweenAlpha('hudgo5', 'timeBar', targetAlpha, duration);
			doTweenAlpha('hudgo6', 'timeBarBG', targetAlpha, duration);
			doTweenAlpha('hudgo7', 'iconP1', targetAlpha, duration);
			doTweenAlpha('hudgo8', 'iconP2', targetAlpha, duration);
			doTweenAlpha('hudgo9', 'funni', targetAlpha, duration);
			doTweenAlpha('hudgo10', 'percentage', targetAlpha, duration);
			doTweenAlpha('hudgo11', 'ring', targetAlpha, duration);
			doTweenAlpha('hudgo12', 'sparkle', targetAlpha, duration);
			doTweenAlpha('hudgo13', 'focus_bar', targetAlpha, duration);
			doTweenAlpha('hudgo14', 'lilHelper', targetAlpha, duration);
			doTweenAlpha('hudgo15', 'focus_outline', targetAlpha, duration);
			if botPlay then
				doTweenAlpha('hudgo16', 'botplayTxt', targetAlpha, duration);
				runTimer('botOpacity', 1, 1)
			end
			noteTweenAlpha('backo1', 0, targetAlpha, duration,'linear');
			noteTweenAlpha('backo2', 1, targetAlpha, duration,'linear');
			noteTweenAlpha('backo3', 2, targetAlpha, duration,'linear');
			noteTweenAlpha('backo4', 3, targetAlpha, duration,'linear');
			noteTweenAlpha('backo5', 4, targetAlpha, duration,'linear');
			noteTweenAlpha('backo6', 5, targetAlpha, duration,'linear');
			noteTweenAlpha('backo7', 6, targetAlpha, duration,'linear');
			noteTweenAlpha('backo8', 7, targetAlpha, duration,'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
	function onTimerCompleted(t, l, ll)
		if t == 'botOpacity' and botPlay then
			setProperty('botplayTxt.visible', x)
		end
	end
end
