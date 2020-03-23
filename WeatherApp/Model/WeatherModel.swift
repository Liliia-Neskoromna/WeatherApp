import Foundation

struct WeatherResponse: Decodable {
    var list: [WeatherDetails]
}

//struct Weather: Decodable {
//    var weather: [WeatherDetails]
//}

struct WeatherDetails: Decodable {
    var main: Main
    var wind: Wind
    var name: String
}
struct Wind: Decodable {
    var speed: Float
}

struct Main: Decodable {
    var temp: Float
    var humidity: Int
}
