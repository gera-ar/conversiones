commands(row:=1) {
	global hks
	gui, List:Default
	Gui, List:Add, ListView,, Comando|Atajo: 
	iniRead, file, files\config.ini
	for i, key in strSplit(file, "`n")
	{
		iniRead, value, files\config.ini,% key, hk
		value := strReplace(value, "^", "control, ")
		value := strReplace(value, "+", "shift, ")
		value := strReplace(value, "!", "alt, ")
		value := strReplace(value, "home", "inicio")
		value := strReplace(value, "end", "fin")
		value := strReplace(value, "PgUp", "Avance de página")
		value := strReplace(value, "PgDn", "Retroceso de página")
		value := strReplace(value, "right", "Flecha derecha")
		value := strReplace(value, "left", "Flecha izquierda")
		value := strReplace(value, "up", "Flecha arriba")
		value := strReplace(value, "down", "Flecha abajo")
		LV_Add("", hks[i][3], value)
	}
	LV_Modify(row, "Focus")
	LV_Modify(row, "Select")
	gui, List:add, button, gConfig, Cambiar el atajo de teclado
	gui, List:add, button, gClose, Cerrar
	gui, list:show,, Lista de commandos
}

close() {
	gui, list:destroy
}

config() {
	global oldHK, newHK, hks, fila
	fila := lv_getNext()
	iniRead, oldHK, files\config.ini,% hks[fila][2], hk
	gui, list:destroy
	gui, config:default
	gui, config:add, text,, Ingresa un nuevo atajo de teclado
	gui, config:add, hotKey, vnewHK,% oldHK
	gui, config:add, button, gSave, Guardar los cambios
	gui, config:add, button, gCancel, Cancelar
	gui, config:show,, Configuración
}

save() {
	global newHK, oldHK, hks, fila
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
		msgBox, 0, Atención; , Este campo no puede quedar vacío, por favor ingrese un atajo.
		gui, show,, Configuración
	}
}

cancel() {
	gui, config:destroy
}