//
//  HomeTab.swift
//  UniUnderground
//
//  Created by Betty Demissie on 10/05/2023.
//

import SwiftUI

struct HomeTab: View {
    @ObservedObject var viewModel:ProfileViewModel = ProfileViewModel()
    @AppStorage("profile")
    private var profileData:Data = Data()
    
    var body: some View {
        TabView {
            
            ConfessionsPage()
                .tabItem {
                    Image(systemName: "eyes.inverse")
                    Text("Confessions")
                }
            
            CommunitiesHome()
                .tabItem {
                    Image(systemName: "car")
                    Text("Motion")
                }
                    
            EventsPage()
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Events")
                        }
                    
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "flag.fill")
                            Text("Profile")
                            Image(systemName: "person.3.fill")
                            Text("Community")
                        }
        }
        .onAppear{
            loadFromAppStorage()
        }
        .onChange(of: viewModel.fetchData, perform: { newValue in
            if newValue{
                saveToAppStorage(profile: viewModel.user)
            }
        })
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
        viewModel.updateProfile(user: profile)
    }
}
    
    struct HomeTab_Previews: PreviewProvider {
        static var previews: some View {
            HomeTab()
        }
    }
