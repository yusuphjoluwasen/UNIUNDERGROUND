//
//  ConfessionsCommentClass.swift
//  UniUnderground
//
//  Created by Betty Demissie on 11/05/2023.
//

import Foundation
import Firebase

struct Confession: Identifiable, Codable, Equatable{
    let id:String?
    let text: String
    let school:String
    let time: Timestamp
    
    
}

struct CreateConfession: Codable{
    let text: String
    let school: String
}
