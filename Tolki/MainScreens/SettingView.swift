//
//  SettingsView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI


struct SettingsView: View {
    @State private var showFeedback = false
    @State private var showAbout = false
    @State private var showEditProfile = false
    
    // Пример начальных значений, сюда подставляешь реальные данные пользователя
    @State private var name: String = "Имя пользователя"
    @State private var bio: String = "О себе"
    @State private var level: String = "1"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Настройки")
                        .customTextStyle(.h1)
                        .foregroundColor(Color(.mainLight))
                        .padding()
                    
                    // Блок редактирования профиля
                    Section() {
                        Button(action: { showEditProfile.toggle() }) {
                            Text("Редактировать профиль")
                        }
                        .sheet(isPresented: $showEditProfile) {
                            EditProfileView(name: name, bio: bio, level: level)
                        }
                    }
                    .padding(.bottom, 24)
                    
                    // Существующий блок
                    Section(header: Text("Информация")) {
                        Button(action: { showFeedback.toggle() }) {
                            Text("Feedback")
                        }
                        .sheet(isPresented: $showFeedback) {
                            FeedbackView()
                        }
                        
                        Button(action: { showAbout.toggle() }) {
                            Text("About")
                        }
                        .sheet(isPresented: $showAbout) {
                            AboutView()
                        }
                    }
                    .padding()
                    
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(.background))
        }
    }
}

struct EditProfileView: View {
    @State var name: String
    @State var bio: String
    @State var level: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Имя", text: $name)
                .padding()
                .background(Color("MainLight4"))
                .cornerRadius(8)
            
            TextField("О себе", text: $bio)
                .padding()
                .background(Color("MainLight4"))
                .cornerRadius(8)
            
            TextField("Уровень", text: $level)
                .padding()
                .background(Color("MainLight4"))
                .cornerRadius(8)
            
            Button("Сохранить изменения") {
                saveProfile()
            }
            .padding()
            .background(Color("MainGreen"))
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
    }
    
    func saveProfile() {
        guard let token = KeychainService().getString(forKey: ViewModel.Const.tokenKey) else {
            print("❌ Токен не найден")
            return
        }
        
        ProfileService.shared.updateProfile(name: name, bio: bio, level: level, authToken: token) { success in
            if success {
                print("✅ Профиль обновлён")
                dismiss()
            } else {
                print("❌ Ошибка при обновлении профиля")
            }
        }
    }
}


#Preview {
    SettingsView()
}
