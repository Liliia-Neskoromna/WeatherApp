//
//  WeatherSection.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

struct WeatherSection: Decodable, Hashable {
    
    var lat: Float
    var lon: Float
    var type: String
    var items: [WeatherItem]
    
}
