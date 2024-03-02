**节点(Node)** 是Godot中的基本单位。

> 众所周知Node是并不存在的。它从未存在，现在不存在，将来也不会存在于这个宇宙位元的任何一处。
> 它就像这个世界的镜像一般可见而不可触及，正如光与影、正与负、阳与阴一般，相互依存而不可归一。
> 它的自我保护机能让它远离一切可能的危害以避免湮灭，然而其必然存在的邪恶念头并不反对将某些玩物引入来取得奇怪的恶趣味。
> 这也是Godot引入Node的原因。
>
> 于是便有无数人翻找着早已泛黄的故纸经卷，寻找Node在这个世界的踪迹，却无一例外地在这个世界的尽头找到了一片空白。
> 大浪淘沙，找寻Node的伟人已长眠于黄土之下，他们短暂的存在也只是为了剥离Node真相之外的一小块晶莹透明但终归是虚无的碎片。
> 不过，正所谓“无观察者的对象毫无意义”，Node这一概念的存在本身就证明了它可探索、可利用的本质，即使它并不存在于这个世界。
> 在114514代人的努力之下，终于，一个名为[撒碧](https://github.com/Andy-Elizabeth-mouse/)的人站在了前人尸体所垒成的高山之巅，跃至[世界之外](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/nodes_and_scene_instances.html)，在其中窥见了[主之真意的一角](https://docs.godotengine.org/zh-cn/4.x/classes/class_node.html)。
> 这便是这一文档的由来。

>下面是Github Copilot给出的解释：
>Node是一个抽象的概念，它可以是一个2D或3D的对象，也可以是一个UI控件，甚至可以是一个脚本。Node可以包含其他Node，这样就形成了一个树形结构。这个树形结构就是Godot的场景。

实际上，Node就是一个对象，它包含了一些变量和函数，每一帧根据给定的代码产生一定的变化，显示在屏幕上，组成了我们所看到的游戏画面。

我们可以在Godot右侧看到选中的Node的属性。

![img](./res/ck.png)

从图中可以看出，该节点名为Button，继承关系为`Node -> CanvasItem -> Control -> BaseButton -> Button`。每一个父类中都有可以调节的参数。最后一行的`Script`显示了这个节点绑定的脚本。在图片中，绑定的脚本是`click.gd`。最下角有一个“添加元数据”按钮，点击后可以添加自定义的元数据（相当于给这个类添加一个变量成员）。

游戏运行时修改Node中的属性一般有以下几种方法：

1. 挂载脚本，通过脚本中的代码控制。
2. 在其他脚本中通过`get_node`函数获取节点，再读取或写入节点的属性。

### 代码中获取节点

`get_node`可以像访问文件一样在节点树中查找节点。例如，`get_node("Button")`可以获取到当前节点的子节点`Button`，`get_node("../Button")`可以获取到当前节点的父节点的子节点（即兄弟（同级）节点）`Button`。

`get_node`还可以通过`$`符号来简化。例如，`$Button`等价于`get_node("Button")`。

可以通过`find_child`、`find_children`、`find_parent`、`get_parent`等函数来获取父节点或子节点，这些函数的具体用法可以在[官方文档](https://docs.godotengine.org/zh-cn/4.x/classes/class_node.html#id4)中找到。

Node有一个`group`属性，这个属性可以用来将节点分组。可以把它想成给节点贴的标签，比如节点猫、狗、猪，可以给它们贴上“动物”这个标签。这样，当需要对所有动物进行操作时，可以通过标签来获取所有动物节点。

为了获取一个`group`中的所有节点，需要先使用`get_tree`函数获取场景树，然后使用`get_nodes_in_group`函数获取这个组中的所有节点。

```gdscript
var animals = get_tree().get_nodes_in_group("动物")
```

`get_tree`函数返回的是一个`SceneTree`对象，这个对象包含了整个场景的信息，可以通过它来获取场景中的节点。

可以通过`get_groups`函数获取节点已被添加到的所有组的名称列表，通过`add_to_group`和`remove_from_group`函数来将节点添加到或移除出组。

### 代码中修改节点属性

获取节点后，就基本上可以随意修改节点的属性了。

可修改的属性包括但不限于：

- 节点的属性
- 节点父类的属性
- 节点所挂载的脚本的属性

修改属性的方法是直接赋值。例如，`get_node("Button").text = "Hello"`可以将`Button`节点的`text`属性修改为`Hello`。

### 代码中创建节点

直接调用某一类的实例化函数即可创建一个节点，调用`add_child`函数将其添加为脚本所在的节点的子节点。

```gdscript
var sprite2d

func _ready():
	var sprite2d = Sprite2D.new()
	add_child(sprite2d)
```

### 代码中删除节点

调用`queue_free`函数即可删除节点。这个函数会在当前帧结束后删除节点。

```gdscript
get_node("Button").queue_free()
```

调用`free`函数可以立即删除节点。使用时需要小心点。

```gdscript
get_node("Button").free()
```

### 预制！

用过Unity的小伙伴都知道，Unity中有个东东叫做预制体（Prefab）。添加了一系列对象（比如放一个平台，平台上放个球和一个方块，复杂点的话，给球添加一个脚本，用AI实现球追着方块移动，再给方块添加一个脚本，当球碰到方块时，方块重新生成在另一个位置）后，把这个整体拖到资源管理器中，诶！它变蓝了！

这玩意就变成预制体了，可以使用代码生成无数个这一整体，让无数个球在无数个平台上追着无数个方块跑。

Godot中也有类似的东西，执行类似的操作后，可以将这个整体保存为一个.tscn文件。不过它不叫Prefab，而叫做PackedScene。（不过无所谓啦，反正都是Node）

可以使用`load`函数加载一个PackedScene，然后使用`instance`函数实例化一个节点。

```gdscript
var scene = load("res://scene.tscn")
var node = scene.instance()
add_child(node)
```

`load`函数是即时的，它在调用的时候才会加载资源。如果我们有1145141919810个PackedScene需要加载呢？它就会变得特\~别\~特\~别慢。

咋办呢？Godot给我们提供了一个`preload`函数，它会在编译器读取脚本的时候就加载资源，这样就不会在游戏运行时卡顿了。

```gdscript
var scene = preload("res://scene.tscn")
var node = scene.instance()
add_child(node)
```

哦，对了，`preload`是一个关键字哦。