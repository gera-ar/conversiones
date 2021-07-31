IfNotExist, hks\config.ini
	fileCreate()
else
	fileRead()

fileCreate() {
	global hks
	for k, value in hks
		iniWrite,% value[1], hks\config.ini,% value[2], hk
	fileRead()
}

fileRead() {
	iniRead, iniContent, hks\config.ini
	for i, key in strSplit(iniContent, "`n")
	{
		iniRead, hk, hks\config.ini,% key, hk
		hotkey,% hk,% key, on
	}
}
