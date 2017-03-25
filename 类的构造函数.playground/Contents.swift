//: Playground - noun: a place where people can play

import UIKit

class Person {
    var name : String = ""
    var age : Int = 0
    
    init() {
        
    }
    
    init(name : String, age : Int) {
        self.name = name
        self.age = age
    }
    // Dictionary<String , Any> --> [String : Any]
    init(dic : Dictionary<String , Any>) {
        /*
        let dicName = dic["name"]
        name = dicName as! String
        */
        if let name = dic["name"] as? String{
            self.name = name
        }
        if let age = dic["age"] as? Int {
            self.age = age
        }
        
    }
    
}

let p = Person()
let p1 = Person(name: "lcc", age: 18)
let p3 = Person(dic: ["name":"sh","age":18])

class student : NSObject{
    var name : String = ""
    var age : Int = 0
    var height : Double = 0.0
    //kvc 赋值 
    /*
     1必须继承NSObject
     2必须在构造函数中,先调用super.init()
     3调用setValuesForKeys
     4如果字典中有一个key没有对应的属性,则需要重写我们的setvalue forUndefinedKey 这个方法
     */
    init(dicKvc : [String : Any]) {
        super.init()
        setValuesForKeys(dicKvc)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}

let s  = student(dicKvc: ["name" : "lcc","age" : 18,"height" : 188 ,"phone":"+86 110"])






























