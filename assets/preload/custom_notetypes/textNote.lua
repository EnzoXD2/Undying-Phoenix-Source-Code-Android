function onCreate()
	for o, i in pairs({0, 1, 2, 3}) do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'textNote' then
			setPropertyFromGroup('unspawnNotes', i, 'visible', false)
		end
	end
end

function onStepHit()
	for o, i in pairs({0, 1, 2, 3}) do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'textNote' then
			setPropertyFromGroup('unspawnNotes', i, 'visible', false)
		end
	end
end	