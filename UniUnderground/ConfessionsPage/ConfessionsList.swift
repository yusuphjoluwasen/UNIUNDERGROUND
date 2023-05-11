//
//  ConfessionsList.swift
//  UniUnderground
//
//  Created by Betty Demissie on 11/05/2023.
//

import Foundation

class ConfessionsCommentsList: ObservableObject {
    @Published var confessionsComments: [String] = []
    
    func addComment(comment: String) {
           // Add the comment to the list of comments
        confessionsComments.append(comment)
           
           // Save the updated comments list to user defaults
           let userDefaults = UserDefaults.standard
           do {
               let commentsData = try JSONEncoder().encode(confessionsComments)
               userDefaults.set(commentsData, forKey: "Comments")
           } catch {
               print("Error encoding comments data: \(error)")
           }
       }
       
       // Load comments from user defaults
       func loadCommentsFromUserDefaults() {
           let userDefaults = UserDefaults.standard
           if let commentsData = userDefaults.data(forKey: "Comments"),
               let comments = try? JSONDecoder().decode([String].self, from: commentsData) {
               self.confessionsComments = comments
           }
       }
    
    
}
