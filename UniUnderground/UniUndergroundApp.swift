//
//  UniUndergroundApp.swift
//  UniUnderground
//
//  Created by Guru King on 10/05/2023.
//

import SwiftUI

@main
struct UniUndergroundApp: App {
    
    @StateObject var communitiesList = CommunitiesList()
    
    var body: some Scene {
        WindowGroup {
            CommunitiesLandingPage().environmentObject(communitiesList)
        }
    }
}
