extends Control

var server: WebSocketServer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	server = WebSocketServer.new()
	var server_status = server.listen(1996)
	print(server_status)
#	if server_status == OK:
#		get_tree().set_network_peer(server)
	pass # Replace with function body.


func _process(delta):
	server.poll()
	pass
