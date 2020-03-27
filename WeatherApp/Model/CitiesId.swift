import Foundation

struct CitiesId {
    
    var cityIdsArray: Array = [524901, 703448, 2643743, 1850147, 3067696, 2988507, 1609350, 5815135, 6167865]
    
    func getCityId(array: [Int]) -> String {
        let stringArray = array.map{ String($0) }
        let string = "\(stringArray.joined(separator: ","))"
        return string
    }
    
}
