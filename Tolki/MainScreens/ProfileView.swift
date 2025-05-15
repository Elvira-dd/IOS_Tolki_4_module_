import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentProfile: UserProfile?
    @Published var isLoading = false
    @Published var error: String?
    
    private let keychain = KeychainService()
    
    func loadCurrentProfile() {
        isLoading = true
        error = nil
        
        let token = keychain.getString(forKey: ViewModel.Const.tokenKey) ?? ""
        print("🔑 Загружаю профиль с токеном: \(token)")
        
        guard !token.isEmpty else {
            error = "Токен авторизации не найден"
            isLoading = false
            return
        }
        
        ProfileService.shared.fetchCurrentProfile(authToken: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let profile):
                    print("✅ Профиль успешно загружен: \(profile)")
                    self?.currentProfile = profile
                case .failure(let error):
                    print("❌ Ошибка загрузки профиля: \(error.localizedDescription)")
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 50)
                } else if let error = viewModel.error {
                    ErrorView(error: error)
                } else if let profile = viewModel.currentProfile {
                    ProfileHeaderView(profile: profile)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(profile.profile.bio)
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Уровень: \(profile.profile.level)")
                        }
                        .font(.subheadline)
                        
                        if profile.isAuthor {
                            Label("Автор", systemImage: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                } else {
                    Text("Нет данных профиля")
                        .foregroundColor(.secondary)
                        .padding(.top, 50)
                }
            }
            .padding()
        }
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadCurrentProfile()
        }
    }
}
// Вспомогательные View — оставил без изменений
struct ProfileHeaderView: View {
    let profile: UserProfile
    
    var body: some View {
        VStack(spacing: 12) {
            if let url = URL(string: profile.profile.avatarURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 100, height: 100)
                         .clipShape(Circle())
                         .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            Text(profile.profile.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(profile.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top)
    }
}

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(error)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct AdminBadge: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.green)
            Text("Администратор")
                .font(.caption)
                .bold()
        }
        .padding(6)
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
    }
}
