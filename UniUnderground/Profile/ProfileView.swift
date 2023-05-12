//
//  ProfileView.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel:ProfileViewModel = ProfileViewModel()
    @EnvironmentObject var vm: AppStateViewModel
    @State var shouldShowLogOutOptions = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: viewModel.user?.schoolbanner ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .overlay(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: 200)
              
                AsyncImage(url: URL(string: viewModel.user?.schoollogo ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 80, height: 80)
                .cornerRadius(40)
                .padding(.top, -45)
                
                Text("Jimoh Oluwaseun")
                    .font(.custom("Inter-Bold", size: 20))
                Text(viewModel.user?.email ?? "")
                    .font(.custom("Inter-Medium", size: 13))
                    .padding(.top, 1)
                Text("Software Engineering")
                    .font(.custom("Inter-Regular", size: 12))
            }
            
            VStack{
                
                HStack{
                    Button {
                        signOut()
                    } label: {
                        Text("My Personal Assistant")
                            .foregroundColor(Color.blue)
                            .padding(.vertical, 10)
                            .font(.custom("Inter-SemiBold", size: 17))
                    }
                    Spacer()
                }
                
                Divider()
                
                HStack{
                    Button {
                        signOut()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(Color.red)
                            .padding(.vertical, 10)
                            .font(.custom("Inter-SemiBold", size: 17))
                    }
                    Spacer()
                }
                
                Divider()
            }
            .padding([.top, .horizontal])
            .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                    .destructive(Text("Sign Out"), action: {
                        handleSignOut()
                    }),
                        .cancel()
                ])
            }
        }
        .ignoresSafeArea()
    }
    
    func signOut(){
        shouldShowLogOutOptions = true
    }
    
    func handleSignOut(){
        viewModel.handleSignOut()
        vm.signOut()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
