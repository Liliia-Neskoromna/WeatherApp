import Foundation

struct WeatherResponse: Codable {
    var list: [WeatherDetails]
}

struct WeatherDetails: Codable {
    var main: MainParams
    var wind: Wind
    var name: String
    var weather: [Weather]
}

struct Wind: Codable {
    var speed: Float
}

struct MainParams: Codable {
    var temp: Float
    var humidity: Int
}

struct Weather: Codable {
    var icon: String
//    var description: String
}
