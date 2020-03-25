import UIKit

class WeatherTableViewController: UITableViewController {
    
    //    var arrayWeather: Array<Weather> = Array()
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
        
        
        
        //        self.imgView.downloadImage(from: url!)
        
        
        //        let controller = Controller()
        //        arrayWeather = controller.getWeather()
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
        
        let city = weather.name
        cell.cityLabel?.text = city
        
        let temp: String = "\(weather.main.temp)" + " °C"
        cell.tempLabel?.text = temp
        
        let wind: String = "\(weather.wind.speed)" + "  m/s"
        cell.windLabel?.text = wind
        
        let rain = "\(weather.main.humidity)" + " %"
        cell.rainLabel?.text = rain
        
        let icon = weather.weather[0].icon
        //        cell.testImage?.text = test
        
        //        let image = weather.icon.icon
        
        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        cell.imageWeatherIcon.imageFromServerURL(urlString: string)
        
//        let dateFormatter : DateFormatter = DateFormatter()
//        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        cell.dateLabel?.text = dateFormatter.string(from: date)

//        print(dateFormatter.string(from: date))
        
        
        
        
//        let date = Date()
//        let currentData = "\(date.stripTime())"
//        cell.dateLabel?.text = currentData
//
//        let f = Date()
//        let d = f.stripTime()
//        print(d)
        
        
        
        
//        let currentDateTime = Date()
//        let data = Date(timeIntervalSinceReferenceDate: -123456789.0)
//        print(data)
        
        return cell
    }
}

extension Date {
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}

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
