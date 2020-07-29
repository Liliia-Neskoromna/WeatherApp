AppWeatherModelSection

import Foundation
import UIKit

struct AppWeatherModelSection: Decodable, Hashable {
    var lat: Float
    var lon: Float
    var hourly: [AppHourlyDailyItem]
    var daily: [AppHourlyDailyItem]
}

struct AppHourlyDailyItem: Decodable, Hashable {
    var dt: Int64
    var temp: AppTemperature
    var pressure: Int32
    var humidity: Int
    var windSpeed: Float
    var weather: [AppWeather]
}

struct AppTemperature: Decodable, Hashable {
    var day: Float
    var night: Float
}

struct AppWeather: Decodable, Hashable {
    var main: String
    var icon: String
}















struct AppHourly: Decodable, Hashable {
    var dt: Int64
    var temp: HTemperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [HWeather]
}

//struct AppHourlyTemperature: Decodable, Hashable {
//    var day: Float
//    var night: Float
//}
//struct AppHourlyWeather: Decodable, Hashable {
//    var main: String
//    var icon: String
//}

//____________________________________

struct AppDaily: Decodable, Hashable {
    var dt: Int64
    var temp: DTemperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [DWeather]
}

//struct AppDailyTemperature: Decodable, Hashable {
//    var day: Float
//    var night: Float
//}
//
//struct AppDailyWeather: Decodable, Hashable {
//    var main: String
//    var icon: String
//}

