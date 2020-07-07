import Foundation
import UIKit

struct AppWeatherModel: Codable {
    var lat: Float
    var lon: Float
    var hourly: [AppHourly]
    var daily: [AppDaily]
}

//____________________________________

struct AppHourly: Codable {
    var dt: Int64
    var temp: AppHourlyTemperature
    var feels_like: Float
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [AppHourlyWeather]
}

struct AppHourlyTemperature: Codable {
    var day: Float
    var night: Float
}
struct AppHourlyWeather: Codable {
    var main: String
    var icon: String
}

//____________________________________

struct AppDaily: Codable {
    var dt: Int64
    var temp: AppDailyTemperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [AppDailyWeather]
}

struct AppDailyTemperature: Codable {
    var day: Float
    var night: Float
}

struct AppDailyWeather: Codable {
    var main: String
    var icon: String
}

