
import SwiftUI

@Observable class PostDetailsViewModel {
    var post: Post
    var postComments: [PostComment] = []
    var isLoading = false
    var errorMessage: String?
    
    init(post: Post) {
        self.post = post
        Task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil
        
        switch await APIClient.shared.fetchDetailsData(for: post.id) {
        case .success(let postComments), .cachedDetails(let postComments):
            await MainActor.run {
                self.postComments = postComments
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
