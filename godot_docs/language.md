Godot官方提供两者编程语言的支持：GDScript和C#。
GDScript和Python非常相似，该文档介绍的就是GDScript。如果需要使用C#，先在网上找教程学学。

先上[官方文档](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdscript/gdscript_basics.html)。

GDScript和Python主要有以下几点不同：

1. GDScript中变量声明需要加前缀。
    python:
    ```python
    a = 1
    ```
    gdscript:
    ```gdscript
    var a = 1
    const b = 2 # 常量
    ```

2. 可以很方便地声明未初始化的变量。
    gdscript:
    ```gdscript
    var a
    ```

3. 可以使用`static`关键字声明静态变量（与C系列语言中的静态变量类似）。
    gdscript:
    ```gdscript
    static var a = 1
    ```

4. 字典可以使用Lua风格的语法。
    python:
    ```python
    d = {
        "some_key": 2,
        "other_key": [2, 3, 4],
        "more_key": "Hello"
    }
    ```
    gdscript:
    ```gdscript
    var d = {
        "some_key": 2,
        "other_key": [2, 3, 4],
        "more_key": "Hello"
    }
    # 或者
    var d = {
        some_key = 2,
        other_key = [2, 3, 4],
        more_key = "Hello"
    }
    ```

5. GDScript中没有`None`，使用`null`代替。
    python:
    ```python
    a = None
    ```
    gdscript:
    ```gdscript
    var a = null
    ```

6. GDScript中没有`True`和`False`，使用`true`和`false`代替。
    python:
    ```python
    a = True
    b = False
    ```
    gdscript:
    ```gdscript
    var a = true
    var b = false
    ```

7. 函数声明需要加`func`关键字而不是`def`。
    python:
    ```python
    def some_function():
        pass
    ```
    gdscript:
    ```gdscript
    func some_function():
        pass
    ```

8. 函数前面可以加`static`关键字声明静态函数。
    gdscript:
    ```gdscript
    static func some_function():
        pass
    ```

9. lambda表达式的形式与Python不同。
    python:
    ```python
    f = lambda x: x + 1
    ```
    gdscript:
    ```gdscript
    var f = func(x):
        return x + 1
    ```
    Python中的lambda表达式只能包含一个表达式（类似于表达式中间print一下过程这种操作肯定是做不到的），而GDScript中的lambda表达式可以包含多条语句。
    
    Python中的lambda表达式就真的只是一个表达式，不用写return，而GDScript中的lambda表达式在需要返回值的时候必须写return。

10. `for`循环得到了一个小小的扩展。
    python:
    ```python
    for i in range(10):
        print(i)
    ```
    gdscript:
    ```gdscript
    for i in 10:
        print(i)
    # 当然也可以用python的写法
    for i in range(10):
        print(i)
    ```

11. 新增了`match`语句。
    `match`语句类似于C系列语言中的`switch`语句，但是更加强大。
    gdscript:
    ```gdscript
    match some_value:
        1:
            print("one")
        2:
            print("two")
        3:
            print("three")
        _:
            print("other")
    ```
    关于`match`语句的更多内容可以参考[官方文档](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdscript/gdscript_basics.html#match)。

12. `yield`关键字被大砍一刀，目前为版本下水道。
    `yield`关键字在3.x版的GDScript中用于协程，可以参考[官方文档](https://docs.godotengine.org/zh-cn/3.x/tutorials/scripting/gdscript/gdscript_basics.html#coroutines-with-yield)。
    无法像Python那样使用`yield`关键字作为生成器。

13. **整个文件都是一个巨大的类。**

14. 类中的方法不需要`self`参数。但是如果需要访问类的成员变量，需要加`self`。
    python:
    ```python
    class SomeClass:
        def __init__(self):
            a = 1
        def add_a(self, b):
            return a + b
    ```
    gdscript:
    ```gdscript
    class SomeClass:
        func _init():
            self.a = 1
        func add_a(b):
            return self.a + b
    ```

15. 类继承的方式不同。
    python:
    ```python
    class SomeClass(ParentClass):
        pass
    ```
    gdscript:
    ```gdscript
    class SomeClass extends ParentClass:
        pass
    ```

16. 没有`import`关键字。
    这造成了以下变化：
    1. 使用其他文件中的类时，需要用`load`函数或者`preload`函数加载。
        ```gdscript
        var SomeClass = preload("res://some_class.gd")
        ```
    2. 继承其他文件中的类时，有特殊的语法。
        ```gdscript
        extends "some_class.gd"
        # 或者
        extends "some_class.gd".SomeClass
        ```

17. `super`关键字的使用方式不同。
    python:
    ```python
    class SomeClass(ParentClass):
        def __init__(self):
            super().__init__()
    ```
    gdscript:
    ```gdscript
    class SomeClass extends ParentClass:
        func _init():
            super()
    ```

18. 魔法函数的命名形式不同。
    以构造函数为例：
    python:
    ```python
    class SomeClass:
        def __init__(self):
            pass
    ```
    gdscript:
    ```gdscript
    class SomeClass:
        func _init():
            pass
    ```

19. 不支持重载运算符。

20. 不支持多重继承（一个类继承多个父类）。

21. 类的实例化方式不同。
    python:
    ```python
    a = SomeClass()
    ```
    gdscript:
    ```gdscript
    var a = SomeClass.new()
    ```

22. getter/setter
    python中没有getter/setter的概念。
    getter/setter可以在变量被读取或者写入的时候执行一些操作。可以看作是给变量的读取和写入分别定义了一个函数。
    gdscript:
    ```gdscript
    var milliseconds: int = 0
    var seconds: int:
        get:
            return milliseconds / 1000
        set(value):
            milliseconds = value * 1000
    ```
    可以将函数赋值给getter/setter。
    ```gdscript
    var milliseconds: int = 0
    var seconds: int:
        get = get_seconds, set = set_seconds
    func get_seconds():
        return milliseconds / 1000
    func set_seconds(value):
        milliseconds = value * 1000
    ```
    在getter/setter内访问该变量，会直接访问该变量所代表的成员属性，不会导致getter/setter被无限次迭代调用，同时避免了显式声明另一个变量。
    ```gdscript
    signal changed(new_value)
    var warns_when_changed = "some value":
        get:
            return warns_when_changed
        set(value):
            changed.emit(value)
            warns_when_changed = value
    ```
    如果采取赋值的方式，这种情况同样适用。
    ```gdscript
    var my_prop: set = set_my_prop
    func set_my_prop(value):
        my_prop = value
    ```
    但是，在getter/setter内调用访问该变量的函数，会导致getter/setter被无限次迭代调用。
    下面的代码会导致无限递归调用。
    ```gdscript
    var my_prop:
        set(value):
            set_my_prop(value)
    func set_my_prop(value):
        my_prop = value
    ```
    有关getter/setter的详细内容可以参考[官方文档](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdscript/gdscript_basics.html#properties-setters-and-getters)。

23. GDScript中新增`signal`关键字用于声明信号。
    “信号”于其他语言中的“事件”类似，用于在某些条件下通知其他对象。
    声明信号的语法如下：
    ```gdscript
    signal some_signal
    ```
    为了让其他对象能够接收到信号，需要使用`connect`函数连接信号和槽。
    ```gdscript
    some_signal.connect(_on_some_signal)
    ```
    发出信号的语法如下：
    ```gdscript
    some_signal.emit()
    ```
    信号可以带参数。
    ```gdscript
    signal some_signal_with_args(arg1, arg2)
    ```
    带参数的信号所连接的函数肯定要有相同数量和类型的参数。
    发出带参数的信号的语法如下：
    ```gdscript
    some_signal_with_args.emit(1, 2)
    ```
    有关信号的详细内容可以参考[官方文档](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdscript/gdscript_basics.html#signals)和[信号专题](./signal.md)。

24. GDScript中没有`with`关键字。

25. **GDScript中没有`try...except...finally`语句！**
    官方对此的解释：
    > 我们相信无论如何游戏都不应该崩溃。如果发生意外情况，Godot将打印一个错误（甚至可以追溯到脚本），但之后它会尽可能优雅地恢复，并继续前进。
    >
    > 此外，异常会显著增加可执行文件的二进制大小。
    
    实际上，在调试过程中，确实存在异常。此时，程序将会停止运行，并在Godot编辑器中跳转到出现异常的地方。
    
    参见官方文档中的[为什么Godot不使用异常](https://docs.godotengine.org/zh-cn/3.x/about/faq.html#why-does-godot-not-use-exceptions)。

26. GDScript中的`assert`语句的使用方式不同。
    在上面一条中提到了Godot不使用异常，但是我们可以在调试过程中使用`assert`语句来检查某些条件是否满足。
    在非调试模式下，`assert`语句会被忽略。
    python中的`assert`语句：
    ```python
    assert some_condition, "some message"
    ```
    gdscript中的`assert`语句：
    ```gdscript
    assert(some_condition, "some message")
    ```

27. `await`关键字的使用方式不同，而且没有`async`关键字。
    和`yield`一样，`await`被削了，只能用于协程。
    [协程](https://zh.wikipedia.org/wiki/%E5%8D%8F%E7%A8%8B)和多线程可不同，协程像多线程，但是其本质只是暂停\~恢复\~，不会并行执行。
    使用协程的例子：
    ```gdscript
    func wait_confirmation():
        print("Prompting user")
        await $Button.button_up # Waits for the button_up signal from Button node.
        print("User confirmed")
        return true
    func request_confirmation():
        print("Will ask the user")
        var confirmed = await wait_confirmation()
        if confirmed:
            print("User confirmed")
        else:
            print("User cancelled")
    ```
    有关`await`的详细内容可以参考[官方文档](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdscript/gdscript_basics.html#awaiting-for-signals-or-coroutines)

唔...我能想到/查到的就这些了 (´・ω・`)