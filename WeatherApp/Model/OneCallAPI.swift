//
//  SectionIdType.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct CityWeatherResponse: Decodable {
    var list: [OneCallAPI]
}

struct OneCallAPI: Decodable, Hashable {
    var hourly: [HourlyWeatherAPI]
    var daily: [DailyWeatherAPI]
}

