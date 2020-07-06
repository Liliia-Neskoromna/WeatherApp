//
//  SectionIdType.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct SectionIdType: Decodable, Hashable {
    var lat: Float
    var lon: Float
    var hourly: [HourlyWeather]
    var daily: [DailyWeather]
}

