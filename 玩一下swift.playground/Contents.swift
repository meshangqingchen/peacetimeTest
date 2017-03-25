//: Playground - noun: a place where people can play

import UIKit

func sum( _ num1 : Int,_ mum2 : Int) ->Int {
    return num1 + mum2
}

//let re = sum(num1: 1, mum2: 2)
//sum(abc: 2, mum2: 2)
sum(20, 30)

//结构体

struct Location {
    

    
    //属性
    var x : Double
    var y : Double
    //结构体的方法
    func test() -> Int {
        print("结构体重test的函数")
        return 10;
    }
    //结构体中改变成员属性
    mutating func moveH(distance : Double)  {
        self.x += distance
    }
    //给我们的结构体扩充 构造函数
    //1>默认情况下 会为每一个结构体提供一个默认的构造函数,该构造函数要求给每一个成员变量进行赋值
    //2>构造函数都是init开头,并且构造函数不需要返回值
    init(x : Double, y : Double) {
        self.x = x
        self.y = y
        print("asd")
    }
    
    init(xyStr : String) {
        let array = xyStr.components(separatedBy: ",")
        print(array)
        let item1 = array[0]
        let item2 = array[1]
//        self.x = Double(item1)
//        self.y = Double(item2)
//        if let x = Double(item1) {
//            self.x = x
//        }else{
//            self.x = 0
//        }
//        
//        if let y = Double(item2) {
//            self.y = y
//        }else{
//            self.y = 0
//        }
        
        //直接解包太危险了.....
//        self.x = Double(item1)!
//        self.y = Double(item2)!
        self.x = Double(item1) ?? 0
        self.y = Double(item2) ?? 0
//        print("self : \()")

        
        
    }
    
}

var centrt : Location = Location(x: 20, y: 20)
let xx = centrt.x
//let yy = Location.y


let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
centrt.test()
centrt.moveH(distance: 20)
print(centrt.x)

Location(x: 2, y: 3)

let centera = Location(xyStr: "1,3")
print(centera)






