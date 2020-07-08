//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Lilia on 7/6/20.
//  Copyright © 2020 Lilia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let sections = Bundle.main.decode([WeatherSection].self, from: "model.json")
    
       // Bundle.main.decode([WeatherSection].self, from: "model.geojson")
    var collectionView: UICollectionView!
    
    var dataSourse: UICollectionViewDiffableDataSource<WeatherSection, WeatherItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .orange
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .lightGray
        view.addSubview(collectionView)
        
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseId)
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.reuseId)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)

//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    
    func createDataSource() {
        dataSourse = UICollectionViewDiffableDataSource<WeatherSection, WeatherItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "hourly":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseId, for: indexPath) as? HourlyWeatherCell
                cell?.configure(with: chat)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.reuseId, for: indexPath) as? DailyWeatherCell
                cell?.configure(with: chat)
                return cell
            }
        })
        
        dataSourse?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil}
            
            guard let firstItem = self.dataSourse?.itemIdentifier(for: indexPath) else { return nil }
            
            guard let section = self.dataSourse?.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
            if section.title.isEmpty { return nil }
            
            sectionHeader.title.text = section.title
            return sectionHeader
        }
        
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<WeatherSection, WeatherItem>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSourse?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case "activeChats":
                return self.createActiveChatSection()
            default:
                return self.createWaitingChatSection()
            }
        }
        return layout
    }
    
    func createWaitingChatSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
                                                     heightDimension: .estimated(88))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 0, trailing: 12)
        
        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
    func createActiveChatSection() -> NSCollectionLayoutSection {
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
//extension ListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 76)
//    }
//}

//extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return sections.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sections[section].items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveChatCell.reuseId, for: indexPath) as! ActiveChatCell
//        let section = sections[indexPath.section]
//        let item = section.items[indexPath.item]
//
//        cell.configure(with: item)
//        return cell
//    }
//}

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



