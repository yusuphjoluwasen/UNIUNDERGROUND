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
                    Image(systemName: "eyes.inverse")
                    Text("Confessions")
                }
            
            CommunitiesHome()
                .tabItem {
                    Image(systemName: "car")
                    Text("Motion")
                }
                    
            Text("hello")
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Events")
                        }
                    
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "flag.fill")
                            Text("Profile")
                            Image(systemName: "person.3.fill")
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
