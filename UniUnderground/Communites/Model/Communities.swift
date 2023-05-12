//
//  Communities.swift
//  UniUnderground
//
//  Created by Ifeoma on 11/05/2023.
//

import Foundation

struct Communities: Identifiable, Decodable, Encodable{
    var id = UUID()
    var name: String
    var imageName: String
    var description: String
    var commentList: CommentList?
}
