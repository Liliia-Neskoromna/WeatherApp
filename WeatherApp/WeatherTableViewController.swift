import UIKit

class WeatherTableViewController: UITableViewController {
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    var listOfWeather = [WeatherDetails]() {
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let request = WeatherRequest()
        request.getWeather{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.listOfWeather = weather
            }
        }
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
        
//      MARK: - Flexible date
        let date = Date()
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year,], from: date)
        let components2 = calendar.dateComponents([.month,], from: date)
        let components3 = calendar.dateComponents([.day,], from: date)
        let year = components1.year
        let month = components2.month
        let day = components3.day
        cell.dateLabel?.text = "\(day ?? 1)" + "." + "\(month ?? 1)" + "." + "\(year ?? 1)"
       
//      MARK: - Start experements
//      MARK: - End experements
        
//      MARK: - Constant data
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        cell.dateLabel?.text = dateFormatter.string(from: date)

        return cell
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
