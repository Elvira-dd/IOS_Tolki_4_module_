//
//  DataFetch.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import SwiftUI
import Foundation






class PodcastService {
    static let shared = PodcastService()
    
    // URL для фетчинга данных о подкастах
    private let podcastsURL = URL(string: "http://localhost:3000/api/v1/podcasts")!
    
    func fetchPodcasts(completion: @escaping ([Podcast]?) -> Void) {
        let task = URLSession.shared.dataTask(with: podcastsURL) { data, response, error in
            if let data = data {
                do {
                    let podcasts = try JSONDecoder().decode([Podcast].self, from: data)
                    completion(podcasts)
                } catch {
                    print("Ошибка при декодировании данных: \(error)")
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .keyNotFound(let key, let context):
                            print("Не найден ключ: \(key) в пути: \(context.codingPath)")
                        case .typeMismatch(let type, let context):
                            print("Ошибка типа: \(type) в пути: \(context.codingPath)")
                        case .valueNotFound(let value, let context):
                            print("Не найдено значение: \(value) в пути: \(context.codingPath)")
                        case .dataCorrupted(let context):
                            print("Коррупция данных: \(context)")
                        @unknown default:
                            print("Неизвестная ошибка декодирования")
                        }
                    }
                    completion(nil)
                }
            } else {
                print("Ошибка при загрузке данных: \(String(describing: error))")
                completion(nil)
            }
        }
        task.resume()
    }
}
class IssueAllService {
    static let shared = IssueAllService()
    
    // URL для фетчинга данных о подкастах
    private let issuesURL = URL(string: "http://localhost:3000/api/v1/issues")!
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void) {
        let task = URLSession.shared.dataTask(with: issuesURL) { data, response, error in
            if let data = data {
                do {
                    let issues = try JSONDecoder().decode([Issue].self, from: data)
                    completion(issues)
                } catch {
                    print("Ошибка при декодировании данных: \(error)")
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .keyNotFound(let key, let context):
                            print("Не найден ключ: \(key) в пути: \(context.codingPath)")
                        case .typeMismatch(let type, let context):
                            print("Ошибка типа: \(type) в пути: \(context.codingPath)")
                        case .valueNotFound(let value, let context):
                            print("Не найдено значение: \(value) в пути: \(context.codingPath)")
                        case .dataCorrupted(let context):
                            print("Коррупция данных: \(context)")
                        @unknown default:
                            print("Неизвестная ошибка декодирования")
                        }
                    }
                    completion(nil)
                }
            } else {
                print("Ошибка при загрузке данных: \(String(describing: error))")
                completion(nil)
            }
        }
        task.resume()
    }
}

class IssueService {
    static let shared = IssueService()
    private let baseURL = "http://localhost:3000/api/v1"

    func fetchIssue(id: Int, completion: @escaping (Issue?) -> Void) {
        guard let url = URL(string: "\(baseURL)/issues/\(id)") else {
            print("❌ Ошибка: неверный URL для получения выпуска")
            completion(nil)
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Ошибка сети: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("❌ Ошибка сервера при загрузке выпуска")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ Нет данных в ответе")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let issue = try decoder.decode(Issue.self, from: data)
                DispatchQueue.main.async {
                    completion(issue)
                }
            } catch {
                print("❌ Ошибка декодирования выпуска: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
}
// AllCommentService удалён, функционал перемещён в CommentService

class CommentService {
    static let shared = CommentService()
    
    private let baseURL = "http://localhost:3000/api/v1" // Замените на ваш реальный URL
    
    func fetchAllComments(completion: @escaping ([Comment]) -> Void) {
        guard let url = URL(string: "\(baseURL)/comments") else {
            print("❌ Ошибка: Неверный URL для получения комментариев")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Ошибка сети: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            guard let data = data else {
                print("❌ Нет данных в ответе")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let comments = try decoder.decode([Comment].self, from: data)
                DispatchQueue.main.async {
                    completion(comments)
                }
            } catch {
                print("❌ Ошибка декодирования комментариев: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
    
    func createComment(issueId: Int, content: String, authToken: String, completion: @escaping (Bool) -> Void) {
        // 1. Проверка URL
        guard let url = URL(string: "\(baseURL)/comments") else {
            print("❌ Ошибка: Неверный URL для создания комментария")
            completion(false)
            return
        }
        
        // 2. Проверка токена перед отправкой
        guard !authToken.isEmpty else {
            print("❌ Ошибка: Пустой токен авторизации")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        // 3. Более безопасное создание тела запроса
        let requestBody: [String: Any] = [
            "comment": [
                "content": content,
                "commentable_id": issueId,
                "commentable_type": "Issue"
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("❌ Ошибка сериализации JSON: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        // 4. Улучшенная обработка ответа
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверка ошибки сети
            if let error = error {
                print("❌ Ошибка сети: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Проверка HTTP статус-кода
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Неверный ответ сервера")
                completion(false)
                return
            }
            
            print("🔄 Статус код: \(httpResponse.statusCode)")
            
            // Обработка данных ответа
            guard let data = data else {
                print("❌ Нет данных в ответе")
                completion(false)
                return
            }
            
            // Логирование полного ответа
            if let responseString = String(data: data, encoding: .utf8) {
                print("📄 Ответ сервера: \(responseString)")
            }
            
            // Анализ успешности запроса
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        if let error = json["error"] as? String {
                            print("❌ Ошибка сервера: \(error)")
                            completion(false)
                        } else {
                            print("✅ Комментарий успешно создан")
                            completion(true)
                        }
                    }
                } catch {
                    print("✅ Комментарий создан (не удалось разобрать JSON ответ)")
                    completion(true)
                }
            case 401:
                print("❌ Ошибка 401: Неавторизован. Проблема с токеном")
                completion(false)
            case 422:
                print("❌ Ошибка 422: Неверные данные")
                completion(false)
            default:
                print("❌ Неожиданный статус код: \(httpResponse.statusCode)")
                completion(false)
            }
        }
        
        
        task.resume()
    }
    
   
}

class ThemeFetcher: ObservableObject {
    @Published var themes: [ThemeTag] = []

    func fetchThemes() {
        guard let url = URL(string: "http://localhost:3000/api/v1/themes") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let fetchedThemes = try decoder.decode([ThemeTag].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.themes = fetchedThemes
                    }
                } catch {
                    print("Ошибка декодирования тем: \(error)")
                }
            } else if let error = error {
                print("Ошибка сети (темы): \(error)")
            }
        }.resume()
    }
}

class ProfileService {
    static let shared = ProfileService()
    private let baseURL = "http://localhost:3000/api/v1"
    
    func fetchCurrentProfile(authToken: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/me") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверка ошибки сети
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            // Проверка HTTP статус-кода
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }
            
            print("Статус код: \(httpResponse.statusCode)")
            
            // Обработка данных ответа
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
                return
            }
            
            // Логирование для отладки
            if let responseString = String(data: data, encoding: .utf8) {
                print("Ответ сервера: \(responseString)")
            }
            
            // Декодирование
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(UserProfile.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(profile))
                }
            } catch {
                DispatchQueue.main.async {
                    print("Ошибка декодирования: \(error)")
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}




class ProfileViewModel: ObservableObject {
    @Published var currentProfile: UserProfile? = UserProfile.testProfile
    @Published var isLoading = false
    @Published var error: String?
    @Published var allComments: [Comment] = []

    private let keychain = KeychainService()

    func loadCurrentProfile() {
        isLoading = true
        error = nil

        let token = keychain.getString(forKey: ViewModel.Const.tokenKey) ?? ""

        guard !token.isEmpty else {
            isLoading = false
            return
        }

        ProfileService.shared.fetchCurrentProfile(authToken: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let profile):
                    self?.currentProfile = profile
                    self?.loadComments() // ✅ Загружаем комментарии после профиля
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
    func loadComments() {
        CommentService.shared.fetchAllComments { [weak self] comments in
            DispatchQueue.main.async {
                self?.allComments = comments
            }
        }
    }
}

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(error)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct AdminBadge: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.green)
            Text("Администратор")
                .font(.caption)
                .bold()
        }
        .padding(6)
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
    }
}
