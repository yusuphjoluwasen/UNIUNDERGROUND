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
           
            ConfessionsPage()
                .tabItem {
                    Image(systemName: "captions.bubble.fill")
                    Text("Confessions")
                }
            Text("hello")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Community")
                }
            Text("hello")
                .tabItem {
                    Image(systemName: "car")
                    Text("Events")
                }
            Text("hello")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
