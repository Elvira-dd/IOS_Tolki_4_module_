import SwiftUI

enum Tab: Int, CaseIterable {
    case home, recommend, favorite, profile

    var title: String {
        switch self {
        case .home: return "Главная"
        case .recommend: return "Подкасты"
        case .favorite: return "Профиль"
        case .profile: return "Настройки"
        }
    }

    var icon: String {
        switch self {
        case .home: return "HomeIcon"
        case .recommend: return "RecIcon"
        case .favorite: return "LikeIcon"
        case .profile: return "ProfileIcon"
        }
    }

    var activeIcon: String {
        switch self {
        case .home: return "ActiveHomeIcon"
        case .recommend: return "ActiveRecIcon"
        case .favorite: return "ActiveLikeIcon"
        case .profile: return "ActiveProfileIcon"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .home: MainView()
        case .recommend: RecomendView()
        case .favorite: FavoriteView()
        case .profile: ProfileView()
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .top) {
            selectedTab.view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.mainLight4))
                .ignoresSafeArea()
                .padding(.bottom, 30)
            
            CustomTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
        }
        .padding(.bottom, 0.0)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.mainLight4)
                    .frame(height: 100)
                    .shadow(radius: 5)
                
                HStack {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Image(selectedTab == tab ? tab.activeIcon : tab.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
