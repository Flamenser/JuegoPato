extends Node

var savePath = "res://save-file.ctg"
var config = ConfigFile.new()
var loadResponse = config.load(savePath)
# Guardar la hora actual en un archivo

func saveValue(section, key, value):
	config.set_value(section, key, value)
	config.save(savePath)	

func loadValue(section, key, default):	
	return config.get_value(section, key, default)

