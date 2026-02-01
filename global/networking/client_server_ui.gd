extends Control



func _on_server_pressed():
	networkhandler.start_server()
	hide()

func _on_client_pressed():
	networkhandler.start_client()
	hide()
