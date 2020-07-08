//
//  SectionHeader.swift
//  WeatherApp
//
//  Created by Lilia on 7/8/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customiseElements()
        setupConstraints()
    }
    
    private func customiseElements() {
        title.textColor = .black
        title.font = UIFont(name: "avenir", size: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupConstraints() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

