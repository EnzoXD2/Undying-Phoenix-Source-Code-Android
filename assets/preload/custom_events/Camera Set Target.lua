function onEvent(name, value1, value2)
	if name == 'Camera Set Target' then
		if string.lower(value1) == 'b' then
			cameraSetTarget('boyfriend')
		elseif string.lower(value1) == 'd' then
			cameraSetTarget('dad')
		end
	end
end