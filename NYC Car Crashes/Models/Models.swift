//

import Foundation

struct Crash: Decodable, Identifiable {
    
    let id = UUID()
    let crash_date: String
    let on_street_name: String?
    let contributing_factor_vehicle_1: String?
    let contributing_factor_vehicle_2: String?
    let vehicle_type_code1: String?
    let vehicle_type_code2: String?
    let latitude: String?
    let longitude: String?
    
    func convetDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.SSS"
        let date = dateFormatter.date(from: crash_date)
        return date
    }
}
