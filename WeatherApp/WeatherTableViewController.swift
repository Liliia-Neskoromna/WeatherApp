import UIKit

class WeatherTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
        
    let kReUseId: String = "weatherTableViewCell"
    var listOfWeather = [WeatherDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfWeather.count) city found"
            }
        }
    }
    
    let second = ListViewController()
    
    @IBAction func goToSavedCities(_ sender: UIButton) {
        let page = ListViewController()
        present(page, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfWeather.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: kReUseId,
                                                            for: indexPath)
            as? WeatherTableViewCell else {fatalError("Bad Cell")}
        let weather = listOfWeather[indexPath.row]
        let city = weather.name
        cell.cityLabel?.text = city
        let temp: Float = weather.main.temp
        let roundTemp = temp.rounded()
        let temper = roundTemp.shortValue + " °C"
        cell.tempLabel?.text = temper
        let wind: String = "\(weather.wind.speed)" + "  m/s"
        cell.windLabel?.text = wind
        let rain = "\(weather.main.humidity)" + " %"
        cell.rainLabel?.text = rain
        let icon = weather.weather[0].icon
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        cell.imageWeatherIcon.imageFromServerURL(urlString: string)
        // MARK: - Date in format "MMM dd,yyyy" (V1)
        let date = Date()
        let formate = Date.getFormattedDate(date: date, format: "MMM dd, yyyy")
        cell.dateLabel?.text = formate
        // MARK: - Start experements
        // MARK: - End experements
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
// MARK: - Date (вивела дату у форматі як сказав котик)
extension Date {
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
}
// MARK: - Extension for Float
extension Float {
    var shortValue: String {
        return String(format: "%g", self)
    }
}
// MARK: - Extension for Icon
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)!
            as URL, completionHandler: { (data, _, error) -> Void in
                if error != nil {
                    print(error as Any)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                })
        }).resume()
    }
}
