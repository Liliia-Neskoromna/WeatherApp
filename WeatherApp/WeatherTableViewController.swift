import UIKit

class WeatherTableViewController: UITableViewController {
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    let defaults = UserDefaults.standard
    
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
    //      MARK: - Start experements
    func textLabelShouldReturn(_ textLabel: UILabel) -> Bool {
        self.view.endEditing(true)
        return false
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
        
        //      MARK: - Start experements
        //      MARK: - End experements
        
        //      MARK: - Flexible date
        //        let date = Date()
        //        let calendar = Calendar.current
        //        let components1 = calendar.dateComponents([.year,], from: date)
        //        let components2 = calendar.dateComponents([.month,], from: date)
        //        let components3 = calendar.dateComponents([.day,], from: date)
        //        let year = components1.year
        //        let month = components2.month
        //        let day = components3.day
        //        cell.dateLabel?.text = "\(day.orNil)" + "." + "\(month.orNil)" + "." + "\(year.orNil)"
        
        //      MARK: - Constant data
        //        let date = Date()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = DateFormatter.Style.short
        //        cell.dateLabel?.text = dateFormatter.string(from: date)
        
        return cell
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
