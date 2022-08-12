IfNotExist, files\hotkeys.ini
	fileCreate()
else
	fileRead()

fileCreate() {
	global hks
	for k, value in hks
		iniWrite,% value[1], files\hotkeys.ini,% value[2], hk
	fileRead()
}

fileRead() {
	iniRead, iniContent, files\hotkeys.ini
	for i, key in strSplit(iniContent, "`n")
	{
		iniRead, hk, files\hotkeys.ini,% key, hk
		hotkey,% hk,% key, on
	}
}
