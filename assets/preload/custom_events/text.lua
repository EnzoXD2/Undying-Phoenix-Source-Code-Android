luaDebugMode = true
text = { --current text strings for each character
	boyfriend = {
		full = "", --will store the full word
		split = "", --will store the split word
		current = "", --will store what's to be displayed currently
		curIndex = 0, --what word it should use to update the current property
		active = false --self explanatory
	},
	dad = {
		full = "",
		split = "",
		current = "",
		curIndex = 0,
		active = false
	},
	font = "sonecFont.ttf", --self explanatory
	randMiss = { --words for when you miss a note lol, will replace the next word
		"BORNANA",
		"ajwklajlajsaw",
		"amogus!1!!",
		"lmao",
		"LEGOCITY",
		"potassium!",
		"MALK"
	}
}

function onCreatePost() --I like to use post just to be safe
	local charactersTable = {"boyfriend", "dad"}
	
	for keys, singer in pairs(charactersTable) do
		makeLuaText(singer .. "Text", "", 640, 0, 500)
		setTextSize(singer .. "Text", 30)
		if text.font ~= nil then setTextFont(singer .. "Text", text.font) end
		screenCenter(singer .. "Text", "x")
		addLuaText(singer .. "Text")
	end
end	

function onEvent(name, value1, value2)
	if name == "text" then
		text[value2]["full"] = value1 --setting the current text value for the character 
		text[value2]["split"] = split(text[value2]["full"]) --setting the split property to the full string but split
		text[value2]["curIndex"] = 0
		text[value2]["current"] = "" --current sentence to say is the first word of the split thing
		text[value2]["active"] = true --self explanatory
	end
end

--good note hit here:
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == "visible_textNote" then
		dia("boyfriend", isSustainNote) --dialogue checks
	end

	--[[
	debugPrint("full: " .. text["boyfriend"]["full"])
	debugPrint("split1: " .. text["boyfriend"]["split"][1])
	debugPrint("curIndex: " .. text["boyfriend"]["curIndex"])
	debugPrint("currentText: " .. text["boyfriend"]["current"])
	debugPrint("active: ", text["boyfriend"]["active"])
	--]]
end


function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == "textNote" then
		dia("dad", isSustainNote) --dialogue checks
	elseif noteType == "visible_textNote" then
		dia("dad", isSustainNote)
	else
		setTextString("dadText", "")
	end
end

-- function noteMissPress(direction)
	-- dia("boyfriend", false, true)
-- end

-- function noteMiss(id, direction, noteType, isSustainNote)
	-- dia("boyfriend", false, true)
-- end

-- function onMoveCamera(focus) --if the focus isn't on bf then hide the text
	-- if focus ~= "boyfriend" then setTextString("boyfriendText", "") end
	-- if focus ~= "dad" then setTextString("dadText", "") end
-- end


function dia(singer, isSustainNote, failed, separator) --dialogue function, stands for dialogue
	if text[singer]["active"] and (not isSustainNote) then --can't have the extra stuff from the sustain notes intervene
		if failed == nil then failed = false end
		if separator == nil then separator = " " end
		
		local nextLine = text[singer]["split"][text[singer]["curIndex"]+1] --next line to be added
		
		--add 1 to the current index
		--remember it updates each time the note is hit
		text[singer]["curIndex"] = text[singer]["curIndex"]+1
		
		--prepare the text and add it, use the current text for each character as the function's "text" param
		
		if string.match(nextLine, "*") then 
			nextLine = string.gsub(text[singer]["split"][text[singer]["curIndex"]], "%*", "") 
			text[singer]["split"][text[singer]["curIndex"]] = nextLine
			separator = ""
		end
		
		--The failed thing will only stay until the next note, by then it corrects itself lol
		if failed then --if you failed a note then add the next word as a random thing, then update the current phrase after
			setTextString(singer .. "Text", text[singer]["current"] .. separator .. text["randMiss"][math.random(1, 7)])
			text[singer]["current"] = text[singer]["current"] .. " " .. nextLine
		else --in case you DIDN'T miss the note, upadte the current phrase BEFORE adding the text in
			text[singer]["current"] = text[singer]["current"] .. separator .. nextLine
			setTextString(singer .. "Text", text[singer]["current"])
		end
		--this stuff is editing already existing objects btw, defined in the onCreate thing
		
		if text[singer]["current"] == " " .. text[singer]["full"] then text[singer]["active"] = false end --if the current text is the full text, then deactivate, has a space at the start cuz that's how it works
	end
end

--string split function
function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end