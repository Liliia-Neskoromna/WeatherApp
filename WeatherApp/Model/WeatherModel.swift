import Foundation

struct WeatherResponse: Codable, Hashable {
    var list: WeatherDetails
}
struct WeatherDetails: Codable, Hashable {
    var main: Main
    var wind: Wind
    var id: Int64
    var name: String?
    var weather: [Weather]
    var coord: Coordinates
}
struct Coordinates: Codable, Hashable {
    var lon: Float
    var lat: Float
}
struct Wind: Codable, Hashable {
    var speed: Float
}

struct Main: Codable, Hashable {
    var temp: Float
    var humidity: Int
}

struct Weather: Codable, Hashable {
    var icon: String
    var description: String
}

