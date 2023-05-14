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
            VStack(alignment: .leading){
                Text("Add a Society")
                    .font(.custom("Inter-Bold", size: 32))
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                Divider()
                    .padding(.horizontal)
            }
            
            
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
                            ZStack{
                                Rectangle()
                                    .fill(Color.blackColor)
                                    .frame( width: 100, height:100)
                                    .cornerRadius(50)
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .foregroundColor(.whiteColor)
                                    .frame(width: 55, height: 55)
                            }
                        }
                    }
                    
                }
                .padding(.vertical)
                
                Text("Add a logo")
                    .font(.custom("InriaSerif-Regular", size: 16))
                    .padding()
            
                VStack{
                    TextField("Title", text: $name)
                        //.padding()
                        .font(.custom("InriaSerif-Regular", size: 16))
//                        .background(Color.white)
//                        .foregroundColor(Color.black)
//                        .cornerRadius(10)
                    
                        //.frame(height: 40)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Description", text: $description)
                        
                        .font(.custom("InriaSerif-Regular", size: 16))
                        .cornerRadius(20)
                        .frame(height: 92.0)
                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        .border(Color.black)

                    //.border(Color.black)
                    
                    
                
                Button(action: {
                    viewModel.createCommunity(image: image ?? UIImage(), name: name, description: description)
                    
                }){
                    HStack{
                        Text("Create".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .font(.custom("Inter", size: 16))
                            .foregroundColor(Color(.white))
                            .background(Color.black.cornerRadius(10))
                    }
                    //.padding(.horizontal)
                }
                .disabled(name.isEmpty || description.isEmpty)
                }

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
