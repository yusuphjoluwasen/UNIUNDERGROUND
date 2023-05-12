//
//  CommunitiesDetailView.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct CommunitiesDetailView: View {
    var community: Community?
    @State private var newComment: String = ""
    @ObservedObject var viewModel:CommunitiesViewModel = CommunitiesViewModel()

    var body: some View {
        VStack {
            Text(community?.groupname ?? "")
                .font(.subheadline)

            List {
                ForEach(viewModel.messages) { chat in
                    Text(chat.text)
                }
            }
            .listStyle(InsetListStyle())

            VStack {
                HStack {
                    TextField("Add a comment", text: $newComment)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    Button(action: {
                        addMessage()
                        
                    }, label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    })
                }
                .padding(.horizontal)
                .background(Color.white)
            }
        }
        .onAppear {
            viewModel.fetchCommunityMessages(communityid: community?.id ?? "")
        }
    }
    
    func addMessage(){
        viewModel.addToCommunityMessages(text: newComment, communityid: community?.id ?? "")
        newComment = ""
    }
}




struct CommunitiesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesDetailView(community:Community(groupname: "group", grouplogo: "logo", description: "description", user: "user"))
    }
}

