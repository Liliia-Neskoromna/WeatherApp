import UIKit

class WeatherTableViewController: UITableViewController {
    
//    var arrayWeather: Array<Weather> = Array()
    let kReUseIdentitfire: String = "weatherTableViewCell"
    
    var listOfWeather = [WeatherDetails]() {
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfWeather.count) Weather found"
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
        
        let temp: String = "\(weather.main.temp)"
        cell.tempLabel?.text = temp
        
        let wind: String = "\(weather.wind.speed)"
        cell.windLabel?.text = wind
        
        let rain = "\(weather.main.humidity)"
        cell.rainLabel?.text = rain
        
        return cell
    }
    
    
}
