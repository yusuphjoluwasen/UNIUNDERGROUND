//
//  ProfileViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    
    @Published var user:UserProfile?
    @Published var fetchData:Bool = false

     func fetchUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let user = FirebaseManager.shared.firestore.collection("users").document(uid)
        
        user.getDocument { [weak self](document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let user = try? document.data(as: UserProfile.self)
                print("fetch from api")
                self?.fetchData = true
                self?.updateProfile(user: user)
            }
        }
    }
    
    func handleSignOut() {
        
        try? FirebaseManager.shared.auth.signOut()
    }
    
    func updateProfile(user: UserProfile?){
        self.user = user
    }
}
