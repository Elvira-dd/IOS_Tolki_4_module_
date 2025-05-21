//
//  PodcastDetailView.swift
//  Cry
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI


struct PodcastDetailView: View {
    @State private var selection: Int = 0
    let menuItems = ["ВСЕ", "ВЫПУСКИ", "ОТЗЫВЫ", "ПОСТЫ"]
    var podcast: Podcast
    @State private var podcasts: [Podcast] = []
    @Environment(\.dismiss) var dismiss
    
    var samepodcasts: [Podcast] {
        podcasts.filter { [4, 5, 6, 7].contains($0.id) }
    }
    
    var body: some View {
        NavigationView{
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
                VStack(alignment: .leading, spacing: 24) {
                    AsyncImage(url: URL(string: podcast.coverURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()  // Растягивает изображение по ширине
                            .frame(width: 370, height: 350.0)  // Фиксированная высота для изображения
                            .clipped()  // Обрезает, если изображение выходит за пределы
                            .cornerRadius(12)
                        
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack {
                        ForEach(podcast.themes, id: \.id) { theme in
                            Text(theme.name)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color("MainLight"))
                                .lineLimit(1)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color("MainLight3"))
                                .cornerRadius(8)
                        }
                    }
                    
                    Text(podcast.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text(podcast.description)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // Отображение авторов
                    VStack(alignment: .leading) {
                        Text("Авторы:")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(podcast.authors) { author in
                            HStack(alignment: .center) {
                                
                                AsyncImage(url: URL(string: author.avatarURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                VStack(){
                                    Text(author.name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color(.mainLight))
                                        .multilineTextAlignment(.leading)
                                    
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("ведущая" )
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color(.mainLight2))
                                        .multilineTextAlignment(.leading)
                                    
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        
                    }
                    
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            // Пункты меню
                            ForEach(0..<menuItems.count, id: \.self) { index in
                                Text(menuItems[index])
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(self.selection == index ? Color("MainGreen") : .gray)
                                    .padding()
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
                    
                    
                    Text("Выпуски:")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)  // Отступ снизу для заголовка
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(podcast.issue) { issue in
                                IssueCardView(issue: issue)
                            }
                        }
                        
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
                    .padding(.top, 50)
                    
                    Text("Похожее")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)  // Отступ снизу для заголовка
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(samepodcasts) { podcast in
                                PodcastCardView(podcast:podcast)
                            }
                        }
                        
                    }
                    Image("subscribe_ad")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .cornerRadius(12)
                        .padding(.top, 30.0)
                    
                    Text("Лента автора")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)  // Отступ снизу для заголовка
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if !podcast.posts.isEmpty {
                        ForEach(podcast.posts) { post in
                            FullPostCard(post: post, podcast: podcast)
                        }
                    } else {
                        Text("Нет постов")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 24)
            }
            
            .background(Color(.background))
            .onAppear {
                PodcastService.shared.fetchPodcasts { podcasts in
                    if let podcasts = podcasts {
                        DispatchQueue.main.async {
                            self.podcasts = podcasts
                        }}}}}
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PodcastDetailPreview()
}

struct PodcastDetailPreview: View {
    @State private var podcast: Podcast? = nil

    var body: some View {
        Group {
            if let podcast = podcast {
                PodcastDetailView(podcast: podcast)
            } else {
                ProgressView("Загружаем подкаст...")
            }
        }
        .task {
            await loadPodcast()
        }
    }

    func loadPodcast() async {
        guard let url = URL(string: "http://localhost:3000/api/v1/podcasts/1") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPodcast = try JSONDecoder().decode(Podcast.self, from: data)

            DispatchQueue.main.async {
                self.podcast = decodedPodcast
            }
        } catch {
            print("Ошибка загрузки подкаста: \(error)")
        }
    }
}
