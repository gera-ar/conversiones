hks := array()
hks[1] := ["f4", "fileConverter", "Convertir el archivo con el foco"]
hks[2] := ["+f4", "folderConverter", "convierte todos los archivos de la carpeta actual"]
hks[3] := ["!^s", "suspend", "Suspende y reanuda el script"]
hks[4] := ["!^q", "exit", "Cierra el script"]

main = Script iniciado

#include hks\gui.ahk
#include hks\hotkeys.ahk
#include tts\speak.ahk

menu, tray, noStandard
menu, tray, tip, Conversiones
menu, tray, add, Suspender el script, suspend
menu, tray, add, Cerrar el script, exit

menu, conversiones, add
menu, audio, add, mp3, audio_video
menu, audio, add, flac, audio_video
menu, audio, add, OGG, audio_video
menu, audio, add, m4a, audio_video
menu, audio, add, wav, audio_video
menu, audio, add, o&tros, otros
menu, conversiones, add, audio, :audio

menu, conversiones, add
menu, video, add, mp4, audio_video
menu, video, add, avi, audio_video
menu, video, add, mpg, audio_video
menu, video, add, flv, audio_video
menu, video, add, mkv, audio_video
menu, video, add, o&tros, otros
menu, conversiones, add, video, :video

menu, conversiones, add
menu, documento, add, txt, documento
menu, documento, add, html, documento
menu, documento, add, md, documento
menu, documento, add, rtf, documento
menu, documento, add, epub, documento
menu, documento, add, o&tros, otros
menu, conversiones, add, documento, :documento
return

fileConverter:
send ^c
filePath := clipboard
menu, conversiones, show
return

folderConverter:
folderPath := getPath()
gui, add, text,, Seleccione el formato del archivo
gui, add, listBox, vFileFormat, mp3||flac|m4a|ogg|wav|wma|mp4|avi|flv|mov|mkv
gui, add, button, gConversion, iniciar la conversión
gui, add, button, gCloseGui, Cancelar
gui, show
return

conversion() {
	global folderPath, fileFormat
	gui, submit, hide
	loop, files, %folderPath%\*.*, R
	{
		splitPath, a_loopFileFullPath, fileName, dirName, extensionName, name, outDrive
		runWait cmd.exe /c %a_workingDir%\files\ffmpeg.exe -i "%a_loopFileFullPath%" "%dirName%\%name%.%fileFormat%",, hide
	}
	soundPlay files\finish.mp3
	gui, destroy
}

closeGui() {
	gui, destroy
}

audio_video(itemName) {
	global filePath
	SplitPath, filePath, fileName, dirName, extensionName, name, outDrive
	command = %a_workingDir%\files\ffmpeg.exe -i "%filePath%" "%dirName%\%name%.%itemName%"
	runWait cmd.exe /c %command%,, hide
	soundPlay files\finish.mp3
}

documento(itemName) {
	global filePath
	SplitPath, filePath, fileName, dirName, extensionName, name, outDrive
	command = %a_workingDir%\files\pandoc.exe -o "%dirName%\%name%.%itemName%" "%filePath%"
	runWait cmd.exe /c %command%,, hide
	soundPlay files\finish.mp3
}

otros(itemName, itemPos, menuName) {
	global filePath
	SplitPath, filePath, fileName, dirName, extensionName, name, outDrive
	sleep 50
	inputBox, extension, Por favor ingresa la extensión a convertir sin el punto
	if menuName = "documento"
		command = %a_workingDir%\files\pandoc.exe -o "%dirName%\%name%.%extension%" "%filePath%"
	else if (menuName="audio" or menuName="video")
		command = %a_workingDir%\files\ffmpeg.exe -i "%filePath%" "%dirName%\%name%.%extension%"
	runWait cmd.exe /c %command%,, hide
	soundPlay files\finish.mp3
}

getPath() {
	explorerHwnd := WinActive("ahk_class CabinetWClass")
	if (explorerHwnd)
	{
		for window in ComObjCreate("Shell.Application").Windows
		{
			if (window.hwnd==explorerHwnd)
			{
				return window.Document.Folder.Self.Path
			}
		}
	}
}

+f1::
commands()
return

suspend() {
static t
suspend
	menu, tray, toggleCheck, Suspender el script
	message((t:=!t)? "Script suspendido" : "Script reactivado")
}

exit:
message("script finalizado")
exitapp