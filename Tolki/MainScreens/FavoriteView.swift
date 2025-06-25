import SwiftUI

struct FavoriteView: View {
    @State private var selection: Int = 0
    let menuItems = ["ПОДКАСТЫ", "ВЫПУСКИ"]
    @State private var podcasts: [FavoritePodcast] = []
    @State private var issues: [FavoriteIssue] = []
    
    var favoritePodcasts: [FavoritePodcast] {
        podcasts
    }
    var filteredFavoriteIssues: [FavoriteIssue] {
        issues
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
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
                    .padding(.vertical, 1)
                    .frame(width: 350)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color("MainLight3"))
                            .offset(y: 20)
                    )
                    
                    Spacer()
                }
                .padding()
                
                Group {
                    if selection == 0 {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(favoritePodcasts, id: \.id) { podcast in
                                ShortPodcastCardView(podcast: podcast)
                            }
                        }
                    } else {
                        VStack {
                            ForEach(filteredFavoriteIssues, id: \.id) { issue in
                                ShortIssueCardView(issue: issue)
                            }
                        }
                    }
                }
                .ignoresSafeArea(edges: .horizontal)
                .padding(.horizontal, 24)
            }
            .background(Color(.background))
            .onAppear {
                FavoriteService.shared.fetchFavorites { podcasts, issues in
                    DispatchQueue.main.async {
                        if let podcasts = podcasts {
                            self.podcasts = podcasts
                        }
                        if let issues = issues {
                            self.issues = issues
                        }
                    }
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
