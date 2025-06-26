//
//  SettingsView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI
import MapKit

struct SettingsView: View {
    @State private var showFeedback = false
    @State private var showAbout = false
    @State private var showEditProfile = false
    
    // Пример начальных значений, сюда подставляешь реальные данные пользователя
    @State private var name: String = "Имя пользователя"
    @State private var bio: String = "О себе"
    @State private var level: String = "1"
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.790278, longitude: 37.700278), // МГУ ВШЭ Москва, пример
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Настройки")
                        .multilineTextAlignment(.leading)
                    
                        .customTextStyle(.double)
                        .foregroundColor(Color(.mainLight))
                        .padding()
                    
                    // Блок редактирования профиля
                    HStack {
                        Spacer()
                        Button(action: { showEditProfile.toggle() }) {
                            Text("Редактировать профиль")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color("MainLight4"))
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $showEditProfile) {
                            EditProfileView(name: name, bio: bio, level: level)
                        }
                        
                        
                        
                    }
                    
                    
                    // Существующий блок
                    Section() {
                        
                        
                        
                        
                        
                        
                        
                        
                        VStack(alignment: .leading) {
                            Text("Это приложение для подкастов от команды ВШЭ. Авторы проекта: Галиева Эльвира, Логинова Вероника, Турицына Татьяна")
                                
                                .customTextStyle(.text)
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                            Button(action: { showFeedback.toggle() }) {
                                Text("Оставьте нам отзыв")
                                    .padding(.top, 30.0)
                                    .customTextStyle(.h4)
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    
                            }
                            .sheet(isPresented: $showFeedback) {
                                FeedbackView()
                            }
                            HStack(spacing: 40) {
                                Link("Сайт", destination: URL(string: "http://localhost:3000/my_profile")!)
                                Link("Лэндинг", destination: URL(string: "https://landing.tolki.app")!)
                            }
                            .padding(.top, 10.0)
                            .customTextStyle(.h4)
                            .foregroundColor(Color(.mainGreen))
                            .multilineTextAlignment(.leading)
                            
                            Text("Или заглядывайте в наш универ:")
                                .padding(.top, 50.0)
                            .customTextStyle(.text)
                            .foregroundColor(Color(.lightGray))
                            .multilineTextAlignment(.leading)
                            
                            Map(coordinateRegion: $region, annotationItems: [OfficeLocation()]) { location in
                                MapMarker(coordinate: location.coordinate, tint: .red)
                            }
                            .frame( height: 250)
                            .cornerRadius(10)
                            .padding()
                        }
                        
                        
                        
                        
                        
                        
                        
                    }
                    .padding()
                    
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .padding()
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
struct OfficeLocation: Identifiable {
    let id = UUID()
    let coordinate = CLLocationCoordinate2D(latitude: 55.790278, longitude: 37.700278) // Координаты Вышки
}

#Preview {
    SettingsView()
}
