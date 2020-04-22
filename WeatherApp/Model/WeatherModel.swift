import Foundation

struct WeatherResponse: Codable {
    var list: WeatherDetails
}
struct WeatherDetails: Codable {
    var main: Main
    var wind: Wind
    var id: Int64
    var name: String?
    var weather: [Weather]
    var coord: Coordinates
}
struct Coordinates: Codable {
    var lon: Float
    var lat: Float
}
struct Wind: Codable {
    var speed: Float
}

struct Main: Codable {
    var temp: Float
    var humidity: Int
}

struct Weather: Codable {
    var icon: String
    var description: String
}

