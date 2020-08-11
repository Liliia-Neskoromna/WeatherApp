import Foundation
import UIKit

enum Type {
    case Hourly
    case Daily
}

struct AppWeatherModelSection: Hashable {
    var type: Type
    var modelItems: [AppHourlyDailyItem]
}

struct AppHourlyDailyItem: Hashable {
    var dt: Int64
    var temp: AppTemperature
    var pressure: Int32
    var humidity: Int
    var windSpeed: Float
    var weather: [AppWeather]
}

struct AppTemperature: Hashable {
    var day: Float
    var night: Float
}

struct AppWeather: Hashable {
    var main: String
    var icon: String
}
