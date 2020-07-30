import UIKit
import CoreData

class SearchCityController: UITableViewController {
    
    @IBOutlet weak var seachCityBar: UISearchBar!
    
    let useIdentitfire: String = "searchCityTableViewCell"
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    var coreDataCityes : [City] = []
    var city = City()
    
    var listOfWeather = [WeatherDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seachCityBar.delegate = self
        
        let request = CityRequest(cityName: seachCityBar.text!)
        request.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = [weather]
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
        let icon = listOfWeather[0].weather[0].icon
        entity.setValue(icon, forKey: "icon")
        
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: useIdentitfire, for: indexPath) as? SearchCityTableViewCell else {fatalError("Bad Cell")}
        
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
        cell.humidityLabel?.text = rain
        // Icon
        let icon = weather.weather[0].icon
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        cell.iconImage.imageFromServerURL(urlString: string)
        // Date in format "MMM dd,yyyy"
        let date = Date()
        let formate = Date.getFormattedDate(date: date, format: "MMM dd, yyyy")
        cell.dateLabel?.text = formate
        return cell
    }
}
