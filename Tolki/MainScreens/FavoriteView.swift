//
//  FavoriteView.swift
//  Tolki
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI

struct FavoriteView: View {
    @State private var selection: Int = 0
    let menuItems = ["ПОДКАСТЫ", "ВЫПУСКИ"]
    @State private var podcasts: [Podcast] = []
    @State private var issues: [Issue] = []
    
    var favoritePodcasts: [Podcast] {
        podcasts.filter { [10,11, 16, 17].contains($0.id) }
    }
    var filteredFavoriteIssues: [Issue] {
            issues.filter { [10,11, 16, 17].contains($0.id) }
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
                            ForEach(favoritePodcasts) { podcast in
                                PodcastCardView(podcast: podcast)
                            }
                        }
                    } else {
                        VStack {
                            ForEach(filteredFavoriteIssues) { issue in
                                IssueCardView(issue: issue)
                            }
                        }
                    }
                }
                .ignoresSafeArea(edges: .horizontal)
                .padding(.horizontal, 24)
                
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
            }
            
        }
        
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
