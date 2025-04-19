//
//  todoApp.swift
//  todo
//
//  Created by Dave Stanton on 4/19/25.
//

import SwiftUI
import SwiftData

@main
struct todoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        
        // Configure for persistent storage
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            allowsSave: true
        )
        
        do {
            // Try to create the container with the new configuration
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("Failed to create persistent store: \(error)")
            
            // If persistent storage fails, fall back to in-memory storage
            let inMemoryConfig = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            return try! ModelContainer(for: schema, configurations: [inMemoryConfig])
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
