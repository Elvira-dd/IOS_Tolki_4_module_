//
//  TolkiApp.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

@main
struct TolkiApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView(viewModel: ViewModel())
            } else {
                ConView()
            }
        }
    }
}
#Preview {
    ContentView(viewModel: ViewModel())
    
}

