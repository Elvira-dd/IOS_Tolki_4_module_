import SwiftUI


// Тестовые данные для UserProfile с учётом твоей структуры
extension UserProfile {
    static let testProfile = UserProfile(
        id: 0,
        email: "test@example.com",
        profile: Profile(
            name: "Тестовый пользователь",
            bio: "Это тестовое описание профиля для тестирования.",
            level: "1",
            avatarURL: "ProfileAvatar"
        ),
        author: nil,
        isAuthor: false,
      comments: []
    )
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 20) {
                        if viewModel.isLoading {
                            ProgressView()
                                .padding(.top, 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else if let error = viewModel.error {
                            ErrorView(error: error)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else if let profile = viewModel.currentProfile {
                            HStack(spacing: 16) {
                                Spacer()
                                Button(action: {
                                    //                                viewModel.signOut()
                                }) {
                                    Text("Выйти")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("MainLight"))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color("MainLight4"))
                                        .cornerRadius(8)
                                }
                                
                                NavigationLink(destination: SettingsView()) {
                                    Image("SettingIcon")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                if let url = URL(string: profile.profile.avatarURL), !profile.profile.avatarURL.isEmpty {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: .infinity, minHeight: 200)
                                            .cornerRadius(12)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(maxWidth: .infinity, minHeight: 200)
                                    }
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Text(profile.profile.name)
                                    .padding(.top, 32.0)
                                    .customTextStyle(.display)
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing: 4) {
                                    Text("знаток города")
                                    Text(profile.profile.level)
                                    Text("уровня")
                                }
                                .customTextStyle(.text)
                                .foregroundColor(Color("MainLight"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Блок комментариев пользователя
                            if let comments = profile.comments, !comments.isEmpty {
                                // Сортируем по дате (новые сверху)
                                let sortedComments = comments.sorted { $0.createdAt > $1.createdAt }
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Мои комментарии")
                                        .font(.headline)
                                        .foregroundColor(Color("MainLight"))
                                        .padding(.top)
                                    
                                    ForEach(sortedComments) { comment in
                                        CommentCard(comment: comment)
                                    }
                                }
                            } else {
                                Text("Вы пока не оставляли комментариев")
                                    .foregroundColor(Color("MainLight"))
                                    .padding()
                            }
                        } else {
                            Text("Нет данных профиля")
                                .foregroundColor(.secondary)
                                .padding(.top, 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                }
                .background(Color(.background))
                .onAppear {
                    viewModel.loadCurrentProfile()
                    viewModel.loadComments()
                }
            }
            .background(Color(.background))
        }
    }
    
}
    struct ProfilePreviewView: View {
        @StateObject private var viewModel = ProfileViewModel()
        
        var body: some View {
            NavigationView {
                ProfileView()
                    .environmentObject(viewModel)
                    .onAppear {
                        viewModel.loadCurrentProfile()
                    }
            }
        }
    }
    
    struct ProfilePreviewView_Previews: PreviewProvider {
        static var previews: some View {
            ProfilePreviewView()
        }
    }
