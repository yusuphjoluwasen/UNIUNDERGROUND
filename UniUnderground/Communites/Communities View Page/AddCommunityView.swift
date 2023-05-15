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
                    TextField("", text: $name)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 5)
                        .font(.custom("InriaSerif-Regular", size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 0.5)
                        )
                        .placeholder(when: name.isEmpty) {
                            Text(" Title").foregroundColor(.gray)
                        }
                    
                    TextField("", text: $description)
                        .padding(.vertical, 30)
                        .padding(.horizontal, 5)
                        .font(.custom("InriaSerif-Regular", size: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 0.5)
                        )
                        .padding(.top, 10)
                        .placeholder(when: description.isEmpty) {
                            Text(" Description").foregroundColor(.gray)
                        }
                 
                    Button(action: {
                        viewModel.createCommunity(image: image ?? UIImage(), name: name, description: description)
                        
                    }){
                        HStack{
                            Text("Create".uppercased())
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 45)
                                .font(.custom("Inter-SemiBold", size: 17))
                                .foregroundColor(Color.whiteColor)
                        }
                    }
                    .frame(height: 50)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .disabled(!valid)
                    .padding(.top, 10)
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
    
    var valid: Bool{
        if name.isEmpty || description.isEmpty {
            return false
        }else{
            return true
        }
    }
    
    private var buttonColor:Color{
        if valid{
            return Color.blackColor
        }else{
            return Color.gray
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
