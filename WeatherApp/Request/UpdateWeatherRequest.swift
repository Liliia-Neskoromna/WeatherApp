import Foundation

enum UpdateWeatherError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct UpdateWeatherRequest {
    
    var resourceURL: URL
    let API_KEY = "35b80fc7e92ced8b98ba88190b7b274b"
    
    var coreDataCity = City()
    
    let requestController = RequestController.shared
    
    init () {
        
        let arrayIds = CitiesId().cityIdsArray
        let joinedId = CitiesId().getCityId(array: arrayIds)
        
        let resourceString = "https://api.openweathermap.org/data/2.5/group?id=\(joinedId)&units=metric&APPID=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getWeather(completion: @escaping(Result<[WeatherDetails], UpdateWeatherError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                let weatherDetails: Array<WeatherDetails> = weatherResponse.list
                //print("UpdateWeatherRequest is working \(weatherResponse.list)")
                completion(.success(weatherDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
