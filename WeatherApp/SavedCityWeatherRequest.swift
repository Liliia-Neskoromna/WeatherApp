import Foundation

enum SavedCityError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct SavedCityRequest {
    let urlresource: URL
    
    init () {
        let resourceString = "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&exclude=daily&appid=35b80fc7e92ced8b98ba88190b7b274b"
        guard let urlresource = URL(string: resourceString) else { fatalError() }
        
        self.urlresource = urlresource
    }
    
    func getWeather(completion: @escaping(Result<SectionIdType, SavedCityError>) -> Void) {
        
        var resourceCityURL = URLRequest(url: urlresource, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        resourceCityURL.addValue("community-open-weather-map.p.rapidapi.com",
                                 forHTTPHeaderField: "x-rapidapi-host")
        resourceCityURL.addValue("cff5b5b863msh86b854a51654b35p1f88edjsn8781cac08a86",
                                 forHTTPHeaderField: "x-rapidapi-key")
        let dataTask = URLSession.shared.dataTask(with: resourceCityURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(SectionIdType.self, from: jsonData)
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
