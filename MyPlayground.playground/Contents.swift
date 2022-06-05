import UIKit

var greeting = "Hello, playground"
print(greeting)

let long: Optional<Int> = Int("42")
let short: Optional<Int> = Int("42")


var optionalValue: Int? = 1
if let value = optionalValue {
    print("Value: '\(value)'")
} else {
    print("Couldn't bind an optional value")
}

//if optionalImagePath.hasSuffix(".png") == true {
//    print("The image is in PNG format")
//}

var result: Int
if let value = optionalValue {
    result = value
} else {
    result = 0
}

// ??を使った書き方
result = optionalValue ?? 0
print(result)

// !をつけることで強制アンラップをすることができる
// しかし、万が一nilに対して強制アンラップをしてしまうと、
// exeptionを吐いてアプリがクラッシュしてしまう

func greet(person: String) -> String {
    let greeting = "Hello" + person + "!"
    // 関数の中身が1行のみの場合はreturnを省略できる
    return greeting
}

// 関数の引数に呼び出し用の名前をつけて、可読性を上げることも可能
func greet(person: String, from hometown: String) -> String {
    "Hello \(person)! Grad you could visit from \(hometown)"
}
print(greet(person: "Bill", from: "Cupertino"))

// クロージャ
// 受け渡しが可能な関数
// 例：配列の名前を逆アルファベット順に並び替える
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var sortedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})
