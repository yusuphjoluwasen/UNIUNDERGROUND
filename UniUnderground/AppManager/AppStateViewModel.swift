//
//  AppStateViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
class AppStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    
    init() {
        let uid = FirebaseManager.shared.auth.currentUser?.uid
        if uid != nil{
            isLoggedIn = true
        }else{
            isLoggedIn = false
        }
    }
    
    func signIn() {
        isLoggedIn = true
    }
    
    func signOut() {
        isLoggedIn = false
    }
}
