//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeatherAPI: Decodable, Hashable {
    var dt: Int64
    var temp: DTemperature
    var pressure: Int32
    var humidity: Int
    var wind_speed: Float
    var weather: [DWeather]

    
    func mapTo(initialStruct: Array<DailyWeatherAPI>) -> [AppDaily]  {
        
        var endStruct: Array<AppDaily> = [AppDaily]()
                
        for initial in initialStruct {
            let dt = initial.dt
            let temp = DTemperature(day: initial.temp.day, night: initial.temp.night)
            let pressure = initial.pressure
            let humidity = initial.humidity
            let wind_speed = initial.wind_speed
            let weather = initial.weather
            
            let item: AppDaily = AppDaily(dt: dt,
                                            temp: temp,
                                            pressure: pressure,
                                            humidity: humidity,
                                            wind_speed: wind_speed,
                                            weather: weather)
            endStruct.append(item)
        }
        
        return endStruct
    }
}

struct DTemperature: Decodable, Hashable {
    var day: Float
    var night: Float
}

struct DWeather: Decodable, Hashable {
    var main: String
    var icon: String
}
