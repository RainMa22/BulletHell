class_name LongBullet extends Bullet



func _ready():
	super()
	style_manager = BulletLongStyleManager.new(body, outline)
	style_manager.on_style_change()
