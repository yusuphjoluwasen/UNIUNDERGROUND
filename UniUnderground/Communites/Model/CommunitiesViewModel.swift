//
//  CommunitiesViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 12/05/2023.
//

import Foundation
import Combine
import Firebase

final class CommunitiesViewModel: ObservableObject {

    @Published var communities:[Community] = []
    @Published var messages:[GroupMessage] = []
    @Published var createNewCommunityStatus = false
    var firestoreListener: ListenerRegistration?
    
     private func createCommunity(community:CreateCommunity) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
         let db = FirebaseManager.shared.firestore.collection("group")
         let docId = db.document().documentID
         let data = ["user": uid, "groupname":community.groupname, "grouplogo":community.grouplogo,"description":community.description, "id":docId
        ]
         
        db.document(docId).setData(data) { [weak self]err in
            if let err = err {
                print(err)
                return
            }
            self?.createNewCommunityStatus = true
        }
    }
    
     func addToCommunityMessages(text:String, communityid:String) {
         let message = GroupMessage(text: text, communityid: communityid, userfirstname: "Kola", userlastname: "Segun", userschool: "West", time: FirebaseManager.shared.getTimeStamp())
         
         let db = FirebaseManager.shared.firestore.collection("group")
             .document(communityid)
             .collection("messages")
         let docId = db.document().documentID
         
        let data:[String:Any] = ["communityid": communityid, "text":message.text, "userfirstname":message.userfirstname,"userlastname":message.userlastname,
                                 "userschool":message.userschool, "time":FirebaseManager.shared.getTimeStamp(), "id":docId
        ]
        
         db.document(docId).setData(data) { err in
            if let err = err {
                print(err)
                return
            }
            print("Success")
        }
    }

    
     func fetchCommunities() {
        FirebaseManager.shared.firestore.collection("group")
            .getDocuments { [weak self] documentsSnapshot, error in
                if let error = error {
                    print("Failed to fetch groups: \(error)")
                    return
                }
                
                self?.communities.removeAll()
                documentsSnapshot?.documents.forEach({ [weak self] snapshot in
                    let community = try? snapshot.data(as: Community.self)
                    self?.communities.append(community!)
                })
            }
    }
    
    
     func fetchCommunityMessages(communityid:String) {
         firestoreListener?.remove()
         messages.removeAll()
         firestoreListener = FirebaseManager.shared.firestore.collection("group")
            .document(communityid)
            .collection("messages")
            .order(by: "time")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print( "Failed to listen for messages: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        do {
                            let cm = try change.document.data(as: GroupMessage.self)
                            self.messages.append(cm)
                        } catch {
                            print("Failed to decode message: \(error)")
                        }
                    }
                })
            }
    }

    func createCommunity(image:UIImage, name:String, description:String){
        FirebaseManager.shared.uploadImage(image: image) { [weak self] imageurl in
            let community = CreateCommunity(groupname: name, grouplogo: imageurl, description: description)
            self?.createCommunity(community: community)
        }
    }
}
