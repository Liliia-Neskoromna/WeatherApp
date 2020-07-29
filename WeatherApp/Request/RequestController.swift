import UIKit
import CoreData

class RequestController: UIViewController {
    
    static let shared = RequestController()
    
    let persistence = PersistanceService.shared
    let context = PersistanceService.shared.context
    
    func propertiesToFetch() -> [Int] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.propertiesToFetch = ["cityId"]
        fetchRequest.resultType = .dictionaryResultType

        var arrayCityId = [Int]()
        
        do {
            let cities = try context.fetch(fetchRequest)
            for data in cities {
                let cityid = (data as AnyObject).value(forKey: "cityId") as! Int
                arrayCityId.append(cityid) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo) ")
        }
        
        return arrayCityId
    }
    
}
