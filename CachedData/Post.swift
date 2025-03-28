
struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let body: String
}

struct PostComment: Codable, Identifiable, Hashable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
