//
//  CommunitiesHome.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct CommunitiesHome: View {
    @ObservedObject var viewModel:CommunitiesViewModel = CommunitiesViewModel()
    @State private var isPresenting = false
    var body: some View {
        NavigationStack{
            ZStack{
                List(viewModel.communities) { community in
                    NavigationLink(destination: CommunitiesDetailView(community: community)) {
                        HStack {
                            AsyncImage(url: URL(string: community.grouplogo)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.1)
                            }
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                            Text(community.groupname)
                        }
                    }
                }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            isPresenting = true
                        }){
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Communities")
            .onAppear{
                viewModel.fetchCommunities()
            }
            .navigationDestination(isPresented: $isPresenting, destination: {
                AddCommunityView()
            })
            
        }
    }
}

struct CommunitiesHome_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesHome()
    }
}


