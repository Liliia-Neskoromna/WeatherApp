import UIKit
import CoreData

class RequestController: UIViewController {
    
    static let shared = RequestController()
    //static let requestControll = RequestController()
    
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    var coreDataCityes : [City] = []
    //var city = City()
    var dict = NSMutableDictionary()
    //var tableViewController = WeatherTableViewController()
    
    var listOfCityWeather = [WeatherDetails]()
    //    {
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.tableViewController.tableView.reloadData()
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        // перенесла у везер
//        let request = UpdateWeatherRequest()
//        request.getWeather{[weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let weather):
//                self?.listOfCityWeather = weather
//                print(weather)
//            }
//        }
        
//        let citiesWeather = [City]()
//        city = citiesWeather[0]
//        
//        let list = mapToWeatherDetails(entity: citiesWeather)
//        //print(citiesWeather)
//        listOfCityWeather = list
        
    }
    
    //    func reloadCoreData() {
    
    //        var citiesWeather = [City]()
    //
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
    //        let sort = NSSortDescriptor(key: "cityId", ascending: true)
    //        fetchRequest.sortDescriptors = [sort]
    //
    //        fetchRequest.returnsObjectsAsFaults = false
    //        citiesWeather = try! persistence.context.fetch(fetchRequest) as! [City]
    //        coreDataCityes = citiesWeather
    //        let list = shoto(entity: citiesWeather)
    //        listOfWeather = list
    
    //        let citiesWeather = self.propertiesToFetch().cityId
    //
    //
    //        city.cityId = citiesWeather
    //        let request = self.getUpdateCityWeather()
    //
    //
    //
    //        let list = mapToWeatherDetails(entity: [citiesWeather])
    //        //print(citiesWeather)
    //        listOfCityWeather = list
    //    }
    //
    func propertiesToFetch() {
        var arrayCityID = Array<Int>()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.returnsObjectsAsFaults = false
        
        fetchRequest.propertiesToFetch = ["cityId"]
        fetchRequest.resultType = .dictionaryResultType
        
        do {
            let cities = try persistence.context.fetch(fetchRequest)
            for city in cities {
                var finalarrayCityID = arrayCityID.append(city) as? Int
                print("Object cityID return \(city)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo) ")
        }
        //return finalarrayCityID
    }
    
    //    func getUpdateCityWeather() {
    //
    //        let request = UpdateWeatherRequest()
    //        request.getWeather{[weak self] result in
    //            switch result {
    //            case .failure(let error):
    //                print(error)
    //            case .success(let weather):
    //                self?.listOfCityWeather = weather
    //                print(weather)
    //            }
    //        }
    //    }
    //
    func mapToWeatherDetails(entity: Array<City>) -> [WeatherDetails] {
        
        var list: [WeatherDetails] = []
        for looo in entity {
            
            let newLat = looo.latitude
            let newLon = looo.longtitute
            let newId = looo.cityId
            let newName = looo.name
            let newHumidity = looo.humidity
            let newTemp = looo.temperature
            let newSpeed = looo.speed
            
            let weather = Weather(icon: " ", description: " ")
            let main = Main(temp: newTemp, humidity: newHumidity)
            let wind = Wind(speed: newSpeed)
            let coord = Coordinates(lon: newLon, lat: newLat)
            
            let element = WeatherDetails.init(main: main, wind: wind, id: newId, name: newName, weather: [weather], coord: coord)
            list.append(element)
        }
        return list
    }
    
}
