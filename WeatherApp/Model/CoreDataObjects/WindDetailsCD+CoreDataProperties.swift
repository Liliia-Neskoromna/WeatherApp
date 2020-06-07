import Foundation
import CoreData

extension WindDetailsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindDetailsCD> {
        return NSFetchRequest<WindDetailsCD>(entityName: "WindDetailsCD")
    }

    @NSManaged public var windSpeed: Float
    @NSManaged public var weatherDetail: WeatherDetailsCD?

}
