//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import Foundation
import UIKit

class DailyWeatherCell: UICollectionViewCell {
    
    static var reuseId: String = "DailyWeatherCell"
    
    let icon = UIImageView()
    let dt = UILabel()
    let temp = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }
    
    func setupElements() {
        temp.translatesAutoresizingMaskIntoConstraints = false
        dt.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with city: WeatherItem) {
        temp.text = city.temp
        dt.text = city.dt
        icon.image = UIImage(named: city.icon)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension DailyWeatherCell {
    func setupConstraints() {
        addSubview(temp)
        addSubview(dt)
        addSubview(icon)
        
        // oponentImageView constraints
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 78).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        // oponentLabel constraints
        dt.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        dt.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 30).isActive = true
        //dt.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: 16).isActive = true

        // lastMessageLabel constraints
        temp.topAnchor.constraint(equalTo: dt.bottomAnchor, constant: 10).isActive = true
        temp.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 30).isActive = true
//        temp.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -16).isActive = true
    }
}
