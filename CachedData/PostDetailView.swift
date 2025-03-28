
import SwiftUI

struct PostDetailView: View {
    @Environment(PostDetailsViewModel.self) var viewModel
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMessage {
            Text(error)
        } else {
            content
        }
    }
    
    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(viewModel.post.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text(viewModel.post.body)
                    .font(.system(.body))
                    .foregroundColor(Color.white.opacity(0.8))
                    .lineSpacing(8)
                    .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.white.opacity(0.7))
                    Text("Post ID: \(viewModel.post.id)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                ForEach(viewModel.postComments) { comment in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(comment.name)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            Text(comment.email)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        Text(comment.body)
                            .font(.system(.body))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .opacity(0.1)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    PostDetailView()
        .environment(PostDetailsViewModel(post: .init(id: 1, title: "Title", body: "body")))
}
