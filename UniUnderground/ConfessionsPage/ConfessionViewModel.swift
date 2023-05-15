//
//  ConfessionViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 15/05/2023.
//

import Foundation
import Combine
import Firebase

final class ConfessionsViewModel: ObservableObject {

    @Published var confessions:[Confession] = []
    @Published var createNewConfessionStatus = false
    var firestoreListener: ListenerRegistration?
    @Published var searchString:String = ""
    @Published var searchSchoolString:String = ""
    @Published var schools = [String]()
    @Published var filteredschools = [String]()
    
      func createConfession(confession:CreateConfession) {
         let db = FirebaseManager.shared.firestore.collection("confession")
         let docId = db.document().documentID
         let data:[String : Any] = ["school":confession.school, "text":confession.text, "time":FirebaseManager.shared.getTimeStamp(), "id":docId]
         
        db.document(docId).setData(data) { [weak self]err in
            if let err = err {
                print(err)
                return
            }
            self?.createNewConfessionStatus = true
        }
    }

    
    func fetchConfessions() {
        firestoreListener?.remove()
        confessions.removeAll()
        firestoreListener = FirebaseManager.shared.firestore.collection("confession")
            .order(by: "time")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print( "Failed to listen for messages: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        do {
                            let cm = try change.document.data(as: Confession.self)
                            self.confessions.append(cm)
                        } catch {
                            print("Failed to decode message: \(error)")
                        }
                    }
                })
            }
    }
    
    func filterConfession() -> [Confession]{
        let newconfession:[Confession] = confessions
        print(searchString)
        if searchString.lowercased() == "all"{
            return confessions
        }else{
            let filtered = newconfession.filter { confession in confession.school.lowercased() == searchString.lowercased()}
            return filtered
        }
    }
    
    func changeSearchString(searchString:String){
        self.searchString = searchString
    }
    
     func fetchSchools() {
        FirebaseManager.shared.firestore.collection("schools")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    print("Failed to fetch schools: \(error)")
                    return
                }
                
                documentsSnapshot?.documents.forEach({ snapshot in
                    let school = try? snapshot.data(as: School.self)
                    self.schools.append(school?.name ?? "")
                    self.filteredschools.append(school?.name ?? "")
                })
            }
        
        self.schools.append("All")
         self.filteredschools.append("All")
    }
    
    func searchSchool(){
        let newschools:[String] = schools
        if searchSchoolString == ""{
            filteredschools = schools
        }else{
           let filtered = newschools.filter { school in school.contains(searchSchoolString)}
            filteredschools = filtered
        }
    }
}
