extends TextureProgressBar
var Progress : float
var Cooldown : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Progress =100
	$"../Timer".timeout.connect(_on_timer_timeout)
	$".".value = Progress


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_cast( cd):
	Cooldown =1.0*5/cd ;

func _on_timer_timeout():
	if ((Progress!=0)):
		Progress-= Cooldown
		$".".value = 100-Progress
