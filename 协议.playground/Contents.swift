//: Playground - noun: a place where people can play

import UIKit

//协议
protocol SpotProtocol{
    // 默认协议里的方法都是必须实现的
    func playBasketball()
}

class student : NSObject ,SpotProtocol{
    func playBasketball() {
        print("学生打篮球")
    }
}

class Teacher :SpotProtocol {
    func playBasketball() {
        print("老师打篮球")
    }
}

// 一个协议可 可能被 枚举 遵守 可能被 结构体遵守
enum MethodType : SpotProtocol{
    func playBasketball() {
        
    }
}

// 加上class 之后就表示只能被 类对象遵守 所以这时候可以用 weak来 修饰这个代理 
// weak 可不能修饰结构体和 枚举 所以才有 会有 带有class 关键字的协议
protocol BuyTickDelegate :class{
    func butyTick()
}

class Person0 {
    //定义代理属性
   weak var delegate : BuyTickDelegate?
    func gotoBieJing() {
        delegate?.butyTick()
    }
}

class Person1 : BuyTickDelegate{
    var p0 : Person0? = nil

    func butyTick() {
        print("卖个票")
    }
}

//let p0 = Person0()
////p0.delegate =
//let p1 = Person1()
//p0.delegate = p1
//print(p0.delegate)
//
//p0.gotoBieJing()

let p1 = Person1()  // 类似我们的控制器
let p00 = Person0() // 类似我们的tableView
p1.p0 = Optional(p00)
p1.p0?.delegate = p1
p1.p0?.gotoBieJing()


//可选类型
// optional是OC的特性 如果协议中有可选择的方法,那么必须在optional前面加上@obj 在protocol前面加上@objc
@objc protocol testProtocol{
   @objc optional func test()
}

class Dog : testProtocol {
    func test() {
        
    }
}


























