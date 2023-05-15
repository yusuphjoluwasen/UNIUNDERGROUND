//
//  Events.swift
//  UniUnderground
//
//  Created by Betty Demissie on 12/05/2023.
//

import Foundation
import Firebase

struct Event: Identifiable, Codable {
    let id:String?
    let name: String
    let description: String
    let location: String
    let dateTime: String
    let time: Timestamp
    let url: String
}

struct CreateSocialEvent {
    let name: String
    let description: String
    let location: String
    let dateTime: String
    let url: String
}

