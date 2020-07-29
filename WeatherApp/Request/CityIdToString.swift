//
//  CityIdToString.swift
//  WeatherApp
//
//  Created by Lilia on 7/29/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation


struct CitiesId {
    static let requestControll = RequestController.shared
    var cityIdsArray: Array = requestControll.propertiesToFetch()
    func getCityId(array: [Int]) -> String {
        let stringArray = array.map { String($0) }
        let string = "\(stringArray.joined(separator: ","))"
        return string
    }
}
