
import Observation
import Foundation

@Observable class PostOverviewViewModel {
    var posts: [Post] = []
    var isLoading = false
    var errorMessage: String?
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil
        
        switch await APIClient.shared.fetchOverviewData() {
        case .success(let posts), .cachedOverview(let posts):
            await MainActor.run {
                self.posts = posts
                self.isLoading = false
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error?.localizedDescription ?? "Something went wrong"
                self.isLoading = false
            }
        }
    }
}
