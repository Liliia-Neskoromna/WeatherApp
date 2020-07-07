////
////  ListViewController.swift
////  WeatherApp
////
////  Created by Lilia on 7/6/20.
////  Copyright © 2020 Lilia. All rights reserved.
////
//
//import UIKit
//
//class ListViewController: UIViewController {
//    
//    let sections = [SectionIdType]()
//    var collectionView: UICollectionView!
//    
//    var dataSourse: UICollectionViewDiffableDataSource<SectionIdType, DailyWeather>?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .orange
//    }
//    
//    func setupCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor = .lightGray
//        view.addSubview(collectionView)
//        
//        //collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
//        //collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.reuseId)
//        
//        //collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
//    }
//    
//    func createCompositionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            let section = self.sections[sectionIndex]
//            
//            switch section.hourly {
//            case "":
//                return self.createActiveChatSection()
//            default:
//                return self.createWaitingChatSection()
//            }
//        }
//        return layout
//    }
//    
//}
