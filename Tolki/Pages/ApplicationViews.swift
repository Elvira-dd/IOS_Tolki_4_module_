

//
//  Untitled.swift
//  Tolki
//
//  Created by Эльвира on 21.05.2025.
//

import SwiftUI


struct PodcastCardView: View {
    let podcast: Podcast

    var body: some View {
        NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: podcast.coverURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(podcast.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .lineLimit(1)
                    .padding(.top, 8)

                Text(podcast.description)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("MainLight"))
                    .lineLimit(2)
                    .padding(.top, -5)

                HStack(alignment: .center) {
                    Image("persons_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("1567 слушателей")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("MainLight"))
                        .lineLimit(3)
                        .padding(.top, -5)
                }
            }
            .frame(height: 250)
        }
    }
}


struct IssueCardView: View {
    let issue: Issue

    var body: some View {
        NavigationLink(destination: IssueDetailView(issue: issue)) {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: issue.coverURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 6.0) {
                    Text(issue.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("MainLight"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.top, 8)

                    Text(issue.createdAt)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("MainLight2"))
                        .lineLimit(1)
                        .padding(.top, 8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct IssueChartCard: View {
    let issue: Issue

    var body: some View {
        NavigationLink(destination: IssueDetailView(issue: issue)) {
            HStack {
                AsyncImage(url: URL(string: issue.coverURL)) { image in
                    image.resizable().scaledToFill().frame(width: 50, height: 50)
                    
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack {
                    Text(issue.name)
                        .customTextStyle(.h3)
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    Text(issue.podcastName ?? "")                                                .customTextStyle(.h4)
                        .foregroundColor(Color(.mainLight2))
                        .multilineTextAlignment(.leading)
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                }
            }
        }}
}
