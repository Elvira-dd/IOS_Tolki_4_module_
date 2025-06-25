//
//  ThemeView.swift
//  Tolki
//
//  Created by Эльвира on 25.06.2025.
//

import SwiftUI

struct ThemesView: View {
    @State private var themes: [Theme] = []

    private let baseURL = "http://localhost:3000"

    var body: some View {
        NavigationView {
            List(themes) { theme in
                HStack {
                    ZStack {
                        Color.gray // Фон-заглушка или цвет по умолчанию

                        AsyncImage(url: URL(string: "http://localhost:3000" + theme.coverUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .padding(.trailing, 100) // Отступ внутрь от правого края
                        } placeholder: {
                            Color.gray
                        }
                    }
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(theme.name)
                            .font(.headline)
                        
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Тематики")
            .onAppear {
                ThemeService.shared.fetchThemes { fetchedThemes in
                    if let fetchedThemes = fetchedThemes {
                        print("Получено тематик: \(fetchedThemes.count)") // Проверка
                        self.themes = fetchedThemes
                    } else {
                        print("Тематики не получены")
                    }
                }
            }
        }
    }
}
#Preview {
    ThemesView()
}
