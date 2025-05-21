

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
                        .frame(width: 170)
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
            .frame(width: 170)
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
                        .frame(maxWidth: 360)
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
            .frame(maxWidth: 360, alignment: .leading)
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

struct FullIssueCard: View {
    let podcast: Podcast
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                    HStack(alignment: .center, spacing: 12) {
                        AsyncImage(url: URL(string: podcast.coverURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 45)
                                .clipped()
                                .cornerRadius(100)
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text(podcast.name)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("MainLight"))
                            .lineLimit(2)
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(alignment: .leading)
                
                if let firstIssue = podcast.issue.first {
                    NavigationLink(destination: IssueDetailView(issue: firstIssue)) {
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: firstIssue.coverURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 170)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(firstIssue.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 16)
                            
                            Text(firstIssue.description)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 8)
                            
                            Text(firstIssue.createdAt)
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
                                Image("IconShare")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Spacer()
                                NavigationLink(destination: IssueDetailView(issue: firstIssue)) {
                                    Text("Перейти в обсуждение")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("Background"))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical,8)
                                        .background(Color("MainGreen"))
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.top, 16)
                        }
                        .padding(.top, 16)
                    }
                    
                    if let firstComment = firstIssue.comments.first {
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Image("ProfileAvatar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(50)
                                
                                VStack(alignment: .leading) {
                                    Text(firstComment.userName)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color("MainLight"))
                                    
                                    Text("Знаток подкастов 8 уровня")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(Color("MainLight"))
                                }
                                
                                Spacer()
                                
                                Text(firstComment.createdAt)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color("MainLight"))
                            }
                            
                            Text(firstComment.content)
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
                    } else {
                        Text("Нет доступных выпусков")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    }
                    
                } else {
                    Text("Нет доступных выпусков")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color("MainLight3"))
                .offset(y: 20)
                .frame(width: 360)
            
        }
        .padding()
    }
}
struct FullPostCard: View {
    let post: Post
    let podcast: Podcast
    
    var body: some View {
        NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
            HStack(alignment: .center, spacing: 12) {
                AsyncImage(url: URL(string: podcast.coverURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipped()
                        .cornerRadius(100)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(podcast.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .lineLimit(2)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(alignment: .leading)
        
        
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("MainLight"))
                .multilineTextAlignment(.leading)
            
            
            
            Text(post.createdAt)
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
                Image("IconShare")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Spacer()
                NavigationLink(destination: PostDetailView(post: post)) {
                    Text("Перейти в обсуждение")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("Background"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.vertical,8)
                        .background(Color("MainGreen"))
                        .cornerRadius(8)
                }
            }
            .padding(.top, 16)
        }
        
        if let firstComment = post.comments.first {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image("ProfileAvatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .cornerRadius(50)
                    
                    VStack(alignment: .leading) {
                        Text(firstComment.userName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("MainLight"))
                        
                        Text("Знаток подкастов 8 уровня")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("MainLight"))
                    }
                    
                    Spacer()
                    
                    Text(firstComment.createdAt)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("MainLight"))
                }
                
                Text(firstComment.content)
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
        } else {
            Text("Нет доступных выпусков")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        
    }
}
struct CommentCard: View {
    let comment: Comment
    
    var body: some View {
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


