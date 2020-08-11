//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var sections = [AppWeatherModelSection]() {
        didSet {
            DispatchQueue.main.async {
                self.setupCollectionView()
                self.createDataSource()
                self.reloadData()
            }
        }
    }
    
    var collectionView: UICollectionView!
    
    var dataSourse: UICollectionViewDiffableDataSource<AppWeatherModelSection, AppHourlyDailyItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedCityWeather()
        
        view.backgroundColor = .orange
 
    }
    
    func getSavedCityWeather() {
        
        let weatherRequest = SavedCityRequest()
        weatherRequest.getWeather { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                var arrayHourly = Array<AppHourlyDailyItem>()
                for element in weather.hourly {
                    let newElement = element.mapTo()
                    arrayHourly.append(newElement)
                    //print(arrayHourly)
                }
                let appHourlyModelSection = AppWeatherModelSection(type: Type.Hourly, modelItems: arrayHourly)
                
                var arrayDaily = Array<AppHourlyDailyItem>()
                for element in weather.daily {
                    let newElement = element.mapTo()
                    arrayDaily.append(newElement)
                    //prinprint(arrayDaily)
                }
                let appDailyModelSection = AppWeatherModelSection(type: Type.Daily, modelItems: arrayDaily)
                
                let sections = [appHourlyModelSection, appDailyModelSection]
                
                self!.sections = sections
            }
        }
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .gray
        view.addSubview(collectionView)
        
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseId)
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.reuseId)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
    }
    
    func createDataSource() {
        dataSourse = UICollectionViewDiffableDataSource<AppWeatherModelSection, AppHourlyDailyItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, city) -> UICollectionViewCell? in
            let type = self.sections[indexPath.section].type
            
            switch type {
            case Type.Daily:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.reuseId, for: indexPath) as? DailyWeatherCell
                cell?.configure(with: city)
                return cell
            case Type.Hourly:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseId, for: indexPath) as? HourlyWeatherCell
                cell?.configure(with: city)
                return cell
            }
        })
        
        dataSourse?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil}
            
            guard let firstItem = self.dataSourse?.itemIdentifier(for: indexPath) else { return nil }
            
            guard (self.dataSourse?.snapshot().sectionIdentifier(containingItem: firstItem)) != nil else { return nil }
            //            if section.title.isEmpty { return nil }
            //
            //            sectionHeader.title.text = section.title
            return sectionHeader
        }
        
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<AppWeatherModelSection, AppHourlyDailyItem>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.modelItems, toSection: section)
        }
        
        dataSourse?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            
            switch section {
            case section:
                return self.createDailySection()
            default:
                return self.createHourlySection()
            }
        }
        return layout
    }
    
    func createHourlySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                                     heightDimension: .estimated(112))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 12)
        
        let header = createSectionHeader()
        header.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 0, bottom: 0, trailing: 12)
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
    func createDailySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(86))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 0, trailing: 20)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
}
// MARK: - SwiftUI
import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let listVC = ListViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> ListViewController {
            return listVC
        }
        
        func updateUIViewController(_ uiViewController: ListProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
            
        }
    }
}



