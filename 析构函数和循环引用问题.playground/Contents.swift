//: Playground - noun: a place where people can play

import UIKit

class person{
    var name : String = ""
    var age : Int = 0
    //重写我们的析构函数
    deinit {
        print("Person对象销毁")
    }
}

//var p = person()
//Optional(p) = nil
var p :person? = person()
p = nil

class person1 {
    var nane : String = ""
    weak var book :Book?
    deinit {
        print("person1对象销毁")
    }

}

class Book {
    var price :Double = 0.0
    var owner : person1?
    deinit {
        print("Book对象销毁")
    }

}

//var p2 = person1()
//p2.nane = "lcc"
//var book = Book()
//book.price = 60

var p2 : person1? = person1()
p2!.nane = "lcc"
var book : Book? = Book()
book!.price = 60


p2!.book = book
book!.owner = p2

p2 = nil
book = nil





















