//
//  UniUndergroundApp.swift
//  UniUnderground
//
//  Created by Guru King on 10/05/2023.
//

import SwiftUI

@main
struct UniUndergroundApp: App {
    
    @StateObject var userStateViewModel = AppStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppStateView()
                .environmentObject(userStateViewModel)
        }
    }
}



