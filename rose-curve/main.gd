@tool
extends Node2D

@export_group("Parâmetros Rosa polar ")
@export_range(100, 500, 50) var r: float = 300
@export_range(1, 9) var n: int = 1
@export_range(1, 9) var d: int = 1
@export var multiplicador_velocidade: float = 0.25


@export_group("Parâmetros Elementos")
@export var cena_elemento: PackedScene = null
@export_range(1, 100) var quantidade: int = 4

@export_group("Parâmetros desenho")
@export var desenhar: bool = true
@export var quantiade_segmento: int = 200

const NOME_META_TEMPO: StringName = "TEMPO"
const NOME_GRUPO_ELEMENTO: StringName = "ELEMENTO"
const NOME_GRUPO_LINHAS: StringName = "LINHAS"

var k: float = 0.0 # Frequencia
var tempo_maximo: float = 0.0
var N: int = 0
var D: int = 0

@onready var k_label: Label = $"../UI/ColorRect/MarginContainer/VBoxContainer/K"


func _ready() -> void:
	criar_filhos()


func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		atualizar_elementos(delta)

func obter_posicao(tempo: float) -> Vector2:
	var angulo: float = multiplicador_velocidade * 2 * PI * tempo / N
	var x: float = r * cos(k * angulo) * cos(angulo)
	var y: float = r * cos(k * angulo) * sin(angulo)
	return Vector2(x, y)


func criar_filhos() -> void:
	var _mdc: int = mdc(n, d)
	@warning_ignore("integer_division")
	N = n / _mdc
	@warning_ignore("integer_division")
	D = d / _mdc
	k =  float(N) / D
	k_label.text = "K = N/D = %f" % k
	tempo_maximo = N * D / multiplicador_velocidade
	if N % 2 == 1 and D % 2 == 1:
		tempo_maximo /= 2
	criar_elementos()
	criar_linhas()

func criar_linhas() -> void:
	var nodes: Array[Node] = get_children().filter(
		func (node: Node) -> bool: return node.is_in_group(NOME_GRUPO_LINHAS))
	if nodes.size() == 1:
		nodes[0].queue_free()
	
	if desenhar:
		var linhas: Line2D = Line2D.new()
		linhas.add_to_group(NOME_GRUPO_LINHAS)
		linhas.width = 2
		linhas.z_index = -1
		linhas.default_color = Color("#ff2e66")
		if quantiade_segmento:
			var delta_tempo: float = tempo_maximo / quantiade_segmento 
			for tempo in Vector3(0, tempo_maximo + delta_tempo, delta_tempo):
				var posicao: Vector2 = obter_posicao(tempo)
				linhas.add_point(posicao)
		add_child(linhas)


func criar_elementos() -> void:
	var nodes: Array[Node] = get_children()
	for node in nodes:
		if node.is_in_group(NOME_GRUPO_ELEMENTO):
			node.queue_free()
			
	for i in quantidade:
		var node: Node2D = cena_elemento.instantiate()
		var tempo: float =  i * tempo_maximo / quantidade 
		node.set_meta(NOME_META_TEMPO, tempo)
		node.position = obter_posicao(tempo)
		node.add_to_group(NOME_GRUPO_ELEMENTO)
		add_child(node)

func atualizar_elementos(delta: float) -> void:
	var nodes: Array[Node] = get_children().filter(
		func (node: Node) -> bool: return node.is_in_group(NOME_GRUPO_ELEMENTO))
	
	for node in nodes:
		if node is Node2D:
			var tempo: float = node.get_meta(NOME_META_TEMPO, 0.0)
			tempo += delta
			node.set_meta(NOME_META_TEMPO, tempo)
			var posicao_antiga: Vector2 = node.position
			node.position = obter_posicao(tempo)
			var delta_posicao: Vector2 = posicao_antiga - node.position
			node.rotation = atan2(delta_posicao.y, delta_posicao.x) - PI/2

func mdc(x: int, y: int) -> int:
	if y == 0:
		return x
	return mdc(y, x % y)


func _on_r_spin_box_value_changed(valor: float) -> void:
	r = valor
	criar_filhos()


func _on_n_spin_box_value_changed(valor: float) -> void:
	n = int(valor)
	criar_filhos()


func _on_d_spin_box_value_changed(valor: float) -> void:
	d = int(valor)
	criar_filhos()


func _on_t_spin_box_value_changed(valor: float) -> void:
	quantidade = int(valor)
	criar_filhos()


func _on_segmentos_spin_box_value_changed(valor: float) -> void:
	quantiade_segmento = int(valor)
	criar_filhos()
