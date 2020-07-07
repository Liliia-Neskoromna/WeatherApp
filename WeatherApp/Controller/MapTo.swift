////
////  MapTo.swift
////  WeatherApp
////
////  Created by Lilia on 7/7/20.
////  Copyright © 2020 Lilia. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class MapTo {
//
//    let firstStruct = [HourlyWeather]()
//    var eather: WeatherForIte
//
//    func mapTo(_: HourlyWeather) -> WeatherForItem  {
//        for initial in firstStruct {
//            let dt = initial.dt
//            let nigth = 0
//            let temp = HTemperature(day: initial.temp, night: nigth)
//            let pressure = initial.pressure
//            let humidity = initial.humidity
//            let wind_speed = initial.wind_speed
//            let weather = initial.weather
//
//            let item: WeatherForItem = WeatherForItem(dt: dt,
//                                                                  temp: temp,
//                                                                  pressure: pressure,
//                                                                  humidity: humidity,
//                                                                  wind_speed: wind_speed,
//                                                                  weather: weather)
//            arrayWeather.append(item)
//
//        }
//        return arrayWeather
//    }
//
//}
