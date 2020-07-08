//
//  SectionIdType.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

//struct OneCallAPIResponse: Codable {
//    var list: [AppWeatherModel]
//}

struct OneCallAPI: Decodable, Hashable {
    var lat: Float
    var lon: Float
    var hourly: [HourlyWeatherAPI]
    var daily: [DailyWeatherAPI]
    
    
}

