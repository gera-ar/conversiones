Process, Exist, jfw.exe
If (ErrorLevel != 0) {
	jaws := ComObjCreate("FreedomSci.JawsApi")
	jfw := True
} else
	jfw := False
if main
	message(main)

message(Str) {
	global jfw, jaws
	if (jfw = True)
		Jaws.SayString(Str)
	else
		return DllCall("files\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", Str)
}

mute() {
	global jfw, jaws
	if (jfw=True) {
		Jaws.RunFunction("speechOff")
		Jaws.RunFunction("speechOn")
	} else
		return DllCall("files\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_cancelSpeech")
}
