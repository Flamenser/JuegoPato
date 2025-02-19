extends Node

var savePath = "user://save-file.ctg" #Inicio en "user" para android y "res" para PC
var config = ConfigFile.new()
var loadResponse = config.load(savePath)
# Guardar la hora actual en un archivo

func saveValue(section, key, value):
	config.set_value(section, key, value)
	config.save(savePath)

func loadValue(section, key, default):	
	return config.get_value(section, key, default)

