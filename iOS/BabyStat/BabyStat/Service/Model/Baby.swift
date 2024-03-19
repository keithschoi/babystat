//
//  Baby.swift
//  BabyStat
//
//  Created by KeithC on 2024-03-19.
//

import Foundation

struct Baby {
    let name: String
    let birth: Date
    let timestamp: Date
    
    init?(name: String?, birth: Date?, timestamp: Date?) {
        
        guard let name, let birth, let timestamp else { return nil }
        self.name = name
        self.birth = birth
        self.timestamp = timestamp
    }
}
