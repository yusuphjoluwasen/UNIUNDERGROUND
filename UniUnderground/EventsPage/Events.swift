//
//  Events.swift
//  UniUnderground
//
//  Created by Betty Demissie on 12/05/2023.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var location: String
    var dateTime: String
    var website: String
}

