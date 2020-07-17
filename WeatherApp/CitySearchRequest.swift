import Foundation

enum CityError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct CityRequest {
    let urlresource: URL

    init (cityName: String) {
        let resourceString = "https://community-open-weather-map.p.rapidapi.com/weather?q=\(cityName)&units=metric"
        guard let urlresource = URL(string: resourceString) else { fatalError() }

        self.urlresource = urlresource
    }

    func getWeather(completion: @escaping(Result<WeatherDetails, CityError>) -> Void) {

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
