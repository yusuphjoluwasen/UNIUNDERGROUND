//
//  HomeTab.swift
//  UniUnderground
//
//  Created by Betty Demissie on 10/05/2023.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        TabView {
            Text("hello")
                .tabItem {
                    Image(systemName: "car")
                    Text("Motion")
                }
            ConfessionsPage()
                .tabItem {
                    Image(systemName: "flag.fill")
                    Text("Confessions")
                }
            Text("hello")
                .tabItem {
                    Image(systemName: "flag.fill")
                    Text("Community")
                }
                }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
