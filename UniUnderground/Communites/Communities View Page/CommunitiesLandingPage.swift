//
//  CommunitiesLandingPage.swift
//  UniUnderground
//
//  Created by Ifeoma on 10/05/2023.
//

import SwiftUI

struct CommunitiesLandingPage: View {
    @EnvironmentObject var communitiesList: CommunitiesList
    
    var body: some View {
        TabView {
            Text("Confessions Page")
                .tabItem {
                    Image(systemName: "eyes.inverse")
                        Text("Confessions")
                }
            CommunitiesHome(communities: communitiesList.communities)
                .tabItem {
                    Image(systemName: "person.3.fill")
                        Text("Communities")
                }
            Text("Events Page")
                .tabItem {
                    Image(systemName: "house.fill")
                        Text("Events")
                }
        }
    }
}


struct CommunitiesLandingPage_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesLandingPage().environmentObject(CommunitiesList())
    }
}
