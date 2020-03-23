import Foundation

struct Weather {
    
    let city: City
    let temperature: Temperature
    let wind: Wind
    let rain: Rain
    let date: CLong
    
    init (city: City, temperature: Temperature, wind: Wind, rain: Rain, date: CLong) {
        self.city = city
        self.temperature = temperature
        self.wind = wind
        self.rain = rain
        self.date = date
    }
}
