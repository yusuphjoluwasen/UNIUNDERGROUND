//
//  FirebaseManager.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
import SwiftUI
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
   // let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
     //   self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
