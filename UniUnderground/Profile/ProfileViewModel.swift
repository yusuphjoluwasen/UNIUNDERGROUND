//
//  ProfileViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    
    @Published var user:UserProfile?
    
    init() {
        fetchUser()
    }
    
    private func fetchUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let user = FirebaseManager.shared.firestore.collection("users").document(uid)
        
        user.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                print("data", document)
                let user = try? document.data(as: UserProfile.self)
                print("user", user)
                self.user = user
            }
        }
    }
    
    func handleSignOut() {
        try? FirebaseManager.shared.auth.signOut()
    }
}
