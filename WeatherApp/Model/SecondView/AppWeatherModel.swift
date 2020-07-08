import Foundation
import UIKit

struct AppWeatherModel: Decodable, Hashable {
    var lat: Float
    var lon: Float
    var hourly: [AppHourly]
    var daily: [AppDaily]
}

//____________________________________

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

