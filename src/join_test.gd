extends Control

var client: WebSocketClient
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	client = WebSocketClient.new()
	var connection_status = client.connect_to_url('localhost:1996')
	print(connection_status)
#	if connection_status == OK:
#		get_tree().set_network_peer(client)
	pass # Replace with function body.


func _process(delta):
	client.poll()
	pass

