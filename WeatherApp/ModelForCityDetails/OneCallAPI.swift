import Foundation
import UIKit

struct CityWeatherResponse: Decodable {
    var list: [OneCallAPI]
}

struct OneCallAPI: Decodable, Hashable {
    var lat: Float
    var lon: Float
    var hourly: [HourlyWeatherAPI]
    var daily: [DailyWeatherAPI]
}
