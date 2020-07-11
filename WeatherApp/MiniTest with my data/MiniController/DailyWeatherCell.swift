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
        temp.textColor = .blue
        temp.font = UIFont(name: "avenir", size: 26)
        dt.text = city.dt
        dt.textColor = .darkGray
        dt.font = UIFont(name: "avenir", size: 23)
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
        
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 78).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        //dt.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        dt.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dt.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 30).isActive = true
        //dt.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: 16).isActive = true

        //temp.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        temp.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 210).isActive = true
//        temp.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -16).isActive = true
    }
}
