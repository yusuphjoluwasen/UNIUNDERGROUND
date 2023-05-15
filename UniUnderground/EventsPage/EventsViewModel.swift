//
//  EventsViewModel.swift
//  UniUnderground
//
//  Created by Guru King on 15/05/2023.
//

import Foundation
import Combine
import Firebase

final class EventsViewModel: ObservableObject {
    
    @Published var events:[Event] = []
    @Published var filteredEvents:[Event] = []
    @Published var searchString:String = ""
    @Published var messages:[GroupMessage] = []
    @Published var createNewEventStatus = false
    
    
    func createSocialEvent(event:CreateSocialEvent) {
        let db = FirebaseManager.shared.firestore.collection("events")
        let docId = db.document().documentID
        let data:[String : Any] = ["name":event.name, "description":event.description,"location":event.location,
                                   "url":event.url, "time":FirebaseManager.shared.getTimeStamp() ,"dateTime":event.dateTime, "id":docId]
        
        db.document(docId).setData(data) { [weak self]err in
            if let err = err {
                print(err)
                return
            }
            self?.createNewEventStatus = true
        }
    }
    
    func fetchEvents() {
        FirebaseManager.shared.firestore.collection("events")
            .getDocuments { [weak self] documentsSnapshot, error in
                if let error = error {
                    print("Failed to fetch events: \(error)")
                    return
                }
                
                self?.events.removeAll()
                self?.filteredEvents.removeAll()
                documentsSnapshot?.documents.forEach({ [weak self] snapshot in
                    let event = try? snapshot.data(as: Event.self)
                    self?.events.append(event!)
                    self?.filteredEvents.append(event!)
                })
            }
    }
    
    func searchEvent(){
        let newevents:[Event] = events
        if searchString == ""{
            filteredEvents = events
        }else{
           let filtered = newevents.filter { event in event.name.contains(searchString) || event.location.contains(searchString)}
            filteredEvents = filtered
        }
    }
}

