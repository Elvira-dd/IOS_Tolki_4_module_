//
//  IssueDateilView.swift
//  Cry
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI
import SwiftUI

struct IssueDetailView: View {
    @State var issue: Issue
    @State private var issues: [Issue] = []
    @State private var commentContent: String = ""
    @State private var selection: Int = 0
    let menuItems = ["ВСЕ", "ОТЗЫВЫ", "ОБСУЖДЕНИЯ", "ПОХОЖЕЕ"]
    @Environment(\.dismiss) var dismiss
    
    
    var relatedIssues: [Issue] {
        issues.filter { $0.podcastId == issue.podcastId && $0.id != issue.id }
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("ArrowBack")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Spacer()
                HStack (spacing: 12) {
                    Image("LikeIcon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image("BurgerMenuIcon")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .frame(width: 370)
            
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: issue.coverURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                Text(issue.createdAt ?? "Дата неизвестна")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("MainLight"))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(issue.name)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    HStack {
                        // Пункты меню
                        ForEach(0..<menuItems.count, id: \.self) { index in
                            Text(menuItems[index])
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(self.selection == index ? Color("MainGreen") : .gray)
                                .padding(.horizontal,10.0)
                                .onTapGesture {
                                    self.selection = index
                                }
                        }
                    }
                    .padding(.vertical, 10)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color("MainLight3")) // Цвет обводки
                            .offset(y: 20) // Расположение обводки
                    )
                    
                }
                VStack(){
                    Text("Рейтинг подкастов")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color("MainLight"))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(){
                        HStack(){
                            Image("StarIconFill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30)
                            Image("StarIconFill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30)
                            Image("StarIconFill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30)
                            Image("StarIconFill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30)
                            Image("StarIconNoFill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height:30)
                        }
                        Spacer()
                        Text("4.6")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color("MainGreen"))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Оценили 20459 пользователей")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color("MainLight"))
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                    }
                    HStack() {
                        VStack(alignment: .leading){
                            Text("76%")
                                .font(.system(size: 64, weight: .medium))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Интересная тема обсуждений")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .frame(width: 160, alignment: .leading)
                        }
                        .frame(width:150)
                        .padding(.all,16)
                        .background(Color("MainLight4"))
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading){
                            Text("46%")
                                .font(.system(size: 64, weight: .medium))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Глубокий анализ материала")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .frame(width: 140, alignment: .leading)
                        }
                        .frame(width:150)
                        .padding(.all,16)
                        .background(Color("MainLight4"))
                        .cornerRadius(8)
                    }
                    
                }
                .padding(.top, 40)
                
                Image("pay_us_pls")
                    .resizable()  // Делаем изображение масштабируемым
                    .scaledToFit()  // Подгоняем изображение по размеру контейнера
                    .frame(maxWidth: .infinity)  // Устанавливаем размеры
                    .padding(.top, 70.0)
                
                
                Text("Комментарии")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                
                TextField("", text: $commentContent, prompt: Text("Напишите комментарий...").foregroundColor(Color("MainLight3")))
                    .foregroundColor(Color("MainLight")) // Цвет вводимого текста
                    .padding()
                    .background(Color("Background"))
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color("MainLight2"))
                        }
                        .padding(.horizontal, 8)
                    )
                    .padding(.bottom, 16)
                // Кнопка отправки комментария
                Button(action: {
                    let keychain = KeychainService()
                    let token = keychain.getString(forKey: ViewModel.Const.tokenKey) ?? ""

                    guard !token.isEmpty else {
                        print("❌ Ошибка: Токен пустой")
                        return
                    }

                    CommentService.shared.createComment(issueId: issue.id, content: commentContent, authToken: token) { success in
                        if success {
                            DispatchQueue.main.async {
                                commentContent = ""
                            }
                            // Отдельный запрос за обновлённым выпуском
                            IssueService.shared.fetchIssue(id: issue.id) { updatedIssue in
                                if let updatedIssue = updatedIssue {
                                    print("🔄 Новый выпуск содержит \(updatedIssue.comments.count) комментариев")
                                    DispatchQueue.main.async {
                                        self.issue = updatedIssue
                                    }
                                } else {
                                    print("⚠️ Не удалось получить обновлённый выпуск")
                                }
                            }
                        } else {
                            print("❌ Комментарий не создан — выпуск не обновляем")
                        }
                    }
                }) {
                    Text("Отправить")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color("MainGreen"))
                        .foregroundColor(Color("Background"))
                        .cornerRadius(8)
                }
                
                if issue.comments.isEmpty {
                    Text("Нет комментариев")
                        .foregroundColor(.gray)
                } else {
                    ForEach(issue.comments.sorted { $0.createdAt > $1.createdAt }) { comment in
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Image("ProfileAvatar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(50)
                                
                                VStack(alignment: .leading) {
                                    Text(comment.userName)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color("MainLight"))
                                    
                                    Text("Знаток подкастов 8 уровня")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(Color("MainLight"))
                                }
                                
                                Spacer()
                                
                                Text(comment.createdAt)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color("MainLight"))
                            }
                            
                            Text(comment.content)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 8)
                            
                            HStack(spacing: 12) {
                                Image("IconLike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Image("IconDislike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.top, 16)
                        }
                        .padding(16)
                        .background(Color("MainLight4"))
                        .cornerRadius(8)
                        .padding(.top, 24)
                    }
                }
                
                Text("Похожие выпуски")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(relatedIssues) { relatedIssue in
                            NavigationLink(destination: IssueDetailView(issue: relatedIssue)) {
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: relatedIssue.coverURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 300, height: 200)
                                            .clipped()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text(relatedIssue.name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("MainLight"))
                                        .lineLimit(2)
                                        .padding(.top, 8)
                                    
                                    Text(relatedIssue.createdAt)
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(Color("MainLight2"))
                                }
                                .frame(width: 300)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
                
                
            }
            .padding(.horizontal, 16)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(false)  // Отключение скрытия навигационной панели
            .background(Color("Background"))
            .onAppear {
                // Установим черный фон для NavigationBar
                UINavigationBar.appearance().barTintColor = UIColor.black
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
                UINavigationBar.appearance().tintColor = .white // для кнопок и стрелок
            }
            .frame(width:.infinity)
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 16)
        .background(Color("Background"))
        
        
    }
}


#Preview {
    PodcastView()
    
}
