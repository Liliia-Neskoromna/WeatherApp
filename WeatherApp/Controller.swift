import Foundation

class Controller {
    
    let service: Service
    
    init () {
        self.service = Service()
    }
    
    func getWeather() -> [Weather] {
        let Weather = service.generateWeather(amount: 10)
        return Weather
    }
}
