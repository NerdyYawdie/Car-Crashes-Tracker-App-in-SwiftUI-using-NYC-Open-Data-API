//

import Foundation

class CrashesViewModel: ObservableObject {
    
    @Published var crashes: [Crash] = []
    @Published var isLoading: Bool = false
    
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    let services: APIServices
    
    init(services: APIServices = APIServicesImpl()) {
        self.services = services
    }
    
    @MainActor
    func fetchCrashes() async {
        
        defer {
            isLoading = false
        }
        
        do {
            isLoading = true
            crashes = try await services.fetchCrashes()
            
        } catch {
            if let customError = error as? APIError {
                errorMessage = customError.errorTitle
                showErrorAlert.toggle()
            }
            
        }
    }

}
