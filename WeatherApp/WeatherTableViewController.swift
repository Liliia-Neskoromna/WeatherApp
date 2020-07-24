import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addCity: UIButton!
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    var coreDataCityes : [City] = []
    var city = City()
    //let uniqueElementsArray = self.item.filterDuplicates { $0.recordID != $1.recordID }
    var dict = NSMutableDictionary()
    
    
    var listOfWeather = [WeatherDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func updateCity(_ sender: UIButton) {
    

    }
    
    
    
    @IBAction func addCity(_ sender: UIButton) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
        let name = listOfWeather[0].name
        entity.setValue(name, forKey: "name")
        let lon = listOfWeather[0].coord.lon
        entity.setValue(lon, forKey: "longtitute")
        let lat = listOfWeather[0].coord.lat
        entity.setValue(lat, forKey: "latitude")
        let temp = listOfWeather[0].main.temp
        entity.setValue(temp, forKey: "temperature")
        let humidity = listOfWeather[0].main.humidity
        entity.setValue(humidity, forKey: "humidity")
        let id = listOfWeather[0].id
        entity.setValue(id, forKey: "cityId")
        let speed = listOfWeather[0].wind.speed
        entity.setValue(speed, forKey: "speed")
        
        do {
            try persistence.context.save()
        } catch {
            print("error")
        }
        //print(entity)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        reloadCoreData()
        //city.update(with: [WeatherDetails : Any])
        
        //        var citiesWeather = [City]()
        
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        //        fetchRequest.returnsObjectsAsFaults = false
        //        citiesWeather = try! persistence.context.fetch(fetchRequest) as! [City]
        //        let list = shoto(entity: citiesWeather)
        //        //print(citiesWeather)
        //        listOfWeather = list
        
        
        let request = CityRequest(cityName: searchBar.text!)
        request.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = [weather]
            }
        }
    }
    
    func reloadCoreData() {
        
        var citiesWeather = [City]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let sort = NSSortDescriptor(key: "cityId", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        fetchRequest.returnsObjectsAsFaults = false
        citiesWeather = try! persistence.context.fetch(fetchRequest) as! [City]
        coreDataCityes = citiesWeather
        print(coreDataCityes)
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
        //
        //        //} else {return print("Not delete")}
        //    }
        
        //    override func tableView(_ tableView: UITableView, commit editingStyle: WeatherTableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
        //    {
        //
        //        if editingStyle == .delete {
        //            let city = item[indexPath.row]
        //            context.delete(city)
        //
        //            reloadData()
        //                }
        //            }
        //            do {
        //                try context.save()
        //            } catch let error as NSError {
        //                print("Could not save. \(error), \(error.userInfo)")
        //            }
        //            tableView.beginUpdates()
        //            item.remove(at: indexPath.row)
        //            tableView.deleteRows(at: [indexPath], with: .fade)
        //            tableView.endUpdates()
        //            tableView.reloadData()
        //            persistence.save()
        
        
        
        //    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
        //    {
    }
}
//let editAction = UITableViewRowAction(style: .default, title: "Edit",
//handler: { (action, indexPath) in
//let updatevc = self.storyboard?.instantiateViewController(withIdentifier:
//"UpdatenaVC") as! UpdateVC
//let temp = self.item[indexPath.row] as! NSManagedObject
//getrecord = temp
//self.navigationController?.pushViewController(updatevc, animated: true)
//})
//
//let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
//let temp = self.item[indexPath.row] as! NSManagedObject
//let userNAME = temp.value(forKey: "email")
//let context = self.appdelegate.persistentContainer.viewContext
//let entitydec = NSEntityDescription.entity(forEntityName: "Login", in:
//context)
//let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
//request.entity = entitydec
//let pred = NSPredicate(format: "email = %@", userNAME as! CVarArg)
//request.predicate = pred
//do
//{
//let result = try context.fetch(request)
//if result.count > 0
//{
//let manage = result[0] as! NSManagedObject
//context.delete(manage)
//try context.save()
//print("Record Deleted")
//}
//else
//{
//print("Record Not Found")
//}
//}
//catch {}
//self.item.remove(at: indexPath.row)
//self.tbl_reload.deleteRows(at: [indexPath], with: .middle)
//self.tbl_reload.reloadData()
//
//})
//
//return [deleteAction, editAction]
//}



// MARK: - Extension for searchBar
extension WeatherTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let weatherRequest = CityRequest(cityName: searchBarText)
        weatherRequest.getWeather { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = [weather]
            }
        }
    }
}
extension Date {
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
}

extension Optional {
    var orNil : String {
        if self == nil {
            return "nil"
        }
        if "\(Wrapped.self)" == "String" {
            return "\"\(self!)\""
        }
        return "\(self!)"
    }
}

//    Extension for Float
extension Float {
    var shortValue: String {
        return String(format: "%g", self)
    }
}

//    Extension for Icon
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

extension Array {
    func filterDuplicates (includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element] {
        var results = [Element]()
        
        forEach { element in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
}
