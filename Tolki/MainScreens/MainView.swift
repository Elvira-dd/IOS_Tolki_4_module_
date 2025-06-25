import SwiftUI


struct MainView: View {
    @State private var searchText = ""
    @State private var selection: Int = 0
    let menuItems = ["ВСЕ", "НОВОЕ", "ЧАРТЫ", "ПОДБОРКИ"]
    @State private var themes: [Theme] = []
    @State private var podcasts: [Podcast] = [] // Это твои подкасты, полученные с сервера
    @State private var issues: [Issue] = []
    // Вытаскиваем только подкасты с id 4, 5, 6, 7
    var newweekpodcasts: [Podcast] {
        podcasts.filter { [4, 5, 6, 7].contains($0.id) }
    }
    
    var podborki: [Podcast] {
        podcasts.filter { [10,11, 16, 17].contains($0.id) }
    }
    
    var newissue: Podcast? {
        podcasts.first { $0.id == 30 }  // Получаем подкаст с id 30
    }
    var chartissues: [Issue] {
        issues.filter { [9, 16, 7].contains($0.id) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        Image("BG_MainPage")
                            .resizable()  // Делаем изображение масштабируемым
                            .scaledToFit()  // Подгоняем изображение по размеру контейнера
                            .frame(width: 400)  // Устанавливаем размеры
                            .padding(.top, 50.0)
                        VStack {
                            Image("Logo_full_long")
                                .resizable()  // Делаем изображение масштабируемым
                                .scaledToFit()  // Подгоняем изображение по размеру контейнера
                                .frame(width: 70)  // Устанавливаем размеры
                                .padding(.top, 100)
                            Text("Лучшие подкасты только у нас!")
                                .customTextStyle(.double)
                                .kerning(1.0)
                                .foregroundColor(Color(.mainLight))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .padding(.top, 10.0)
                                .frame(width: 290)
                            Text("У нас собрана лучшая коллекция подкастов на любой вкус, собранная исходя из отзывов и мнений реальных слушателей")
                                .customTextStyle(.h3)
                                .foregroundColor(Color(.mainLight))
                                .multilineTextAlignment(.center)
                                .padding(.top, 10.0)
                                .frame(width: 280)
                            Button(action: {
                                // логика перехода или любое другое действие
                            }) {
                                Text("К поиску")
                                    .customTextStyle(.h4)
                                    .foregroundColor(Color(.mainLight5))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 24)
                                    .background(Color(.mainGreen))
                                    .cornerRadius(8)
                            }
                            
                            .padding(.horizontal, 24)
                            .padding(.bottom, 20)
                            .frame(width: 180)
                        }}
                    Text("Что конкретно вы ищите?")
                        .customTextStyle(.h4)
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20.0)
                        .frame(width: 250)
                    
                    // Поле поиска (заглушка)
                    HStack {
                        Text("Пост")
                            .customTextStyle(.text)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                        Text("Подкаст")
                            .customTextStyle(.text)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                        Text("Выпуск")
                            .customTextStyle(.text)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                        Text("Автор")
                            .customTextStyle(.text)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                    }
                    .padding(.bottom, 20)
                    
                    TextField("Поиск...", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(50)
                        .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            // Пункты меню
                            ForEach(0..<menuItems.count, id: \.self) { index in
                                Text(menuItems[index])
                                    .customTextStyle(.h4)
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
                        Spacer()
                    }
                    .padding()
                    
                    // Новые подкасты этой недели
                    VStack(alignment: .leading) {
                        Text("Новые подкасты этой недели")
                            .customTextStyle(.h1)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100.0)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(newweekpodcasts) { podcast in
                                PodcastCardView(podcast: podcast)
                            }
                        }
                        .padding([.leading, .trailing], 0)  // Убираем отступы по горизонтали у LazyVGrid
                    }
                    .padding(.horizontal)
                    
                    // Подборки
                    VStack(alignment: .leading) {
                        Text("Подборки")
                            .customTextStyle(.h1)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100.0)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(podborki) { podcast in
                                PodcastCardView(podcast: podcast)
                            }
                        }
                        .padding([.leading, .trailing], 0)  // Убираем отступы по горизонтали у LazyVGrid
                    }
                    .padding(.horizontal)
                    .padding(.top, 30.0)
                    VStack {
                        // Заголовок с названием свежего выпуска подкаста
                        Text("Свежий выпуск подкаста: \(newissue?.name ?? "Подкаст не найден")")
                            .customTextStyle(.h1)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Если есть первый выпуск, показываем его детали
                        if let firstIssue = newissue?.issue.first {
                            IssueCardView(issue: firstIssue)
                        } else {
                            // Сообщение, если нет доступных выпусков
                            Text("Нет доступных выпусков")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                    }
                    .padding()  // Общий отступ для всего VStack
                    .padding(.top, 30.0)
                    VStack {
                        Text("Чарт выпусков")
                            .customTextStyle(.h1)
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100.0)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(0..<min(3, chartissues.count), id: \.self) { index in
                                HStack(alignment: .center) {
                                    Text("\(index + 1).")
                                        .font(.headline)
                                        .foregroundColor(Color("MainLight"))
                                        .frame(width: 20, alignment: .leading)
                                    IssueChartCard(issue: chartissues[index])
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.top, 30.0)
                    if !themes.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Тематики")
                                .customTextStyle(.h1)
                                .foregroundColor(Color(.mainLight))
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 100.0)
                                .padding(.bottom, 20)  // Отступ снизу для заголовка
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ], spacing: 16) {
                                ForEach(themes.prefix(4)) { theme in
                                    VStack(alignment: .leading, spacing: 8) {
                                        if let imageURL = URL(string: "http://localhost:3000" + theme.coverUrl) {
                                            ZStack {
                                                Color.gray // Фон-заглушка или цвет по умолчанию

                                                AsyncImage(url: URL(string: "http://localhost:3000" + theme.coverUrl)) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .padding(.trailing, 230) // Отступ внутрь от правого края
                                                } placeholder: {
                                                    Color.gray
                                                }
                                            }
                                            .frame(width: 170, height: 170)
                                            .clipped()
                                            .cornerRadius(8)
                                        } else {
                                            Color.gray
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(8)
                                        }
                                        
                                        Text(theme.name)
                                            .customTextStyle(.h4)
                                            .foregroundColor(Color(.mainLight))
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 170)
                                    }
                                }
                            }
                            .padding([.leading, .trailing], 0)
                        }
                        .padding()
                    }
                }
                
            }
            .background(Color(.background))
            
            .onAppear {
                PodcastService.shared.fetchPodcasts { podcasts in
                    if let podcasts = podcasts {
                        print("Получено подкастов: \(podcasts.count)")
                        DispatchQueue.main.async {
                            self.podcasts = podcasts }}}
                IssueAllService.shared.fetchIssues { issues in
                    if let issues = issues {
                        print("Получено выпусков: \(issues.count)")
                        DispatchQueue.main.async {
                            self.issues = issues
                        }
                    } else {
                        print("Ошибка: не удалось получить выпуски")
                    }
                }
                ThemeService.shared.fetchThemes { fetchedThemes in
                        if let fetchedThemes = fetchedThemes {
                            DispatchQueue.main.async {
                                self.themes = fetchedThemes
                            }
                        }
                    }
            }
        }
    }
}

    

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
         
    }
}
