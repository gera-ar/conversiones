commands(row:=1) {
	global hks, lang
	gui, List:Default
	Gui, List:Add, ListView,,% lang["command"] "|" lang["hk"] ":" 
	iniRead, file, files\config.ini
	for i, key in strSplit(file, "`n")
	{
		iniRead, value, files\config.ini,% key, hk
		value := strReplace(value, "^", lang["control"])
		value := strReplace(value, "+", lang["shift"])
		value := strReplace(value, "!", lang["alt"])
		value := strReplace(value, "home", lang["home"])
		value := strReplace(value, "end", lang["end"])
		value := strReplace(value, "PgUp", lang["PGUp"])
		value := strReplace(value, "PgDn", lang["PGDown"])
		value := strReplace(value, "right", lang["right"])
		value := strReplace(value, "left", lang["left"])
		value := strReplace(value, "up", lang["up"])
		value := strReplace(value, "down", lang["down"])
		LV_Add("", hks[i][3], value)
	}
	LV_Modify(row, "Focus")
	LV_Modify(row, "Select")
	gui, List:add, button, gConfig,% lang["changeHK"]
	gui, List:add, button, gClose,% lang["close"]
	gui, list:show,,% lang["commands_list"]
}

close() {
	gui, list:destroy
}

config() {
	global oldHK, newHK, hks, fila, lang
	fila := lv_getNext()
	iniRead, oldHK, files\config.ini,% hks[fila][2], hk
	gui, list:destroy
	gui, config:default
	gui, config:add, text,,% lang["new_hk"]
	gui, config:add, hotKey, vnewHK,% oldHK
	gui, config:add, button, gSave,% lang["save_changes"]
	gui, config:add, button, gCancel,% lang["cancel"]
	gui, config:show,,% lang["setting"]
}

save() {
	global newHK, oldHK, hks, fila, lang
	gui, config:submit, hide
	if newHK
	{
		iniWrite,% newHK, files\config.ini,% hks[fila][2], hk
		hotkey,% oldHK,% hks[fila][2], off
		hotkey,% newHK,% hks[fila][2], on
		gui, config:destroy
		fileRead()
		commands(fila)
	} else {
		msgBox, 0,% lang["attention"],% lang["attention_message"]
		gui, show,,% lang["setting"]
	}
}

cancel() {
	gui, config:destroy
}
