//import UIKit
//
//class ReusableTableView: UITableViewController {
//    
//    let reusableTableView =
//    let kReUseIdentitfire = ["weatherTableViewCell", "searchCityTableViewCell"]
//    
//    var listOfWeather = [WeatherDetails]()
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listOfWeather.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: kReUseIdentitfire, for: indexPath) as? UITableViewCell else {fatalError("Bad Cell")}
//        
//        let weather = listOfWeather[indexPath.row]
//        // City
//        let city = weather.name
//        cell.cityLabel?.text = city
//        // Temp
//        let temp: Float = weather.main.temp
//        let roundTemp = temp.rounded()
//        let t = roundTemp.shortValue + " °C"
//        cell.tempLabel?.text = t
//        // Wind
//        let wind: String = "\(weather.wind.speed)" + "  m/s"
//        cell.windLabel?.text = wind
//        // Humidity
//        let rain = "\(weather.main.humidity)" + " %"
//        cell.rainLabel?.text = rain
//        // Icon
//        let icon = weather.weather[0].icon
//        let string = "https://openweathermap.org/img/wn/\(icon)@2x.png"
//        cell.imageWeatherIcon.imageFromServerURL(urlString: string)
//        // Date in format "MMM dd,yyyy"
//        let date = Date()
//        let formate = Date.getFormattedDate(date: date, format: "MMM dd, yyyy")
//        cell.dateLabel?.text = formate
//        return cell
//    }
//}
