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

// 型推論
sortedNames = names.sorted(by: {s1, s2 in s1 > s2})

// $による値参照
sortedNames = names.sorted(by: {$0 > $1})
// print(sortedNames)

// enum
enum CompassPoint {
    case north
    case south
    case east
    case west
}
var point = CompassPoint.north
// 型推論で省略可
point = .north

// よくswitch文と使う
let directionToHead: CompassPoint = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .west:
    print("Where the sun rises")
case .east:
    print("Where the skies are blue")
}
// この場合だとnorthの場合がprintされる

// defaultを指定可能
switch directionToHead {
case .north:
    print("Lots of planets have a north")
default: break
}

// Associated Values
enum State {
    case success
    case failure(Error)
}

// Switch文を用いてパターンマッチでエラーの値を取得
struct DummyError: Error{}
let state: State = .failure(DummyError())
switch state {
case .success: print("Success")
case let .failure(error): print("Failure: \(error)")
}

// 値型と参照型
// クラスとクロージャ以外で定義された型は全て値型
struct SomeStructure {
    var value: Int
}

var a = SomeStructure(value: 1)
var b = a

b.value = 2

print("a: \(a.value)")
print("b: \(b.value)")

// クラスとクロージャは参照型
class SomeClass {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

var c = SomeClass(value: 1)
var d = a
d.value = 2

print("c: \(c.value)")
print("d: \(d.value)")


// Swiftのメモリ管理はARC(Automatic Reference Counting)によって管理されている
// 新しいインスタンスを初期化する際に、ARCはそのインスタンスの型や保有するプロパティに応じてメモリを確保する
class Person {
    let name: String
    // var apartment: Apartment?   // PersonとApartmentがお互いに参照し合い、循環参照になってしまう。メモリ解放されない
    // 表示されなくなった
    
    // 解決するには
    // 弱参照（weak参照）を行う
    // 表示された
    // 弱参照は参照カウント数に加算されない
    weak var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person \(name) is being deinitialized.")
    }
}

class Apartment {
    let person: Person
    
    init(person: Person) {
        self.person = person
        person.apartment = self // 循環参照
    }
    
    deinit {
        print("Apartment is being deinitialized.")
    }
}

var person: Person? = Person(name: "Tom")
// Personの参照数1
var apartment: Apartment? = Apartment(person: person!)
// Personの参照数2
// Apartmentの参照数1

person = nil
// Personの参照数カウント1
apartment = nil
// Apartmentの参照数カウント0
// Personの参照数カウント0
// deinit時にprintすることでメモリが解放されるタイミングがわかるようになっている

// Protocol
// protocolは特定の機能に適したメソッドやpropertyなどのI/Fを定義し、それらをクラスや構造体、enumに適用することができる
protocol SomeProtocol {
    var mustBeSttable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    func someMethod()
}

// extensionによるprotocolのデフォルト実装
extension SomeProtocol {
    func someMethod() {
        print("someMethod called")
    }
}

// structへのprotocol適用
struct SomeStructures: SomeProtocol {
    var mustBeSttable: Int
    let doesNotNeedToBeSettable: Int
}

protocol AnotherProtocol {
    func anotherMethod()
}

// extrnsionによるprotocolの適用
extension SomeStructures: AnotherProtocol {
    func anotherMethod() {
        print("anotherMethod called")
    }
}
// 同じような機能を複数箇所に持たせたい場合、classの継承ではなく、protocolによる共通化をする

// Generics
