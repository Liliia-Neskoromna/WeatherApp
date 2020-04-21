import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    let persistence = PersistanceService.shared
    
    var listOfWeather = [WeatherDetails]() {
        didSet {
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        printCities()
        let request = WeatherRequest()
        request.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = weather
                self?.saveCity(weatherDetails: weather[0])
            }
        }
    }
    
    func saveCity(weatherDetails: WeatherDetails) {
        let city = City(context: self.persistence.context)
        city.name = weatherDetails.name
        city.cityId = weatherDetails.id
        city.latitude = weatherDetails.coord.lat
        city.longtitute = weatherDetails.coord.lon
        
        DispatchQueue.main.async {
            self.persistence.context.insert(city)
            self.persistence.save()
        }
    }
    
    func printCities()  {
        do{
            let cities = try readCity()
            print(cities)
        }catch{
            print("ПУСТО")
        }
    }
    
    func readCity()throws ->  [City] {
        return try self.persistence.context.fetch(City.fetchRequest() as NSFetchRequest<City>)
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
        //      MARK: - City
        
        let city = weather.name
        cell.cityLabel?.text = city
        
        //      MARK: - Temp
        
        let temp: Float = weather.main.temp
        let roundTemp = temp.rounded()
        let t = roundTemp.shortValue + " °C"
        cell.tempLabel?.text = t
        
        //      MARK: - Wind
        
        let wind: String = "\(weather.wind.speed)" + "  m/s"
        cell.windLabel?.text = wind
        
        //      MARK: - Humidity
        
        let rain = "\(weather.main.humidity)" + " %"
        cell.rainLabel?.text = rain
        
        //      MARK: - Icon
        
        let icon = weather.weather[0].icon
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        cell.imageWeatherIcon.imageFromServerURL(urlString: string)
        
        
        //      MARK: - Date in format "MMM dd,yyyy"
        
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
        print(searchBarText)
        let weatherRequest = WeatherRequest(cityName: searchBar.text)
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

//      MARK: - Optional (Basically, add an Optional extension that gives a String describing the thing in the optional, or simply “nil” if not set. In addition, if the thing in the optional is a String, put it in quotes)

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

//      MARK: - Extension for Float

extension Float {
    var shortValue: String {
        return String(format: "%g", self)
    }
}

//      MARK: - Extension for Icon

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
