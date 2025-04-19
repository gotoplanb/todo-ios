//
//  Item.swift
//  todo
//
//  Created by Dave Stanton on 4/19/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var isCompleted: Bool
    var timestamp: Date
    
    init(title: String = "", isCompleted: Bool = false, timestamp: Date = .now) {
        self.title = title
        self.isCompleted = isCompleted
        self.timestamp = timestamp
    }
}
