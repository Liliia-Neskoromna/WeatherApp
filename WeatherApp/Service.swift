import Foundation

class Service {
    
    func generateWeather(amount: Int) -> Array<Weather> {
        var arrayWeather: Array<Weather> = [Weather]()
        
        for index in 0..<amount {
        //MARK: - City
        let city: City = City.init(cityName: "Kyiv")
        
        //MARK: - Temperature
        let value: Int = Int.random(in: -24..<40)
        let units: String = "C"
        let description: String = "Raining"
        
        let temperature: Temperature = Temperature(value: value, units: units, description: description)
        
        //MARK: - Wind
        let wValue: Float = Float.random(in: 0..<20)
        let windValue: Wind = Wind(value: wValue)
        
        //MARK: - Rain
        let rValue: Int = Int.random(in: 0..<10)
        let rainValue: Rain = Rain(value: rValue)
        
        //MARK: - Date
        let date: CLong = 0
        
        
        //MARK: - Weather
        let weather: Weather = Weather(city: city, temperature: temperature, wind: windValue, rain: rainValue, date: date)
        arrayWeather.append(weather)
       }
        return arrayWeather
    }
}
