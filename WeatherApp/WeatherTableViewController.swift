import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addCity: UIButton!
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    var item : [City] = []
    var dict = NSMutableDictionary()
    
    
    var listOfWeather = [WeatherDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        print(entity)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        var citiesWeather = [City]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.returnsObjectsAsFaults = false
        citiesWeather = try! persistence.context.fetch(fetchRequest) as! [City]
        
        let list = shoto(entity: citiesWeather)
        print(citiesWeather)
        listOfWeather = list
        
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
        print(list)
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
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
        //        indexPath) as! CustomCell // CustomCell is your Cell File name
        //        let dic = item[indexPath.row] as! NSManagedObject
        //        cell.lbl_email?.text = dic.value(forKey: "email" ) as? String
        //        cell.lbl_password?.text = dic.value(forKey: "password" ) as? String
        //        return cell
        
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
}

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
