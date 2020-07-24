import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()

    func update(with jsonDictionary: [String: Any]) throws {
        guard let humidity = jsonDictionary["humidity"] as? Int,
            let temperature = jsonDictionary["temp"] as? Float,
            let speed = jsonDictionary["speed"] as? Float,
            let latitude = jsonDictionary["lat"] as? Float,
            let longtitute = jsonDictionary["lon"] as? Float,
            let name = jsonDictionary["name"] as? String,
            let cityId = jsonDictionary["id"] as? Int64

        else {
                throw NSError(domain: "", code: 100, userInfo: nil)
        }

        self.cityId = cityId
        self.name = name
        self.longtitute = longtitute
        self.latitude = latitude
        self.temperature = temperature
        self.humidity = humidity
        self.speed = speed
    }

}
