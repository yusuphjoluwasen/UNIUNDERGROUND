//
//  ConfessionClass.swift
//  UniUnderground
//
//  Created by Betty Demissie on 11/05/2023.
//

import Foundation

struct Confessions: Decodable, Encodable {
    var text: String
    var university: String
    var confessonsComment: ConfessionsCommentClass?
    
}

