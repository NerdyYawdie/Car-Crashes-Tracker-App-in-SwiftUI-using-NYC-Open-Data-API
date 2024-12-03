//

import Foundation

class CrashRowViewModel: ObservableObject {
    
    let dateFormatter = DateFormatter()
    let crash: Crash
    
    init(crash: Crash) {
        self.crash = crash
    }
    
    func convetDate() -> Date? {
    
        dateFormatter.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.SSS"
        let date = dateFormatter.date(from: crash.crash_date)
        return date
    }
}
