import Foundation
import CoreData

extension WeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCD> {
        return NSFetchRequest<WeatherCD>(entityName: "WeatherCD")
    }

    @NSManaged public var iconWeather: String?
    @NSManaged public var weatherDetail: WeatherDetailsCD?

}
