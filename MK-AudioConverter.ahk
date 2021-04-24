SoundPlay Files\Start.wav
Menu, Tray, NoStandard
Menu, Tray, Tip, MK-AudioConverter
Menu, Tray, Add, Cerrar MK-AudioConverter, Exit

Process, Close, cmd.exe
Gui, Add, Button, vImportButton gImportFile, Importar archivo a convertir
Gui, Add, Text,, Ingrese el nombre del archivo saliente
Gui, Add, Edit, vNewName
Gui, Add, Text,, Seleccione el formato del archivo
Gui, Add, ListBox, vFileFormat, mp3||flac|m4a|wav|wma|mp4|avi|flv|mov|mkv
Gui, Add, Text,, Audio Bitrate
Gui, Add, ListBox, vBitrate, 96k|128k||192k|320k
Gui, Add, Button, vButton gConvert, Convertir
Gui, Add, Button, gExit, Cerrar MK-AudioConverter
Gui, Show,, MKConverter
Return

ImportFile:
FileSelectFile, Path,,, Importar archivo, Audio y video (*.mp3; *.wav; *.opus; *.flac; *.m4a; *.ogg; *.wma; *.avi; *.mp4; *.flv; *.mkv; *.mov; *.mpg)
SplitPath, Path, Archivo, FilePath
GuiControl,, ImportButton,% Archivo
Return

Convert:
Gui, Submit, NoHide
Command = Files\ffmpeg -i "%Path%" -ac 2 -ab %Bitrate% -f %FileFormat% "%FilePath%\%NewName%.%FileFormat%
Run cmd.exe /c %Command%,, Hide
Sleep 250
Loop
{
Process, Exist, cmd.exe
If ErrorLevel
GuiControl,, Button, Convirtiendo...
Else {
Gosub Msg
Break
}
}
Return

Msg:
SoundPlay Files\Finish.wav
MsgBox,4,Conversión realizada correctamente;, ?Deseas realizar otra conversión?
IfMsgBox yes
Reload
IfMsgBox no
Gosub Exit
Return


#If WinActive("MKConverter")
!f4::
Sleep 250
MsgBox,4,?Deseas cerrar el programa?
IfMsgBox yes
Gosub Exit
Return

Exit:
Process, Close, cmd.exe
ExitApp
