//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    static var reuseId: String = "HourlyWeatherCell"
    
    let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        
        icon.frame = self.bounds
        addSubview(icon)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }
    func configure(with city: WeatherItem) {
        icon.image = UIImage(named: city.icon)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
