//
//  SchoolViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
import FirebaseFirestoreSwift

final class SchoolViewModel: ObservableObject {
    
    @Published var schools = [School]()
    @Published var errorMessage = ""
    
    init() {
        fetchSchools()
    }
    
    private func fetchSchools() {
        FirebaseManager.shared.firestore.collection("schools")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch schools: \(error)"
                    print("Failed to fetch schools: \(error)")
                    return
                }
                
                documentsSnapshot?.documents.forEach({ snapshot in
                    let school = try? snapshot.data(as: School.self)
                        self.schools.append(school!)
                })
            }
    }
}




struct ChatUser: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, email, profileImageUrl: String
}

struct School: Codable, Identifiable {
    let banner, id, logo, name: String
}
