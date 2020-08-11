//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWeatherAPI: Decodable, Hashable {
    var dt: Int64
    var temp: Float
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [HWeather]
    
    func mapTo() -> AppHourlyDailyItem  {
        
        let dt = self.dt
        
        let night = Float()
        let day = self.temp
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
    
    //    func mapTo() -> AppHourly  {
    //
    //        let dt = self.dt
    //
    //        let night = 0
    //        let day = self.temp
    //        let temp = HTemperature(day: day, night: night)
    //
    //        let pressure = self.pressure
    //        let humidity = self.humidity
    //        let wind_speed = self.wind_speed
    //
    ////        var weather: Array<AppWeather> = [AppWeather]()
    ////
    ////        for each in self.weather {
    ////            let main = each.main
    ////            let icon = each.icon
    ////
    ////            let newWeather = AppWeather(main: main, icon: icon)
    ////            weather.append(newWeather)
    ////        }
    //        let weather = self.weather
    //
    //        let item: AppHourly = AppHourly(dt: dt,
    //                                        temp: temp,
    //                                        pressure: pressure,
    //                                        humidity: humidity,
    //                                        wind_speed: wind_speed,
    //                                        weather: weather)
    //        return item
    //    }
}

struct HTemperature: Decodable, Hashable {
    var day: Float
    var night: Int?
}

struct HWeather: Decodable, Hashable {
    var main: String
    var icon: String
}