import UIKit

class WeatherTableViewController: UITableViewController {
    
    var arrayWeather: Array<Weather> = Array()
    
    let kReUseIdentitfire: String = "weatherTableViewCell"
    
    override func viewDidLoad() {
           super.viewDidLoad()

        let controller = Controller()
        arrayWeather = controller.getWeather()

        

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: kReUseIdentitfire, for: indexPath) as? WeatherTableViewCell else {
            fatalError("Bad Cell")
        }
        
        let weather = arrayWeather[indexPath.row]
        
        let city = weather.city.cityName
        cell.cityLabel?.text = city
        
        let temp: String = "\(weather.temperature.value)" + weather.temperature.units
        cell.tempLabel?.text = temp
        
        let wind: String = "\(weather.wind.value)"
        cell.windLabel?.text = wind
        
        let rain = "\(weather.rain.value)"
        cell.rainLabel?.text = rain
        
        return cell
}


}
