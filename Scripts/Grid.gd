# in gameWindow Grid node
extends Node2D

#grid var
export (int) var width
export (int) var height
export (int) var xStart
export (int) var yStart
export (int) var offset
export (int) var yOffset
#所有顏色的棋子
var possiblePieces = [
preload("res://Scenes/YellowPiece.tscn"),
preload("res://Scenes/BluePiece.tscn"),
preload("res://Scenes/GreenPiece.tscn"),
preload("res://Scenes/LightGreenPiece.tscn"),
preload("res://Scenes/PinkPiece.tscn"),
preload("res://Scenes/OrangePiece.tscn"),
]
#棋盤
var allPiece = []

#觸控變數
var firstTouch = Vector2(0,0)
var finalTouch = Vector2(0,0)
var controlling = false

#開場做什麼
func _ready():
	randomize()
	allPiece = Make2DArray()
	print(allPiece)
	SpawnPieces()
	pass # Replace with function body.

#做棋盤START
func Make2DArray():
	var array = []
	for i in width:
		array.append([]) #變成二維
		for j in height:
			array[i].append(null)
	return array
#做棋盤END

#棋盤轉成像素圖START
func GridToPixel(column, row):
	var newX = xStart + offset * column
	var newY = yStart + -offset * row
	return Vector2(newX,newY)
#棋盤轉成像素圖END

#放旗子上去START
func SpawnPieces():
	for i in width:
		for j in height:
			#隨機數字 存著
			var randrum = floor(rand_range(0, possiblePieces.size()))
			var loops = 0
			var piece = possiblePieces[randrum].instance()
			while(MatchAt(i, j, piece.pieceColor) && loops < 100):
				randrum = floor(rand_range(0, possiblePieces.size()))
				loops += 1
				piece = possiblePieces[randrum].instance()
			#隨機放一個顏色
			
			#把棋子弄成棋盤的child
			add_child(piece)
			piece.position = GridToPixel(i,j)
			allPiece[i][j] = piece
	pass
#放旗子上去END

#確保第一次放的棋子沒有3個連在一起START
func MatchAt(column , row, color):
	if column > 1 :
		if allPiece[column-1][row] != null && allPiece[column-2][row] != null:
			if allPiece[column-1][row].pieceColor == color && allPiece[column-2][row].pieceColor == color:
				return true
	if row > 1 :
		if allPiece[column][row-1] != null && allPiece[column][row-2] != null:
			if allPiece[column][row-1].pieceColor == color && allPiece[column][row-2].pieceColor == color:
				return true
#確保第一次放的棋子沒有3個連在一起END

#定位目前點擊的位置START
func TouchInput():
	if Input.is_action_just_pressed("ui_touch"):
		if IsInGrid( PixelToGrid(get_global_mouse_position().x, get_global_mouse_position().y ) ):
			controlling = true
			firstTouch = PixelToGrid( get_global_mouse_position().x, get_global_mouse_position().y )
			print(firstTouch)
			
	if Input.is_action_just_released("ui_touch"):
		if IsInGrid( PixelToGrid(get_global_mouse_position().x, get_global_mouse_position().y ) ) && controlling:
			controlling = false
			finalTouch = PixelToGrid(get_global_mouse_position().x, get_global_mouse_position().y )
			TouchDifference( firstTouch, finalTouch)
			
			
	pass
#定位目前點擊的位置END

#交換棋子START
func SwapPieces(col, row, direction):
	var firstPiece = allPiece[col][row]
	var otherPiece = allPiece[col+direction.x][row+direction.y]
	if firstPiece != null && otherPiece != null:
		#交換位置
		allPiece[col][row] = otherPiece
		allPiece[col + direction.x][row + direction.y] = firstPiece
		#交換圖片
		firstPiece.move( GridToPixel(col + direction.x,row + direction.y) )
		otherPiece.move( GridToPixel(col, row) )
		FindMatch()
	pass
#交換棋子END

#判斷交換的方向START
func TouchDifference(grid1, grid2):
	var difference = grid2 - grid1
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			SwapPieces(grid1.x , grid1.y, Vector2(1, 0))
		elif difference.x < 0:
			SwapPieces(grid1.x , grid1.y, Vector2(-1, 0))
	elif abs(difference.x) < abs(difference.y):
		if difference.y > 0:
			SwapPieces(grid1.x , grid1.y, Vector2(0, 1))
		elif difference.y < 0:
			SwapPieces(grid1.x , grid1.y, Vector2(0, -1))
	pass
#判斷交換的方向END

#圖片轉換成棋盤上的座標START
func PixelToGrid(pixelX, pixelY):
	var newX = round((pixelX - xStart) / offset)
	var newY = round((pixelY - yStart) / -offset)
	return Vector2(newX,newY)
	pass
#圖片轉換成棋盤上的座標END

#確認有沒有點在棋盤上START
func IsInGrid(Position):
	if Position.x >= 0 && Position.x < width:
		if Position.y >= 0 && Position.y < height:
			return true
	return false
#確認有沒有點在棋盤上END

#移動棋子後 偵測有沒有配對成功的START
func FindMatch():
	for i in width:
		for j in height:
			if allPiece[i][j] != null:
				var currentColor = allPiece[i][j].pieceColor
				if i > 0 && i < width - 1:
					if allPiece[i-1][j] != null && allPiece[i+1][j] != null:
						if allPiece[i-1][j].pieceColor == currentColor && allPiece[i+1][j].pieceColor == currentColor:
							allPiece[i-1][j].matched = true
							allPiece[i-1][j].dim()
							allPiece[i][j].matched = true
							allPiece[i][j].dim()
							allPiece[i+1][j].matched = true
							allPiece[i+1][j].dim()
				if j > 0 && j < height - 1:
					if allPiece[i][j-1] != null && allPiece[i][j+1] != null:
						if allPiece[i][j-1].pieceColor == currentColor && allPiece[i][j+1].pieceColor == currentColor:
							allPiece[i][j-1].matched = true
							allPiece[i][j-1].dim()
							allPiece[i][j].matched = true
							allPiece[i][j].dim()
							allPiece[i][j+1].matched = true
							allPiece[i][j+1].dim()
	get_parent().get_node("destoryTImer").start()
#移動棋子後 偵測有沒有配對成功的END

#逐個確認棋子是否符合消失的條件START
func DestoryMatched():
	for i in width:
		for j in height:
			if allPiece[i][j] != null:
				if allPiece[i][j].matched:
					allPiece[i][j].queue_free()
					allPiece[i][j] = null
	get_parent().get_node("collapseTimer").start()
#逐個確認棋子是否符合消失的條件END

#確認棋子是否符合落下的條件START
func CollapseColumn():
	for i in width:
		for j in height:
			if allPiece[i][j] == null:
				for k in range(j+1, height):
					if allPiece[i][k] != null:
						allPiece[i][k].move(GridToPixel(i, j))
						allPiece[i][j] = allPiece[i][k]
						allPiece[i][k] = null
						break 
	get_parent().get_node("refillTimer").start()
#確認棋子是否符合落下的條件END

func RefillCol():
	for i in width:
		for j in height:
			if allPiece[i][j] == null:
				#隨機數字 存著
				var randrum = floor(rand_range(0, possiblePieces.size()))
				var loops = 0
				var piece = possiblePieces[randrum].instance()
				while(MatchAt(i, j, piece.pieceColor) && loops < 100):
					randrum = floor(rand_range(0, possiblePieces.size()))
					loops += 1
					piece = possiblePieces[randrum].instance()
				#隨機放一個顏色
				
				#把棋子弄成棋盤的child
				add_child(piece)
				piece.position = GridToPixel(i,j - yOffset)
				piece.move(GridToPixel(i,j))
				allPiece[i][j] = piece
	
	

#把棋子消失 START
func _on_destoryTImer_timeout():
	DestoryMatched()
	pass # Replace with function body.
#把棋子消失 END

#讓上面的棋子掉下來START
func _on_collapseTimer_timeout():
	CollapseColumn()
	pass
#讓上面的棋子掉下來END

func _on_refillTimer_timeout():
	RefillCol()
	print("HI")
	pass # Replace with function body.


#GML的step
func _process(delta):
	TouchInput()
	pass
	


