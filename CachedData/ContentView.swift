
import SwiftUI

struct ContentView: View {
    @State private var viewModel = PostOverviewViewModel()
    @State private var selectedPost: Post?

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                List(viewModel.posts) { post in
                    HStack {
                        Text(post.title)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Spacer(minLength: 24)
                        
                        Image(systemName: "chevron.right")
                            .opacity(0.5)
                    }
                    .onTapGesture {
                        selectedPost = post
                    }
                }
                .padding(.top, 24)
                .navigationTitle("Posts")
                .navigationDestination(item: $selectedPost) { post in
                    PostDetailView()
                        .environment(PostDetailsViewModel(post: post))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
