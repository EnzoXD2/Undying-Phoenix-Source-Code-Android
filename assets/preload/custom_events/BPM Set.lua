function onEvent(name, value1, value2)
    if name == "changeBPM" then
        setPropertyFromClass('Conductor', 'bpm', value1)
    end
end