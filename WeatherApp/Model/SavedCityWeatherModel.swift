//import Foundation
//
//struct SavedCityWeatherResponse: Codable {
//    var list: [SavedCityWeatherDetails]
//}
//
//struct SavedCityWeatherDetails: Codable {
//    var lat: Float
//    var lon: Float
//    var hourly: [Hourly]
//    var daily: [Daily]
//}
//
//struct Hourly: Codable {
//    var dt: Int64
//    var temp: Float
//    var feels_like: Float
//    var pressure: Int32
//    var humidity: Int
//    var wind_speed: Float
//    var weather: [CityHourlyWeather]
//}
//
//struct CityHourlyWeather: Codable {
//    var main: String
//    var icon: String
//}
//
//
//struct Daily: Codable {
//    var dt: Int64
//    var temp: DailyTemperature
//    var pressure: Int32
//    var humidity: Int
//    var wind_speed: Float
//    var weather: [CityDailyWeather]
//}
//
//struct DailyTemperature: Codable {
//    var day: Float
//    var night: Float
//}
//
//struct CityDailyWeather: Codable {
//    var main: String
//    var icon: String
//    
//}
//
