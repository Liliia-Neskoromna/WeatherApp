import Foundation
import CoreData

extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var cityId: Int64
    @NSManaged public var longtitute: Float
    @NSManaged public var latitude: Float

}
