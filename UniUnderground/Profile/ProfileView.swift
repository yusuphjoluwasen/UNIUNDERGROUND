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
    @State var moveToPAPage = false
    @AppStorage("profile")
    private var profileData:Data = Data()
    
    var body: some View {
        NavigationStack{
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
                    .frame(width: getScreenSize().width, height: 200, alignment: .leading)
                    
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
                            moveToPAPage = true
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
                .onAppear{
                    loadFromAppStorage()
                }
                .onChange(of: viewModel.fetchData, perform: { newValue in
                    if newValue{
                        saveToAppStorage(profile: viewModel.user)
                    }
                })
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                        .destructive(Text("Sign Out"), action: {
                            handleSignOut()
                        }),
                        .cancel()
                    ])
                }
            }
            .navigationDestination(isPresented: $moveToPAPage, destination: {
                PersonalAssistantView(name: viewModel.user?.firstname ?? "")
            })
            .ignoresSafeArea()
        
        }
    }
    
    func signOut(){
        shouldShowLogOutOptions = true
    }
    
    func handleSignOut(){
        viewModel.handleSignOut()
        vm.signOut()
    }
    
    func saveToAppStorage(profile:UserProfile?){
        guard let profileData = try? JSONEncoder().encode(profile) else { return }
        self.profileData = profileData
    }
    
    func loadFromAppStorage(){
        guard let profile = try? JSONDecoder().decode(UserProfile.self, from: profileData) else {
            viewModel.fetchUser()
            return
        }
        print("load from app storage")
        viewModel.updateProfile(user: profile)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
