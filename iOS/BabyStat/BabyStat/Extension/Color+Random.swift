//
//  Color+Random.swift
//  BabyStat
//
//  Created by KeithC on 2023-06-25.
//

import SwiftUI

extension Color {
    
    // Random Color 
    static func random(opacity: Double = 1) -> Self {
        let randoms = (r: Int.random(in: 0...255),
                       g: Int.random(in: 0...255),
                       b: Int.random(in: 0...255))
        return .init(red: Double(randoms.r)/255.0,
                     green: Double(randoms.g)/255.0,
                     blue: Double(randoms.b)/255.0,
                     opacity: opacity
        )
    }
}
