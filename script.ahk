lang := {}
IniRead, lang_ini_content, files\strings.ini
IniRead, lang_value, files\settings.ini, language, value
for i, key in StrSplit(lang_ini_content, "`n")
{
	IniRead, string, files\strings.ini,% key,% lang_value
	lang[key] := string
}

hks := array()
hks[1] := ["^f4", "fileConverter", lang["convert_file"]]
hks[2] := ["+f4", "folderConverter", lang["convert_folder"]]
hks[3] := ["^+f4", "suspend", lang["toggle_suspend"]]
hks[4] := ["^space", "play", lang["play"]]
hks[5] := ["^+q", "exit", lang["script_close"]]

soundPlay files\start.mp3

#include files\gui.ahk
#include files\hotkeys.ahk
#include files\speak.ahk

IfNotExist, files\settings.ini
	iniWrite, 128, files\settings.ini, audio_bitrate, value
else
	iniRead, bitrate, files\settings.ini, audio_bitrate, value

menu, tray, noStandard
menu, tray, tip,% lang["script_name"]

menu, idioma, add, Español, LangWrite
menu, idioma, add, Türk, LangWrite
menu, tray, add, languages, :idioma

menu, tray, add,% lang["commands_list"], commands

menu, bitrate, add, 128, audio_bitrate
menu, bitrate, add, 192, audio_bitrate
menu, bitrate, add, 256, audio_bitrate
menu, bitrate, add, 320, audio_bitrate
menu, tray, add,% lang["bitrate_value"] " " bitrate " kbps. ", :bitrate
menu, tray, add,% lang["instructions"], readme
menu, tray, add,% lang["suspend"], suspend
menu, tray, add,% lang["exit"], exit

menu, conversiones, add
menu, audio, add, mp3, audio_video
menu, audio, add, flac, audio_video
menu, audio, add, OGG, audio_video
menu, audio, add, m4a, audio_video
menu, audio, add, wav, audio_video
menu, audio, add,% lang["others"], otros
menu, conversiones, add,% lang["audio"], :audio

menu, conversiones, add
menu, video, add, mp4, audio_video
menu, video, add, avi, audio_video
menu, video, add, mpg, audio_video
menu, video, add, flv, audio_video
menu, video, add, mkv, audio_video
menu, video, add,% lang["others"], otros
menu, conversiones, add,% lang["video"], :video

menu, conversiones, add
menu, documento, add, txt, documento
menu, documento, add, html, documento
menu, documento, add, md, documento
menu, documento, add, rtf, documento
menu, documento, add, epub, documento
menu, documento, add,% lang["others"], otros
menu, conversiones, add,% lang["document"], :documento
return

LangWrite(ItemName) {
	if (ItemName == "Español")
		IniWrite, ES, files\settings.ini, language, value
	else if (ItemName == "Türk")
		IniWrite, TR, files\settings.ini, language, value
	reload
}

play:
filePath := getFilePath()
command = files\ffplay "%filePath%"
RunWait, cmd.exe /c %command%,, hide
return

audio_bitrate:
	iniWrite, %a_thisMenuItem%, files\settings.ini, audio_bitrate, value	
	reload

fileConverter:
	SoundPlay C:\Windows\Media\Windows Exclamation.wav
	filePath := getFilePath()
menu, conversiones, show
return

folderConverter:
if (!folderPath)
	folderPath := getPath()
gui, add, text,,% lang["path_folder_1"]
gui, add, edit, ReadOnly,% folderPath
gui, add, button, gBrowseFolder,% lang["browse"]
Gui, Add, Text,,% lang["path_folder_2"]
Gui, Add, TreeView
audio := TV_Add(lang["audio"])
TV_Add("mp3", audio)
TV_Add("flac", audio)
TV_Add("m4a", audio)
TV_Add("ogg", audio)
TV_Add("wav", audio)
TV_Add("wma", audio)

video := TV_Add(lang["video"])
TV_Add("mp4", video)
TV_Add("avi", video)
TV_Add("flv", video)
TV_Add("mov", video)
TV_Add("mkv", video)

document := TV_Add(lang["document"])
TV_Add("rtf", document)
TV_Add("html", document)
TV_Add("md", document)
TV_Add("docx", document)
TV_Add("epub", document)
TV_Add("txt", document)

gui, add, button, gConversion,% lang["start_conversion"]
gui, add, button, gCloseGui,% lang["cancel"]
gui, show,,% lang["script_name"]
return

BrowseFolder:
gui, destroy
FileSelectFolder, folderPath, *, 2
gosub folderConverter
return

conversion() {
	global folderPath, fileFormat, bitrate, lang
	gui, submit, hide
	id := TV_GetSelection()
	TV_GetText(fileFormat, id)
	TV_GetText(type, TV_GetParent(id))
	sleep 100
	message(lang["converting"])
	convert_folder_name := lang["convert_folder_name"]
	FileCreateDir,% folderPath "\" convert_folder_name
	loop, files, %folderPath%\*.*, R
	{
		splitPath, a_loopFileFullPath, fileName, dirName, extensionName, name, outDrive
		if (type == lang["document"]) {
			command = %a_workingDir%\files\pandoc.exe -o "%dirName%\%convert_folder_name%\%name%.%fileFormat%" "%a_loopFileFullPath%"
			runWait cmd.exe /c %command%,, hide
		} else {
			RunWait cmd.exe /c %a_workingDir%\files\ffmpeg.exe -i "%a_loopFileFullPath%" -b:a %bitrate%000 "%dirName%\%convert_folder_name%\%name%.%fileFormat%",, hide
			message(fileName)
		}
	}
	soundPlay files\finish.mp3
	gui, destroy
}

closeGui() {
	gui, destroy
}

audio_video(itemName) {
	global filePath, bitrate, lang
	sleep 100
	mute()
	SplitPath, filePath, fileName, dirName, extensionName, name, outDrive
	if (extensionName = itemName) {
		sleep 100
		msgBox, 0,% lang["cancel_message_1"] " " fileName " " lang["cancel_message_2"] " " itemName lang["cancel_message_3"]
		return
	}
	sleep 75
	mute()
	message(lang["convert_to"] " " itemName)
	command = %a_workingDir%\files\ffmpeg.exe -i "%filePath%" -b:a %bitrate%000 "%dirName%\%name%.%itemName%"
	runWait cmd.exe /c %command%,, hide
	soundPlay files\finish.mp3
	message(lang["convert_finish"])
}

documento(itemName) {
	global filePath, lang
	SplitPath, filePath, fileName, dirName, extensionName, name, outDrive
	if (extensionName = itemName) {
		sleep 100
		msgBox, 0,% lang["cancel_message_1"] " " fileName " " lang["cancel_message_2"] " " itemName lang["cancel_message_3"]
		return
	}
	sleep 75
	mute()
	message(lang["convert_to"] " " itemName)
	command = %a_workingDir%\files\pandoc.exe -o "%dirName%\%name%.%itemName%" "%filePath%"
	runWait cmd.exe /c %command%,, hide
	soundPlay files\finish.mp3
	message(lang["convert_finish"])
}

otros(itemName, itemPos, menuName) {
	global filePath, bitrate
	SplitPath, filePath, fileName, dirName, extensionName, name, outDrive
	sleep 50
	inputBox, extension, Por favor ingresa la extensión a convertir sin el punto
	if (MenuName == "documento")
		command = %a_workingDir%\files\pandoc.exe -o "%dirName%\%name%.%extension%" "%filePath%"
	else if (menuName == "audio" or menuName = "video")
		command = %a_workingDir%\files\ffmpeg.exe -i "%filePath%" -b:a %bitrate%000 "%dirName%\%name%.%extension%"
	runWait cmd.exe /c %command%,, hide
	message(lang["convert_to"] " " itemName)
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

getFilePath() {
	WinGetClass, winClass, % "ahk_id" . hWnd := WinExist("A")
	if !(winClass ~= "(Cabinet|Explore)WClass")
		Return
	for window in ComObjCreate("Shell.Application").Windows
		if (hWnd = window.HWND) && (oShellFolderView := window.document)
			break
	for item in oShellFolderView.SelectedItems
		result .= (result = "" ? "" : "`n") . item.path
	if !result
		result := oShellFolderView.Folder.Self.Path
	Return result
}

+f1::
commands()
return

ListGuiEscape:
GuiEscape:
gui, list:destroy
gui, destroy
return

readme:
if (lang_value == "ES")
	run files\readme-es.html
else if (lang_value == "TR")
	run files\readme-tr.html
	return

suspend() {
static t
global lang
suspend
	menu, tray, toggleCheck,% lang["suspend_script"]
	message((a_isSuspended)?lang["suspend_message_1"] : lang["suspend_message_2"])
}

exit:
message(lang["finish"])
exitapp