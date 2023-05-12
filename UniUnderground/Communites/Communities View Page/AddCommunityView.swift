//
//  AddCommunityView.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct AddCommunityView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var communitiesList: CommunitiesList
    @Binding var community: Communities
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            Form {
                
                
                Section(header: Text("Title")) {
                    TextField("Community Name", text: $community.name)
                }
                //change to icon
                Section(header: Text("ImageName")) {
                    TextField("Image Name of the Picture", text: $community.imageName)
                }
                Section(header: Text("Description")) {
                    TextField("Brief description of the group", text: $community.description)
                }
                Section{
                    Button(action: {
                        communitiesList.communities.append(community)
                        presentationMode.wrappedValue.dismiss()
                        communitiesList.saveCommunitiesToUserDefaults()
                        // Handle adding the new community here
                    }){
                        Text("Create Community")
                    }
                    .disabled(community.name.isEmpty || community.imageName.isEmpty || community.description.isEmpty)
                }
            }
            //.navigationTitle("Add Community")
            .navigationBarTitle(Text("Add Community"), displayMode: .inline)
            .autocapitalization(.none)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
        }
    }
}
//
//struct AddCommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCommunityView()
//    }
//}
