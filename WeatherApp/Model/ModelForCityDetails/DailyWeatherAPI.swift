import Foundation
import UIKit

struct DailyWeatherAPI: Decodable, Hashable {
    var dt: Int64
    var temp: DTemperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [DWeather]
    
    func mapTo() -> AppHourlyDailyItem  {
        
        let dt = self.dt
        
        let day = self.temp.day
        let night = self.temp.night
        let temp = AppTemperature(day: day, night: night)
        
        let pressure = self.pressure
        let humidity = self.humidity
        let wind_speed = self.wind_speed
        
        var weather: Array<AppWeather> = [AppWeather]()
        
        for each in self.weather {
            let main = each.main
            let icon = each.icon
            
            let newWeather = AppWeather(main: main, icon: icon)
            weather.append(newWeather)
            //print(weather)
        }
        
        let item: AppHourlyDailyItem = AppHourlyDailyItem(dt: dt,
                                                          temp: temp,
                                                          pressure: pressure,
                                                          humidity: humidity,
                                                          windSpeed: wind_speed,
                                                          weather: weather)
        return item
    }
    
    //    func mapTo(initialStruct: Array<DailyWeatherAPI>) -> [AppDaily]  {
    //
    //        var endStruct: Array<AppDaily> = [AppDaily]()
    //
    //        for initial in initialStruct {
    //            let dt = initial.dt
    //            let temp = DTemperature(day: initial.temp.day, night: initial.temp.night)
    //            let pressure = initial.pressure
    //            let humidity = initial.humidity
    //            let wind_speed = initial.wind_speed
    //            let weather = initial.weather
    //
    //            let item: AppDaily = AppDaily(dt: dt,
    //                                            temp: temp,
    //                                            pressure: pressure,
    //                                            humidity: humidity,
    //                                            wind_speed: wind_speed,
    //                                            weather: weather)
    //            endStruct.append(item)
    //        }
    //
    //        return endStruct
    //    }
}

struct DTemperature: Decodable, Hashable {
    var day: Float
    var night: Float
}

struct DWeather: Decodable, Hashable {
    var main: String
    var icon: String
}
