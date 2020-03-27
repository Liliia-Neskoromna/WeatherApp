import Foundation

struct WeatherResponse: Decodable {
    var list: [WeatherDetails]
}

struct WeatherDetails: Decodable {
    var main: Main
    var wind: Wind
    var name: String
    var weather: [Weather]
    var sys: Sys
}

struct Wind: Decodable {
    var speed: Float
}

struct Main: Decodable {
    var temp: Float
    var humidity: Int
}

struct Weather: Decodable {
    var icon: String
    var description: String
}

struct Sys: Decodable {
    var timezone: Float
}
