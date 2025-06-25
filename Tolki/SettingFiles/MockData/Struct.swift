//
//  Struct.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import Foundation




// Структура для подкаста
struct Podcast: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var createdAt: String
    var averageRating: String
    var coverURL: String
    var issue: [Issue]
    var posts: [Post]
    var authors: [Author]
    var themes: [ThemeInPodcast]
    
    // Указываем, как ключи из JSON соответствуют нашим свойствам
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt = "created_at" // соответствие между JSON и структурой
        case averageRating = "average_rating"
        case coverURL = "cover_url"
        case issue
        case posts
        case authors
        case themes
    }
}
struct Author: Identifiable, Codable {
    var id: Int
    var name: String
    var avatarURL: String
    
    // Указываем, как ключи из JSON соответствуют нашим свойствам
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "avatar_url"
    }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Используем decodeIfPresent для безопасного декодирования
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 10  // Установим дефолтное значение
            self.name = try container.decode(String.self, forKey: .name)
            self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        }
    
}
struct FavoriteResponse: Decodable {
    let podcasts: [FavoritePodcast]
    let issues: [FavoriteIssue]
}

struct FavoritePodcast: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let averageRating: String
    let coverURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case averageRating = "average_rating"
        case coverURL = "cover_url"
    }
}

struct FavoriteIssue: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let link: String
    let isAudio: Bool
    let coverURL: String
    var podcastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case link
        case isAudio = "is_audio"
        case coverURL = "cover_url"
        case podcastName = "podcast_name"
    }
}
struct Issue: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var createdAt: String
    var podcastId: Int
    var coverURL: String
    var comments: [Comment]
    var podcastName: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case createdAt = "created_at"
        case podcastId = "podcast_id"
        case coverURL = "cover_url"
        case comments, podcastName = "podcast_name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        
        // Пробуем получить createdAt, если нет — подставляем дефолт
        createdAt = (try? container.decode(String.self, forKey: .createdAt)) ?? "Дата отсутствует"
        
        podcastId = try container.decode(Int.self, forKey: .podcastId)
        coverURL = try container.decode(String.self, forKey: .coverURL)
        comments = try container.decode([Comment].self, forKey: .comments)
        podcastName = try? container.decode(String.self, forKey: .podcastName)
    }
}

struct Post: Identifiable, Codable {
    var id: Int
    var title: String
    var content: String
    var createdAt: String
    var podcastId: Int
    var comments: [Comment]

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at" // соответствие между JSON и структурой
        case podcastId = "podcast_id"
        case comments
      
    }

}


struct Comment: Identifiable, Codable {
    var id: Int
    let commentable_type: String?
    let commentable_id: Int?
    var userId: Int?
    var content: String
    var userName: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case content
        case userName = "user_name"
        case createdAt = "created_at"
        case commentable_type
        case commentable_id
    }
    
}

struct Theme: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let url: String
    let coverUrl: String
}

struct ThemeInPodcast: Identifiable, Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

// Models/UserProfile.swift
struct UserProfile: Codable {
    let id: Int
    let email: String
    let profile: Profile
    let author: Author?
    let isAuthor: Bool
    var comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case profile
        case author
        case isAuthor = "is_author"
        case comments
    }
}

struct Profile: Codable {
    let name: String
    let bio: String
    let level: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case bio
        case level
        case avatarURL = "avatar_url"
    }
}
struct ProfileResponse: Codable {
    let id: Int
    let email: String
    let profile: Profile
    let author: Author?
    let isAuthor: Bool

    enum CodingKeys: String, CodingKey {
        case id, email, profile, author
        case isAuthor = "is_author"
    }
}

struct UserResponse: Codable {
    let isSuccess: Bool
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "is_success"
        case user
    }
}

struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let name: String
    let avatarURL: String
    let isAuthor: Bool

    enum CodingKeys: String, CodingKey {
        case id, email, name
        case avatarURL = "avatar_url"
        case isAuthor = "is_author"
    }
}
