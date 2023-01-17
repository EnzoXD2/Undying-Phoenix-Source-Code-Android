local x = 0.75
function onEvent(name, value1, value2)
	if name == 'Zoom' then
		if value1 == '+' then
			x = (x + 0.3)
		    setProperty("defaultCamZoom", x)
		end
		if value1 == '-' then
			x = (x - 0.3)
		    setProperty("defaultCamZoom", x)
		end
	end
end