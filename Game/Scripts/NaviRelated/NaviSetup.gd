extends NavigationRegion2D
class_name NaviSetup

# call to setup the server
func call_server_setup():
	NS.custom_setup(self)


func _ready():
	call_server_setup()
	
