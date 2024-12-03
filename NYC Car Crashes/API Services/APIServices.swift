//

import Foundation

protocol APIServices {
    func fetchCrashes() async throws -> [Crash]
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case custom(String)
    
    var errorTitle: String {
        switch self {
        case .invalidURL:
            return "Bad URL"
        case .invalidResponse:
            return "Bad Response"
        case .custom(let error):
            return "Something went wrong: \(error)"
        }
    }
}

class APIServicesImpl: APIServices {
    
    private let endpoint: String = "https://data.cityofnewyork.us/resource/h9gi-nx95.json?$order=crash_date DESC"
    
    func fetchCrashes() async throws -> [Crash] {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpURLResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            do {
                let crashes = try JSONDecoder().decode([Crash].self, from: data)
                return crashes
            } catch {
                throw APIError.custom(error.localizedDescription)
            }
            
        } catch {
            throw APIError.custom(error.localizedDescription)
        }
    }
}
