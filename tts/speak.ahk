Process, Exist, jfw.exe
If ErrorLevel != 0
	jfw := True
else
	jfw := False
if main
	message(main)

message(Str) {
	global jfw
	if (jfw = True) {
		Jaws := ComObjCreate("FreedomSci.JawsApi")
		Jaws.SayString(Str)
	} else {
		return DllCall("tts\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", Str)
	}
}

mute() {
	global jfw
	if (jfw=True) {
		Jaws := ComObjCreate("FreedomSci.JawsApi")
		Jaws.RunFunction("speechoff")
	} else {
		return DllCall("tts\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_cancelSpeech")
	}
}
