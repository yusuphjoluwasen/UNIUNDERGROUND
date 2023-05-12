//
//  Communities.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import Foundation
import Firebase

struct Community: Codable,Identifiable{
    var id:String?
    var groupname: String
    var grouplogo: String
    var description: String
    var user: String
}

struct CreateCommunity: Codable{
    var groupname: String
    var grouplogo: String
    var description: String
}

struct GroupMessage: Codable,Identifiable{
    var id:String?
    var text: String
    var communityid: String
    var userfirstname: String
    var userlastname: String
    var userschool: String
    let time: Timestamp
}


