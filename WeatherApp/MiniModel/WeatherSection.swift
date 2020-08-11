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
    
    let type: String 
    let title: String
    let items: [WeatherItem]
    
}
