import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    
    @IBOutlet weak var addCity: UIButton!
    
    let requestController = RequestController.shared
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    var coreDataCityes : [City] = []
    var city = City()
    var dict = NSMutableDictionary()
        
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
        reloadCoreData()
        //requestController.viewDidLoad()
       
        let request = UpdateWeatherRequest()
        request.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = weather
                print("Data from UpdateWeatherRequest \(weather)")
            }
        }
        
        let citiesWeather = [City]()
//        city = citiesWeather[0]
        
        let list = shoto(entity: citiesWeather)
        //print(citiesWeather)
        listOfWeather = list
        
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
        for element in entity {
            
            let newLat = element.latitude
            let newLon = element.longtitute
            let newId = element.cityId
            let newName = element.name
            let newHumidity = element.humidity
            let newTemp = element.temperature
            let newSpeed = element.speed
            let newIcon = element.icon
            
            let weather = Weather(icon: newIcon, description: " ")
            let main = Main(temp: newTemp, humidity: newHumidity)
            let wind = Wind(speed: newSpeed)
            let coord = Coordinates(lon: newLon, lat: newLat)
            
            let element = WeatherDetails.init(main: main, wind: wind, id: Int64(newId), name: newName, weather: [weather], coord: coord)
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
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: kReUseIdentitfire, for: indexPath) as? WeatherTableViewCell
            else {fatalError("Bad Cell")}
        
        let weather = listOfWeather[indexPath.row]
        // City
        let city = weather.name
        cell.cityLabel?.text = city
        // Temp
        let temp: Float = weather.main.temp
        let roundTemp = temp.rounded()
        let t = roundTemp.shortValue
        cell.tempLabel?.text = t
        // Wind
        let wind: String = "\(weather.wind.speed)" + "m/s"
        cell.windLabel?.text = wind
        // Humidity
        let rain = "\(weather.main.humidity)" + "%"
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
