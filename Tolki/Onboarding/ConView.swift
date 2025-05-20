import SwiftUI

struct ConView: View {
    let pages = [
        OnboardingData(image: "img1", title: "Большая коллекция подкастов, чарты и подборки на любой вкус", description: ""),
        OnboardingData(image: "img2", title: "Лучшее подкаст коммьюнити и самые честные отзывы ", description: ""),
        OnboardingData(image: "img3", title: "Удобный интерфейс с возможностью составления плейлистов", description: "")
    ]
    
    @State private var currentPage = 0
    @State private var hasOnboarded = false
    
    var body: some View {
        Group {
            if hasOnboarded {
                ContentView(viewModel: ViewModel())
                    .transition(.opacity)
            } else {
                ZStack {
                    // Фон для всех страниц
                    Color.black.ignoresSafeArea()
                    
                    // Текущая страница онбординга
                    switch currentPage {
                    case 0:
                        firstOnboardingView
                    case 1:
                        secondOnboardingView
                    case 2:
                        thirdOnboardingView
                    default:
                        EmptyView()
                    }
                    
                    // Кнопки навигации
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 8) {
                            // Индикаторы страниц
                            ForEach(0..<pages.count, id: \.self) { index in
                                Circle()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(index == currentPage ? Color("MainGreen") : Color.gray)
                            }
                        }
                        .padding(.bottom, 24)
                        
                        // Кнопки навигации
                        HStack {
                            if currentPage > 0 {
                                Button(action: {
                                    withAnimation {
                                        currentPage -= 1
                                    }
                                }) {
                                    Text("Назад")
                                        .foregroundColor(Color("MainGreen"))
                                        .padding()
                                }
                            }
                            
                            Spacer()
                            
                            if currentPage < pages.count - 1 {
                                Button(action: {
                                    withAnimation {
                                        currentPage += 1
                                    }
                                }) {
                                    Text("Далее")
                                        .customTextStyle(.h3Button)
                                        .foregroundColor(Color("MainGreen"))
                                        .padding()
                                }
                            } else {
                                Button(action: {
                                    withAnimation {
                                        hasOnboarded = true
                                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                                    }
                                }) {
                                    Text("Начать")
                                        .customTextStyle(.h3Button)
                                        .foregroundColor(Color("MainGreen"))
                                        .padding()
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
    }
    
    // Первая страница онбординга
    private var firstOnboardingView: some View {
        ZStack {
            Image(pages[0].image)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Text(pages[0].title)
                        .customTextStyle(.h1)
                        .foregroundColor(Color("MainGreen"))
                        .multilineTextAlignment(.leading)
                    
                        .frame(width: 300.0)
                    
                
                }
                .padding(.bottom, 160)
            }
        }
    }
    
    // Вторая страница онбординга
    private var secondOnboardingView: some View {
        ZStack {
            Image(pages[1].image)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Text(pages[1].title)
                        .customTextStyle(.h1)
                        .foregroundColor(Color("MainGreen"))
                        .multilineTextAlignment(.leading)
                    
                        .frame(width: 300.0)
                    
                    
                }
                .padding(.bottom, 650)
            }
        }
    }
    
    // Третья страница онбординга
    private var thirdOnboardingView: some View {
        ZStack {
            Image(pages[2].image)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Text(pages[2].title)
                        .customTextStyle(.h1)
                    .foregroundColor(Color("MainGreen"))
                    .multilineTextAlignment(.leading)
                
                    .frame(width: 250.0)
                    
                    
                }
                .padding(.bottom, 200)
            }
        }
    }
}

// Модель данных для экрана онбординга
struct OnboardingData: Identifiable, Hashable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}

#Preview {
    ConView()
}
