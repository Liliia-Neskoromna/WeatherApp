//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    //let sections = [SavedCityWeatherDetails]()
    var collectionView: UICollectionView!
    
    var dataSourse: UICollectionViewDiffableDataSource<SectionIdType, HourlyWeather>?
    
    
    
}
