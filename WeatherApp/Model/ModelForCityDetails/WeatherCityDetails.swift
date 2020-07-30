import Foundation

struct WeatherCityResponse: Codable {
    var list: [WeatherCityDetails]
}

struct WeatherCityDetails: Codable {
    var main: MainParamsCity
    var wind: WindCity
    var name: String
    var weather: [WeatherCity]
}

struct WindCity: Codable {
    var speed: Float
}

struct MainParamsCity: Codable {
    var temp: Float
    var humidity: Int
}

struct WeatherCity: Codable {
    var icon: String
//    var description: String
}
