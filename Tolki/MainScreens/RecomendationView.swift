import SwiftUI

struct RecomendView: View {
    let menuItems = ["ДЛЯ ВАС", "ПОДПИСКИ"]
    @State private var selection: Int? = 0
    @State private var podcasts: [Podcast] = []
    
    var newissue: Podcast? {
        podcasts.first { $0.id == 32 }
    }
    
    var recfeed: Podcast? {
        podcasts.first { $0.id == 17 }
    }
    
    var fullrecfeed: [Podcast] {
        podcasts.filter { [4, 5, 6, 7].contains($0.id) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        VStack {
                            Text("Обсудим подкаст?")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(Color(.mainLight))
                                .multilineTextAlignment(.center)
                                .frame(width: 400)
                                .padding(.top, 20)
                            
                            Text("Для нас важно каждое мнение о подкаст-контенте, присоединяйся к нашему обсуждению!")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(.mainLight))
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                                .frame(width: 250)
                        }
                        .frame(height: 400)
                        
                        Image("RecBg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 410)
                    }
                    
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
                        .padding(.vertical, 10)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("MainLight3"))
                                .offset(y: 20)
                                .frame(width: 360)
                        )
                        
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Самый обсуждаемый подкаст этого дня")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100)
                            .padding(.bottom, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,-20)
                        
                        if let firstPodcast = newissue {
                            NavigationLink(destination: PodcastDetailView(podcast: firstPodcast)) {
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: firstPodcast.coverURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 65, height: 65)
                                            .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    VStack(alignment: .leading) {
                                        Text(firstPodcast.name)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(Color("MainLight"))
                                            .lineLimit(2)
                                            .padding(.top, 8)
                                        
                                        Spacer()
                                        
                                        HStack {
                                            ForEach(firstPodcast.themes, id: \.id) { theme in
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
                                    }
                                }
                            }
                        } else {
                            Text("Нет доступных выпусков")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color("MainLight3"))
                            .offset(y: 20)
                            .frame(width: 360)
                        Text("Лента обсуждений")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100)

                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,40)
                    }
                    .padding()
                    
                    
                    
                    ForEach(fullrecfeed) { podcast in
                        FullIssueCard(podcast:podcast)
                        
                    }
                }
            }
            .background(Color(.background))
            .onAppear {
                PodcastService.shared.fetchPodcasts { podcasts in
                    if let podcasts = podcasts {
                        DispatchQueue.main.async {
                            self.podcasts = podcasts
                        }
                    }
                }
            }
        }
    }
}

struct RecomendView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendView()
    }
}
