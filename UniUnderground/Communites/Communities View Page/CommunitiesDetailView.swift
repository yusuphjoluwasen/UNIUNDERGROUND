//
//  CommunitiesDetailView.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct CommunitiesDetailView: View {
    @EnvironmentObject var communitiesList: CommunitiesList
    let community: Communities
    @State private var newComment: String = ""

    var body: some View {
        VStack {
//            Text(community.description)
//                .font(.subheadline)

            List {
                ForEach(communitiesList.comments, id: \.self) { comment in
                    Text(comment)
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
                        communitiesList.addComment(comment: newComment)
                        newComment = ""
                    }, label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    })
                }
                .padding(.horizontal)
//                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(Color.white)
            }
        }
        .navigationTitle(community.name)
        .onAppear {
            // Load comments from user defaults when the view appears
            communitiesList.loadCommentsFromUserDefaults()
        }
    }
}




struct CommunitiesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesDetailView(community: Communities(name: "Community 1", imageName: "", description: "A group for students")).environmentObject(CommunitiesList())
    }
}

