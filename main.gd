extends Control

@onready var type_select: MenuButton = %TypeSelect
@onready var typelabel: Label = %Typelabel
var machineType:int = 1 #global var for machine type

@onready var box_select: MenuButton = %BoxSelect
@onready var boxlabel: Label = %Boxlabel
var boxType:int = 1 #global var for box type

@onready var length_show: Label = %lengthShow
@onready var width_show: Label = %widthShow
@onready var height_show: Label = %heightShow

#input
@onready var length_edit = $Base/SizeContainer/lengthEdit
@onready var width_edit = $Base/SizeContainer/widthEdit
@onready var height_edit = $Base/SizeContainer/heightEdit
@onready var clarger_edit = $Base/InputsContainer/clargerEdit
@onready var thickness_edit = $Base/InputsContainer/thicknessEdit
@onready var unitprice_edit = $Base/InputsContainer/unitpriceEdit
@onready var weight_edit = $Base/InputsContainer/weightEdit


var i_length: float = 0.0
var i_width: float = 0.0
var i_height: float = 0.0
var i_clarger: float = 0.0
var i_thickness: float = 0.0
var i_unitprice: float =0.0
var i_weight: float = 0.0
#

#output
@onready var mem_width = $Base/memWidth
@onready var side_bar = $Base/sideBar
@onready var mem_cf = $Base/memCF
@onready var mem_len = $Base/memLen
@onready var single_weight = $Base/singleWeight
@onready var estmem_num = $Base/estmemNum
@onready var singlemem_cost = $Base/singlememCost
@onready var mem_density = $Base/memDensity

var o_mem_width: float = 0.0 #膜宽
var o_side_bar: float = 0.0 #插边
var o_mem_cf: float = 0.0 #膜周长
var o_mem_len: float = 0.0 #膜长度
var o_single_weight: float = 0.0 #单个袋子重
var o_estmem_num: float = 0.0 #袋子数
var o_singlemem_cost: float = 0.0 #单价
var o_mem_density: float = 0.945 #膜密度
#

const BOX_TYPE_1 = preload("res://mtwlogo/boxType1.png")
const BOX_TYPE_2 = preload("res://mtwlogo/boxType2.png")
const BOX_TYPE_3 = preload("res://mtwlogo/boxType3.png")
const BOX_TYPE_4 = preload("res://mtwlogo/boxType4.png")
const BOX_TYPE_5 = preload("res://mtwlogo/boxType5.png")
@onready var boxillustrate = %Boxillustrate

const MACHINE_TYPE_2 = preload("res://mtwlogo/machineType2.png")
const MACHINE_TYPE_13 = preload("res://mtwlogo/machineType13.png")
@onready var membraneillustrate = %membraneillustrate

func _ready():
	var TypePopup = type_select.get_popup()
	TypePopup.connect("id_pressed", SelectTypeMenu)
	
	var BoxPopup = box_select.get_popup()
	BoxPopup.connect("id_pressed", SelectBoxMenu)
	
	#mem_width.text="ddd"+"\n"+"213"
	#boxillustrate.texture=BOX_TYPE_1
	RefreshDisp()

func _process(delta: float) -> void:
	length_show.text=length_edit.text
	width_show.text=width_edit.text
	height_show.text=height_edit.text
	if boxType==3:
	#	length_show.text="直径: "+length_edit.text
		width_show.text=""
	match boxType:
		1:
			length_show.position.x=790;length_show.position.y=260
			width_show.position.x=680;width_show.position.y=260
			height_show.position.x=605;height_show.position.y=160
		2:
			length_show.position.x=790;length_show.position.y=260
			width_show.position.x=680;width_show.position.y=260
			height_show.position.x=605;height_show.position.y=160
		3:
			length_show.position.x=740;length_show.position.y=70
			#width_show.position.x=680;width_show.position.y=260
			height_show.position.x=605;height_show.position.y=160
		4:
			length_show.position.x=810;length_show.position.y=250
			width_show.position.x=670;width_show.position.y=250
			height_show.position.x=605;height_show.position.y=160
		5:
			length_show.position.x=770;length_show.position.y=300
			width_show.position.x=660;width_show.position.y=280
			height_show.position.x=605;height_show.position.y=160
	#modify part
	length_show.position.x-=100
	width_show.position.x-=100
	height_show.position.x-=120
	height_show.position.y+=20
	#print(length_edit.text)
	#print(length_show.text)

func RefreshDisp()->void:
	typelabel.set("theme_override_colors/font_color",Color.BLACK)
	boxlabel.set("theme_override_colors/font_color",Color.BLACK)
	typelabel.add_theme_font_size_override("font_size", 24)
	boxlabel.add_theme_font_size_override("font_size", 24)
	match machineType:
		1:
			typelabel.text="M型卷膜正套(标准机)"
			membraneillustrate.texture=MACHINE_TYPE_13
		2:
			typelabel.text="平口型卷膜制具式套袋"
			membraneillustrate.texture=MACHINE_TYPE_2
		3:
			typelabel.text="M型卷膜制具式套袋"
			membraneillustrate.texture=MACHINE_TYPE_13
	match boxType:
		1:
			boxlabel.text="长方形纸箱" # 非正方形纸箱
			boxillustrate.texture=BOX_TYPE_1
		2:
			boxlabel.text="正方形纸箱"
			boxillustrate.texture=BOX_TYPE_2
		3:
			boxlabel.text="圆桶"
			boxillustrate.texture=BOX_TYPE_3
		4:
			boxlabel.text="胶框"
			boxillustrate.texture=BOX_TYPE_4
		5:
			boxlabel.text="正方形桶"
			boxillustrate.texture=BOX_TYPE_5
			
# id==0		机型a	# id==1		机型b	# id==2		机型c
func SelectTypeMenu( menu_id ):
	match menu_id:
		0:
			machineType=1
			#print("new")
		1:
			machineType=2
			#print("open")
		2:
			machineType=3
			#print("save")
	RefreshDisp()

func SelectBoxMenu( menu_id ):
	match menu_id:
		0:boxType=1
		1:boxType=2
		2:boxType=3
		3:boxType=4
		4:boxType=5
	RefreshDisp()

func _on_calc_btn_pressed() -> void:
	#start calc
	i_length=float(length_edit.text) #长
	i_width=float(width_edit.text) #宽
	i_height=float(height_edit.text) #高
	i_clarger=float(clarger_edit.text) #膜周长比产品大多少
	i_thickness=float(thickness_edit.text) #膜厚度几个丝
	i_unitprice=float(unitprice_edit.text) #卷膜1kg市场价
	i_weight=float(weight_edit.text) #卷膜重量

	if machineType==1: #M型卷膜正套（标准机）
		if boxType==1 || boxType==2 || boxType==4: 
			o_mem_cf=(i_length+i_width)*2.0+i_clarger
			o_mem_width=i_length+20.0
			o_mem_len=i_height+260.0+i_width	
		if boxType==3:
			o_mem_cf=i_length*3.14+i_clarger
			o_mem_width=i_length+20.0
			o_mem_len=i_height+300.0+i_length/2
		if boxType==5:
			o_mem_cf=(i_length+i_width)*2.0+i_clarger
			o_mem_width=(o_mem_cf-20.0)/8.0*2.0+10.0 
			o_mem_len=i_height+260.0+i_width/2
		o_side_bar=(o_mem_cf-o_mem_width*2.0)/4.0
		o_single_weight=o_mem_cf*o_mem_density*i_thickness*0.001*o_mem_len*0.01
		o_estmem_num=i_weight/o_single_weight*1000
		o_singlemem_cost=i_weight*i_unitprice/o_estmem_num
	
	if machineType==2: #平口型卷膜制具式套袋
		if boxType==1 || boxType==2 || boxType==4 || boxType==5:
			o_mem_cf=(i_length+i_width)*2.0+i_clarger 
			o_mem_len=i_height+260.0+i_width 
		if boxType==3:
			o_mem_cf=i_length*3.14+i_clarger
			o_mem_len=i_height+i_length/2+300
		o_mem_width=o_mem_cf/2 
		o_single_weight=o_mem_len*o_mem_cf*o_mem_density*0.001*i_thickness*0.01 
		o_estmem_num=i_weight/o_single_weight*1000 
		o_singlemem_cost=i_weight*i_unitprice/o_estmem_num
		o_side_bar=0#null

	if machineType==3: #M型卷膜制具式套袋
		if boxType==1 || boxType==2 || boxType==4 || boxType==5: 
			o_mem_cf=(i_length+i_width)*2.0+i_clarger 
			o_mem_len=i_height+i_width+260.0 
		if boxType==3:
			o_mem_cf=i_length*3.14+i_clarger
			o_mem_len=i_height+i_length/2+300.0
		o_mem_width=i_length+100.0 
		o_side_bar=(o_mem_cf-o_mem_width*2)/4 
		o_single_weight=o_mem_len*i_thickness*o_mem_cf*0.001*0.01*o_mem_density 
		o_estmem_num=i_weight*1000/o_single_weight 
		o_singlemem_cost=i_weight*i_unitprice/o_estmem_num 

	mem_width.text="膜宽(Bag Width):"+" "+str(o_mem_width)+"mm"
	mem_cf.text="膜周长(Bag Circumference):"+" "+str(o_mem_cf)+"mm"
	side_bar.text="插边(gussets Length):"+" "+str(o_side_bar)+"mm"
	mem_len.text="膜长度(Bag length):"+" "+str(o_mem_len)+"mm"
	single_weight.text="单袋重量(weight/pcs):"+" "+str(snapped(o_single_weight,0.001))+"g"
	estmem_num.text="整卷袋子数量"+"\n"+"(Number of bags):"+" "+str(snapped(o_estmem_num,0.01))+"pcs"
	singlemem_cost.text="单袋成本(cost/pcs):"+" "+str(snapped(o_singlemem_cost,0.001))+"元"
	
