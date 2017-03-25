//: Playground - noun: a place where people can play

import UIKit

class Person {
    var name : String = ""
    var dog : Dog?
    
}

class Dog {
    var weight : Double = 0.0
    var toy : Toy?
}

class Toy {
    var price : Double = 0.0
    func flying()  {
        print("飞盘在飞")
    }
    
}

let p = Person()
p.name = "why"

let d = Dog()
d.weight = 60.0

let t = Toy()
t.price = 100

p.dog = d
d.toy = t

//3可选链的使用
//3.1 取出why狗的玩具的价格
/* 强制解包 很危险
let dog = p.dog
let toy = dog!.toy
let price = toy!.price
*/

/* 有点麻烦
if let dog = p.dog {
    if let toy = dog.toy {
        let price = toy.price
    }
}
*/

// ?. 就是可选链: 系统会自动判断可选类型是否有值 如果有值 则解包,没有则赋值为nil
// 可选链获取的值一定是一个可选类型
let price = p.dog?.toy?.price
print(price)

if let price = p.dog?.toy?.price {
    print(price)
}

//3.2 给狗的玩具赋值一个新的价格
let ddd = p.dog
let ttt = ddd!.toy
ttt!.price = 123

if let dd = p.dog {
    if let tt = dd.toy {
        tt.price = 123
    }
}
//如果可选链中有一个 可选类型没有值 那么这条语句不执行
p.dog?.toy?.price = 50

//3.3 可选链调用方法
if let dog = p.dog{
    if let toy = dog.toy {
        toy.flying()
    }
}

let ccc = p.dog?.toy
print(ccc)
ccc?.flying()


















