//
//  CommunitiesHome.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct CommunitiesHome: View {
    var communities: [Communities]
    @State private var isPresentingAddPizzaModal = false
    @State private var newCommunity = Communities(name: "",  imageName: "", description: "")

    var body: some View {
        NavigationView{
            List(communities) { community in
                NavigationLink(destination: CommunitiesDetailView(community: community)) {
                    HStack {
                        Image(community.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(community.name)
                    }
                }
            }
            .navigationTitle("Communities")
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Button(action: {
                        isPresentingAddPizzaModal = true
                    }){
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }.sheet(isPresented: $isPresentingAddPizzaModal) {
                AddCommunityView(community: $newCommunity, isPresented: $isPresentingAddPizzaModal)
//                    .environmentObject(CommunitiesList())
            }
        }
    }
}

struct CommunitiesHome_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesHome(communities: [
            Communities(name: "Baker's Society", imageName: "", description: "We love baking, and hope you do!"),
            ])
    }
}


