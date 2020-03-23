import Foundation


enum WeatherError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct WeatherRequest {
    let resourceURL: URL
    let API_KEY = "35b80fc7e92ced8b98ba88190b7b274b"
    
// #непонятношо
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
//        let id: Array = [524901, 703448, 2643743]
        
        let resourceString = "http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&APPID=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getWeather(completion: @escaping(Result<[List], WeatherError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                let weatherDetails = weatherResponse.response.weather
                completion(.success(weatherDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    
}
