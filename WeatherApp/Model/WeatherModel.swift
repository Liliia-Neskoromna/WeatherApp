import Foundation


struct List: Decodable {
    var main: Main
    var wind: Wind
    var name: String
//    var date: Float
}

struct Wind: Decodable {
    var speed: Int
}

struct Main: Decodable {
    var temp: Float
    var humidity: Int
}
