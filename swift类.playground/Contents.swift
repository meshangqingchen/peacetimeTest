//: Playground - noun: a place where people can play

import UIKit

class Person {
    var name : String = ""
    var age : Int = 0
    var view : UIView?
    
    
    
}

let p = Person()
p.name = "why"
p.age = 18
p.view = UIView()
print(p.name)
print(p.age)
print(p.view ?? 0)


class student {
    //存储属性
    var name : String = ""
    var age : Int = 0
    var mathScore : Double = 0.0
    var chineseScore: Double = 0.0
    //计算属性 只有get方法 没有写set放就是只读属性
    var averageScore : Double{
        return (mathScore + chineseScore)*0.5
    }
    //set get 方法
    var averageScore1 : Double {
        set{
            //set方法怎么写?
        }
        get{
            return (mathScore + chineseScore)*0.5
        
        }
    
    }
    //方法
    func getAverageScore() -> Double {
        return (mathScore + chineseScore)*0.5
    }

    
}

let stu = student()
stu.name = "haha"
stu.age = 18
stu.mathScore = 90.2
stu.chineseScore = 30.2

//stu.getAverageScore()
print(stu.getAverageScore())
print(stu.averageScore)


class person1 {
    var name : String = "a" {
        //属性监听器
        //监听我们的属性 即将改变
        willSet{
            print("name属性\(self.name)即将改变")
            print(newValue)
        }
        //监听我们的属性 已经改变
        didSet{
            print("name属性已经变成\(self.name)")
            print(oldValue)
        }
    }
    
}

let pp: person1 = person1()
pp.name = "why"
pp.name = "lcc"









