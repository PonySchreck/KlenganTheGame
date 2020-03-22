extends KinematicBody2D

const START_GRAVITY = 4
const GRAVITY_FACTOR = 1.1

var speed = 750
var velocity = Vector2()
var klengan_node

#func _ready():
#	start(Vector2(0, 40), false)


func start(_klengan_node, _position, _looking_right):
	klengan_node = _klengan_node
	position = _position
	scale = scale.abs() * Vector2(int(pow(-1, int(!_looking_right))), 1)
	var x_speed = int(speed * pow(-1, int(!_looking_right)))
	velocity = Vector2(x_speed, START_GRAVITY)
	$DespawnTimer.start()


func _physics_process(_delta):
	velocity.y = velocity.y * GRAVITY_FACTOR
	rotation = velocity.angle()
	var collision = move_and_collide(velocity * _delta)
	if collision != null:
		if collision.collider is FightableObject:
			klengan_node.attack(KLENGAN_ATTACKS.NORMAL, collision.collider)
		queue_free()


func _on_DespawnTimer_timeout():
	queue_free()
