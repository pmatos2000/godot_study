class_name Util

static func remove_node(node: Node) -> void:
	node.set_process(false)
	node.queue_free()
