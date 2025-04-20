import XCTest
@testable import todo

@MainActor
final class todoTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    
    override func setUp() async throws {
        try await super.setUp()
        
        // Create a persistent store for testing
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        modelContainer = try ModelContainer(for: Item.self, configurations: config)
        modelContext = modelContainer.mainContext
    }
    
    override func tearDown() async throws {
        modelContainer = nil
        modelContext = nil
        try await super.tearDown()
    }
    
    func testAddItem() async throws {
        // Create a new item
        let newItem = Item(timestamp: Date())
        
        // Add it to the context
        modelContext.insert(newItem)
        
        // Save the context
        try modelContext.save()
        
        // Fetch all items
        let fetchDescriptor = FetchDescriptor<Item>()
        let items = try modelContext.fetch(fetchDescriptor)
        
        // Verify the item was added
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.timestamp, newItem.timestamp)
    }
    
    func testDeleteItem() async throws {
        // Create and add an item
        let item = Item(timestamp: Date())
        modelContext.insert(item)
        try modelContext.save()
        
        // Delete the item
        modelContext.delete(item)
        try modelContext.save()
        
        // Fetch all items
        let fetchDescriptor = FetchDescriptor<Item>()
        let items = try modelContext.fetch(fetchDescriptor)
        
        // Verify the item was deleted
        XCTAssertEqual(items.count, 0)
    }
} 