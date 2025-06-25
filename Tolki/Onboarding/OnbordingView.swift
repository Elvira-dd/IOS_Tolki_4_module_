import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: ViewModel
    let pages = [
        OnboardingData(image: "img1", title: "Большая коллекция подкастов, чарты и подборки на любой вкус"),
        OnboardingData(image: "img2", title: "Лучшее подкаст коммьюнити и самые честные отзывы"),
        OnboardingData(image: "img3", title: "Удобный интерфейс с возможностью составления плейлистов")
    ]
    
    @State private var currentPage = 0
    @AppStorage("hasCompletedOnboarding") private var hasOnboarded: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                switch currentPage {
                case 0:
                    pageView(data: pages[0])
                case 1:
                    pageView(data: pages[1])
                case 2:
                    pageView(data: pages[2])
                default:
                    EmptyView()
                }
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .frame(width: 16, height: 16)
                                .foregroundColor(index == currentPage ? Color("MainGreen") : Color.gray)
                        }
                    }
                    .padding(.bottom, 24)
                    
                    HStack {
                        if currentPage > 0 {
                            Button("Назад") {
                                withAnimation {
                                    currentPage -= 1
                                }
                            }
                            .foregroundColor(Color("MainGreen"))
                            .padding()
                        }
                        
                        Spacer()
                        
                        if currentPage < pages.count - 1 {
                            Button("Далее") {
                                withAnimation {
                                    currentPage += 1
                                }
                            }
                            .foregroundColor(Color("MainGreen"))
                            .padding()
                        } else {
                            NavigationLink(destination: ContentView(viewModel: viewModel)) {
                                Text("Начать")
                                    .foregroundColor(Color("MainGreen"))
                                    .padding()
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                hasOnboarded = true
                            })
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                }
            }
        }
    }
        func pageView(data: OnboardingData) -> some View {
            ZStack {
                Image(data.image)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text(data.title)
                        .customTextStyle(.h1)
                        .foregroundColor(Color("MainGreen"))
                        .multilineTextAlignment(.leading)
                        .frame(width: 300)
                        .padding(.bottom, 160)
                }
            }
        }
    }

struct OnboardingData: Identifiable, Hashable {
    let id = UUID()
    let image: String
    let title: String
}

#Preview {
    OnboardingView(viewModel: ViewModel())
}
