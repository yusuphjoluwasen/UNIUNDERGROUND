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
    @State var micicon = Image(systemName: "magnifyingglass")
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Communities 👩🏼‍🤝‍👨🏽")
                    .font(.custom("Inter-Bold", size: 32))
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                
                //search bar
                TextField("\(micicon) Search", text: $viewModel.searchString)
                            .frame(height: 36)
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        viewModel.searchString = ""
                                    }) {
                                        Image(systemName: "mic.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                }
                                }
                            )
                    
                .padding(.horizontal)
                
                Divider()
                    .padding(.vertical, 10)
                
                    List(viewModel.filteredcommunities) { community in
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
                                VStack(alignment: .leading){
                                    Text(community.groupname)
                                        .fontWeight(.semibold)
                                    Text(community.description)
                                        .font(.caption)
                                }
                            }
                        }
                    }.listStyle(.inset)
                VStack{
                    //Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            isPresenting = true
                        }){
                            ZStack{
                                Rectangle()
                                    .fill(Color.blackColor)
                                    .frame( width: 70, height:70)
                                    .cornerRadius(35)
                                Image(systemName: "plus")
                                    .foregroundColor(.whiteColor)
                            }
                           
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear{
                viewModel.fetchCommunities()
            }
            .onChange(of: viewModel.searchString) { newValue in
                viewModel.searchCommunity()
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


