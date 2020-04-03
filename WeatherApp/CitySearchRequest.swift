import Foundation

enum CityError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct CityRequest {
    let urlresource: URL
    
    //    let headers = [
    //        "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
    //        "x-rapidapi-key": "cff5b5b863msh86b854a51654b35p1f88edjsn8781cac08a86"
    //    ]
    
    init (cityName: String) {
        let resourceString = "https://community-open-weather-map.p.rapidapi.com/weather?q=\(cityName)&units=metric"
        guard let urlresource = URL(string: resourceString) else {fatalError()}
        
        
//        self.resourceCityURL.setTemporaryResourceValue("cff5b5b863msh86b854a51654b35p1f88edjsn8781cac08a86", forKey: URLResourceKey(rawValue: "x-rapidapi-key"))
        
//        resourceCityURL.query =
//            [
//            URLQueryItem(name: "x-rapidapi-host", value: "community-open-weather-map.p.rapidapi.com"),
//            URLQueryItem(name: "x-rapidapi-key", value: "cff5b5b863msh86b854a51654b35p1f88edjsn8781cac08a86"),
//        ]
        self.urlresource = urlresource
    }
    
    func getWeather(completion: @escaping(Result<WeatherDetails, CityError>) -> Void) {
        
        var resourceCityURL = URLRequest(url: urlresource, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//        resourceCityURL.httpMethod = "GET"
        resourceCityURL.addValue("community-open-weather-map.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        resourceCityURL.addValue("cff5b5b863msh86b854a51654b35p1f88edjsn8781cac08a86", forHTTPHeaderField: "x-rapidapi-key")
        
//       resourceCityURL.setValue("community-open-weather-map.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//       resourceCityURL.setValue("cff5b5b863msh86b854a51654b35p1f88edjsn8781cac08a86", forHTTPHeaderField: "x-rapidapi-key")
        
        let dataTask = URLSession.shared.dataTask(with: resourceCityURL) {data, _, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherDetails.self, from: jsonData)
                print(weatherResponse)
                let weatherDetails = weatherResponse
                completion(.success(weatherDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
