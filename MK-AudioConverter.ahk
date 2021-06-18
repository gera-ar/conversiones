Menu, Tray, NoStandard
Menu, Tray, Tip, MK-audioConverter
Menu, Tray, Add, Información, info
Menu, Tray, Add, Cerrar el programa, Exit


Process, Close, cmd.exe
Gui, Add, Button, vImportButton gImportFile, Importar archivo a convertir
Gui, Add, Text,, Ingrese el nombre del archivo saliente
Gui, Add, Edit, vNewName
Gui, Add, Text,, Seleccione el formato del archivo
Gui, Add, ListBox, vFileFormat, mp3||flac|m4a|wav|wma|mp4|avi|flv|mov|mkv
Gui, Add, Text,, Audio Bitrate
Gui, Add, ListBox, vBitrate, 96k|128k||192k|320k
Gui, Add, Button, vButton gConvert, Convertir
Gui, Add, Button, gExit, Cerrar el programa
Gui, Show,, MK-audioConverter
Return

ImportFile:
FileSelectFile, Path,,, Importar archivo, Audio y video (*.mp3; *.wav; *.opus; *.flac; *.m4a; *.ogg; *.wma; *.avi; *.mp4; *.flv; *.mkv; *.mov; *.mpg)
SplitPath , Path, OutFileName, ruta, OutExtension, archivo, OutDrive
GuiControl,, ImportButton,% Archivo
GuiControl,, NewName,% Archivo
Return

Convert:
Gui, Submit, NoHide
Command = Files\ffmpeg -i "%Path%" -ac 2 -ab %Bitrate% -f %FileFormat% "%ruta%\%NewName%.%FileFormat%
Run cmd.exe /c %Command%,, Hide
Sleep 250
Loop
{
Process, Exist, cmd.exe
If ErrorLevel
GuiControl,, Button, Convirtiendo... por favor espere
Else {
Gosub Msg
Break
}
}
Return

Msg:
SoundPlay Files\Finish.wav
MsgBox,4,Conversión realizada correctamente;, ?Abrir la ruta del archivo convertido?
IfMsgBox yes
{
run % ruta
GuiControl,, ImportButton,Importar archivo a convertir
GuiControl,, NewName
GuiControl,, Button, Convertir
}
IfMsgBox no
reload
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

info:
msgBox, 0, Información,
(
Autor: Gerardo Késsler ReaperYOtrasYerbas@gmail.com
Sencillo programa que permite convertir rápidamente entre formatos de audio o video.
Añade una interfaz gráfica  a los comandos de ffmpeg que es el programa en el que está basado.
)