
import Foundation
import Network

class APIClient {
    enum OverviewResult {
        case success([Post])
        case cachedOverview([Post])
        case failure(Error?)
    }
    
    enum DetailsResult {
        case success([PostComment])
        case cachedDetails([PostComment])
        case failure(Error?)
    }

    static let shared = APIClient()
    private let networkPathMonitor = NWPathMonitor()
    private var hasInternet: Bool = false
    
    private init() {
        networkPathMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connection is available.")
                self.hasInternet = true
            } else {
                print("Internet connection is unavailable.")
                self.hasInternet = false
            }
        }
        networkPathMonitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }

    func fetchOverviewData() async -> OverviewResult {
        let urlString = "https://jsonplaceholder.typicode.com/posts"

        guard hasInternet else {
            if let cachedPosts: [Post] = loadCachedData(forKey: urlString) {
                return .cachedOverview(cachedPosts)
            } else {
                return .failure(nil)
            }
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(nil)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
            
            cacheData(encodedPosts: data, forKey: urlString)
            return .success(decodedPosts)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchDetailsData(for id: Int) async -> DetailsResult {
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(id)/comments"

        guard hasInternet else {
            if let cachedPostComments: [PostComment] = loadCachedData(forKey: urlString) {
                return .cachedDetails(cachedPostComments)
            } else {
                return .failure(nil)
            }
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(nil)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPostComments = try JSONDecoder().decode([PostComment].self, from: data)
            
            cacheData(encodedPosts: data, forKey: urlString)
            return .success(decodedPostComments)
        } catch {
            return .failure(error)
        }
    }
    
    private func cacheData(encodedPosts: Data, forKey cacheKey: String) {
        UserDefaults.standard.set(encodedPosts, forKey: cacheKey)
    }
    
    private func loadCachedData<T : Decodable>(forKey cacheKey: String) -> T? {
        if let cachedPosts = UserDefaults.standard.object(forKey: cacheKey) as? Data {
            return try? JSONDecoder().decode(T.self, from: cachedPosts)
        }
        return nil
    }
}
