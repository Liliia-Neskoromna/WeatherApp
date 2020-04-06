import Foundation
import CoreData


extension WeatherDetailsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDetailsCD> {
        return NSFetchRequest<WeatherDetailsCD>(entityName: "WeatherDetailsCD")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var citysId: Int64
    @NSManaged public var withMainParams: MainParamsCD?
    @NSManaged public var withWeather: WeatherCD?
    @NSManaged public var withWind: WindDetailsCD?

}
