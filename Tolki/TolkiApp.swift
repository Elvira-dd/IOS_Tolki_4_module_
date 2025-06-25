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
                MainView()
            
        }
    }
}
