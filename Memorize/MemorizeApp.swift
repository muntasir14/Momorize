//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ikramuzzaman Muntasir on 23/1/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
