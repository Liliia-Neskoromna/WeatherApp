//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct WeatherItem: Decodable, Hashable {
    
    let dt: String
    let temp: String
    let icon: String
    
}
