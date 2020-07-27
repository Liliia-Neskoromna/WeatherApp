//
//  Extensions-Utilities.swift
//  WeatherApp
//
//  Created by Lilia on 7/27/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import UIKit

// MARK: - Extension for searchBar
extension SearchCityController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchCityBar: UISearchBar) {
        guard let searchBarText = searchCityBar.text else {return}
        let weatherRequest = CityRequest(cityName: searchBarText)
        weatherRequest.getWeather { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = [weather]
            }
        }
    }
}

extension Date {
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
}

extension Optional {
    var orNil : String {
        if self == nil {
            return "nil"
        }
        if "\(Wrapped.self)" == "String" {
            return "\"\(self!)\""
        }
        return "\(self!)"
    }
}

//    Extension for Float
extension Float {
    var shortValue: String {
        return String(format: "%g", self)
    }
}

//    Extension for Icon
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

extension Array {
    func filterDuplicates (includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element] {
        var results = [Element]()
        
        forEach { element in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
}
