//
//  AddCommunityView.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI

struct AddCommunityView: View {
    @State var name: String = ""
    @State var description: String = ""
    @State var image: UIImage?
    @State var shouldShowImagePicker = false
    @State var status = ""
    @ObservedObject var viewModel:CommunitiesViewModel = CommunitiesViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                Button(action: {
                    shouldShowImagePicker.toggle()
                }){
                    VStack{
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .cornerRadius(64)
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                .padding(.vertical)
            
                TextField("Community Name", text: $name)
                    .border(Color.black)
               
                TextField("Brief description of the group", text: $description)
                    .border(Color.black)
                
                Button(action: {
                    viewModel.createCommunity(image: image ?? UIImage(), name: name, description: description)
                    
                }){
                    Text("Create Community")
                }
                .disabled(name.isEmpty || description.isEmpty)
                
                Text(status)
                    .padding(.top)
            }
            .padding(.horizontal)
            .onChange(of: viewModel.createNewCommunityStatus) { value in
                if value{
                   status = "Created Successfully"
                }
            }
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
                    .ignoresSafeArea()
            }
        }
    }
}

struct AddCommunityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommunityView()
    }
}



//    .navigationBarTitle(Text("Add Community"), displayMode: .inline)
//    //            .autocapitalization(.none)
//    .navigationBarItems(leading: Button(action: {
//        presentationMode.wrappedValue.dismiss()
//    }) {
//        Text("Cancel")
//    })
