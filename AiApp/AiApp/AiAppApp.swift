//
//  AiAppApp.swift
//  AiApp
//
//  Created by Domenico Cafarelli on 16/01/23.
//

import SwiftUI

@main
struct AiAppApp: App {
    @StateObject var viewModel = ChatGPTViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
