//
//  Tic_Tac_ToeApp.swift
//  Tic-Tac-Toe
//
//  Created by Austin Hyder on 6/15/21.
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    let game = StandardGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
