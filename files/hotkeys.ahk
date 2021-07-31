IfNotExist, files\config.ini
	fileCreate()
else
	fileRead()

fileCreate() {
	global hks
	for k, value in hks
		iniWrite,% value[1], files\config.ini,% value[2], hk
	fileRead()
}

fileRead() {
	iniRead, iniContent, files\config.ini
	for i, key in strSplit(iniContent, "`n")
	{
		iniRead, hk, files\config.ini,% key, hk
		hotkey,% hk,% key, on
	}
}
