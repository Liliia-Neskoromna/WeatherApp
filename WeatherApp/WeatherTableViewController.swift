import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    
    @IBOutlet weak var addCity: UIButton!
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    var coreDataCityes : [City] = []
    var city = City()
    var dict = NSMutableDictionary()
    
    //let requestController = RequestController()
    
    var listOfWeather = [WeatherDetails]()
        {
            didSet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar.delegate = self
        reloadCoreData()
        
        
        //city.update(with: [WeatherDetails : Any])
        //        var citiesWeather = [City]()
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        //        fetchRequest.returnsObjectsAsFaults = false
        //        citiesWeather = try! persistence.context.fetch(fetchRequest) as! [City]
        //        let list = shoto(entity: citiesWeather)
        //        //print(citiesWeather)
        //        listOfWeather = list
        
//        let request = CityRequest(cityName: searchBar.text!)
//        request.getWeather{[weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let weather):
//                self?.listOfWeather = [weather]
//            }
//        }
//
        //requestController.reloadCoreData()
    
        
    }
    
    func reloadCoreData() {
        
        var citiesWeather = [City]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let sort = NSSortDescriptor(key: "cityId", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        fetchRequest.returnsObjectsAsFaults = false
        citiesWeather = try! context.fetch(fetchRequest) as! [City]
        coreDataCityes = citiesWeather
        //print(coreDataCityes)
        let list = shoto(entity: citiesWeather)
        //print(citiesWeather)
        listOfWeather = list
    }
    
    func shoto(entity: Array<City>) -> [WeatherDetails] {
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: kReUseIdentitfire, for: indexPath) as? WeatherTableViewCell else {fatalError("Bad Cell")}
        
        let weather = listOfWeather[indexPath.row]
        // City
        let city = weather.name
        cell.cityLabel?.text = city
        // Temp
        let temp: Float = weather.main.temp
        let roundTemp = temp.rounded()
        let t = roundTemp.shortValue + " °C"
        cell.tempLabel?.text = t
        // Wind
        let wind: String = "\(weather.wind.speed)" + "  m/s"
        cell.windLabel?.text = wind
        // Humidity
        let rain = "\(weather.main.humidity)" + " %"
        cell.rainLabel?.text = rain
        // Icon
        let icon = weather.weather[0].icon
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        cell.imageWeatherIcon.imageFromServerURL(urlString: string)
        // Date in format "MMM dd,yyyy"
        let date = Date()
        let formate = Date.getFormattedDate(date: date, format: "MMM dd, yyyy")
        cell.dateLabel?.text = formate
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //if item.count < indexPath.row {
        var citiesWeather = [City]()
        print(citiesWeather)
        
        let note = coreDataCityes[indexPath.row]
        
        if editingStyle == .delete {
            context.delete(note)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
        }
        //item = item.filterDuplicates { $0.recordID != $1.recordID }
        
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:  "City")
        fetchRequest.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "cityId", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            citiesWeather = try context.fetch(fetchRequest) as! [City]
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        let list = shoto(entity: citiesWeather)
        //print(citiesWeather)
        listOfWeather = list
    }
}

//// MARK: - Extension for searchBar
//extension WeatherTableViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchBarText = searchBar.text else {return}
//        let weatherRequest = CityRequest(cityName: searchBarText)
//        weatherRequest.getWeather { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let weather):
//                self?.listOfWeather = [weather]
//            }
//        }
//    }
//}
//extension Date {
//    static func getFormattedDate(date: Date, format: String) -> String {
//        let dateformat = DateFormatter()
//        dateformat.dateFormat = format
//        return dateformat.string(from: date)
//    }
//}
//
//extension Optional {
//    var orNil : String {
//        if self == nil {
//            return "nil"
//        }
//        if "\(Wrapped.self)" == "String" {
//            return "\"\(self!)\""
//        }
//        return "\(self!)"
//    }
//}
//
////    Extension for Float
//extension Float {
//    var shortValue: String {
//        return String(format: "%g", self)
//    }
//}
//
////    Extension for Icon
//extension UIImageView {
//    public func imageFromServerURL(urlString: String) {
//        self.image = nil
//        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
//        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
//
//            if error != nil {
//                print(error as Any)
//                return
//            }
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data!)
//                self.image = image
//            })
//
//        }).resume()
//    }}
//
//extension Array {
//    func filterDuplicates (includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element] {
//        var results = [Element]()
//
//        forEach { element in
//            let existingElements = results.filter {
//                return includeElement(element, $0)
//            }
//            if existingElements.count == 0 {
//                results.append(element)
//            }
//        }
//
//        return results
//    }
//}
