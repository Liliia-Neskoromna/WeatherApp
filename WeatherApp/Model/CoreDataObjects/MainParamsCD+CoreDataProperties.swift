import Foundation
import CoreData

extension MainParamsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainParamsCD> {
        return NSFetchRequest<MainParamsCD>(entityName: "MainParamsCD")
    }

    @NSManaged public var airHumidity: Int64
    @NSManaged public var temparuture: String?
    @NSManaged public var weatherDetail: WeatherDetailsCD?

}
