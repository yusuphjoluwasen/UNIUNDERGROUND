//
//  CommunitiesList.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import SwiftUI
class CommunitiesList: ObservableObject{
    @Published var communities: [Communities] = []
    @Published var comments: [String] = []
    
    init() {
        let userDefaults = UserDefaults.standard
        
        // Try to read the communities data from user defaults
        if let communitiesData = userDefaults.data(forKey: "Community"),
           let communities = try? JSONDecoder().decode([Communities].self, from: communitiesData) {
            self.communities = communities
        }
        
        // If communities data is not available in user defaults, load it from the bundled Community.json file
        else if let url = Bundle.main.url(forResource: "Community", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.communities = try decoder.decode([Communities].self, from: data)
                // Save the loaded communities data to user defaults
                let communitiesData = try JSONEncoder().encode(self.communities)
                userDefaults.set(communitiesData, forKey: "Community")
            } catch {
                print("Error decoding community data: \(error)")
            }
        }
    }
    
    // Function to save the communities data to user defaults
    func saveCommunitiesToUserDefaults() {
        let userDefaults = UserDefaults.standard
        do {
            let communitiesData = try JSONEncoder().encode(self.communities)
            userDefaults.set(communitiesData, forKey: "Community")
        } catch {
            print("Error encoding community data: \(error)")
        }
    }
    
    func addComment(comment: String) {
        // Add the comment to the list of comments
        comments.append(comment)
        
        // Save the updated comments list to user defaults
        let userDefaults = UserDefaults.standard
        do {
            let commentsData = try JSONEncoder().encode(comments)
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
            self.comments = comments
        }
    }
    
//    func deleteCommunities(_ communities: Communities) {
//        if let index = communities.firstIndex(where: { $0.id == communities.id }) {
//            communities.remove(at: index)
//            saveCommunitiesToUserDefaults()
//        }
//    }
}
