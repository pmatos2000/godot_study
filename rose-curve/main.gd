@tool
extends Node2D

@export_group("Parâmetros Rosa polar ")
@export_range(100, 2000, 100) var r: float = 200
@export_range(1, 9) var n: int = 1
@export_range(1, 9) var d: int = 1

@export_group("Parâmetros Elementos")
@export var cena_elemento: PackedScene = null
@export_range(1, 100) var quantidade: int = 1

@export_group("Parâmetros desenho")
@export var desenhar: bool = true
@export var quantiade_segmento: int = 100

const NOME_META_ANGULO: StringName = "angulo"
const NOME_GRUPO_ELEMENTO: StringName = "ELEMENTO"
const NOME_GRUPO_LINHAS: StringName = "LINHAS"

var k: float = 0 # Frequencia
var periodo: float = 0

func _ready() -> void:
	criar_filhos()


func _process(delta: float) -> void:
	atualizar_elementos(delta)

func obter_posicao(tempo: float) -> Vector2:
	var angulo = tempo
	var x = r * cos(k * angulo) * cos(angulo)
	var y = r * cos(k * angulo) * sin(angulo)
	return Vector2(x, y)


func criar_filhos() -> void:
	k =  float(n) / d
	periodo = 1 / k
	criar_elementos()
	criar_linhas()

func criar_linhas():
	var nodes = get_children().filter(
		func (node: Node): return node.is_in_group(NOME_GRUPO_LINHAS))
	if nodes.size() == 1:
		nodes[0].queue_free()
	
	if desenhar:
		var linhas: Line2D = Line2D.new()
		linhas.add_to_group(NOME_GRUPO_LINHAS)
		linhas.width = 1
		linhas.z_index = -1
		print(periodo)
		var delta_tempo: float = periodo/quantiade_segmento 
		for tempo in Vector3(0, periodo + delta_tempo, delta_tempo):
			var posicao = obter_posicao(2 * PI * k * tempo)
			linhas.add_point(posicao)
		
		add_child(linhas)


func criar_elementos() -> void:
	var nodes = get_children()
	for node in nodes:
		if node.is_in_group(NOME_GRUPO_ELEMENTO):
			node.queue_free()
			
	for i in quantidade:
		var node: Node2D = cena_elemento.instantiate()
		var angulo: float =  2 * i * PI/ quantidade 
		node.set_meta(NOME_META_ANGULO, angulo)
		node.position = obter_posicao(angulo)
		node.add_to_group(NOME_GRUPO_ELEMENTO)
		add_child(node)

func atualizar_elementos(delta: float) -> void:
	var nodes = get_children().filter(
		func (node: Node): return node.is_in_group(NOME_GRUPO_ELEMENTO))
	
	for node in nodes:
		var angulo: float = node.get_meta(NOME_META_ANGULO, 0.0)
		angulo = angulo + delta
		node.set_meta(NOME_META_ANGULO, angulo)
		node.position = obter_posicao(angulo)
