import SwiftUI
import GoogleSignIn

struct profile_pic: View {
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }
    
    private var profilePicURL: URL? {
        return user?.profile?.imageURL(withDimension: 120)
    }

    var body: some View {
        // Use `AsyncImage` to load the image asynchronously
        if let url = profilePicURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    // Placeholder image while loading
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                case .success(let image):
                    // Successfully loaded image
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                case .failure(_):
                    // Placeholder image for failure
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .foregroundColor(.red)
                @unknown default:
                    // Placeholder image for unknown state
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                }
            }
        } else {
            // Fallback if the URL is not available
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        }
    }
}

struct ProfilePic_Previews: PreviewProvider {
    static var previews: some View {
        profile_pic()
    }
}
