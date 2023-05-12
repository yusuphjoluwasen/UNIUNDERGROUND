//
//  LoginViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var loginStatusMessage = ""
    @Published var loginStatus = false
    
    func loginUser(email:String, password:String) {
        FirebaseManager.shared.auth.signIn(withEmail: email.lowercased(), password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            self.loginStatus = true
        }
    }
    
    func createNewAccount(email:String, password:String, firstname:String, lastname:String, course:String, school:School) {
        FirebaseManager.shared.auth.createUser(withEmail: email.lowercased(), password: password) { [self] result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            storeUserInformation(user: User(firstname: firstname, lastname: lastname, email: email, course: course, school: school))
        }
    }
    
    private func storeUserInformation(user:User) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": user.email, "uid": uid, "firstname":user.firstname, "course":user.course,"lastname":user.lastname,
                        "schoolname":user.school.name,  "schoollogo":user.school.logo,"schoolbanner":user.school.banner,
                        "schoolid":user.school.id,
        ]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                self.loginStatus = true
                print("Success")
            }
    }
}

struct User:Codable{
    var uid:String?
    let firstname:String
    let lastname:String
    let email:String
    let course:String
    let school:School
}

struct UserProfile:Codable{
    let uid:String
    let firstname:String
    let lastname:String
    let email:String
    let schoolbanner, schoolid, schoollogo, schoolname: String
}


