//import UIKit
//import CoreData
//
//class RequestController {
//    
//    let persistence = PersistanceService.shared
//    let context = PersistanceService.shared.context
//    var coreDataCityes : [City] = []
//    var city = City()
//    var dict = NSMutableDictionary()
//    
//    func viewDidLoad() {
//        
//
//     let request = CityRequest(cityName: searchBar.text!)
//        request.getWeather{[weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let weather):
//                self?.listOfWeather = [weather]
//                DispatchQueue.main.async {
//                    self?.reloadTableViewData()
//                }
//            }
//        }
//    }
//    
//    func reloadCoreData() {
//            
//        //let list = shoto(entity: citiesWeather)
//        //print(citiesWeather)
//        //listOfWeather = list
//    
//    
//    func propertiesToFetch() {
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
//        fetchRequest.returnsObjectsAsFaults = false
//        
//        fetchRequest.propertiesToFetch = ["cityId"]
//        fetchRequest.resultType = .dictionaryResultType
//        
//        do {
//            let cities = try persistence.context.fetch(fetchRequest)
//            for city in cities {
//                print("Object return \(city)")
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo) ")
//        }
//    }
//}
