//
//  ContentView.swift
//  todo
//
//  Created by Dave Stanton on 4/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var newItemTitle = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    HStack {
                        Button(action: {
                            withAnimation {
                                item.isCompleted.toggle()
                                try? modelContext.save()
                            }
                        }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isCompleted ? .green : .gray)
                                .accessibilityIdentifier(item.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                        .accessibilityIdentifier(item.isCompleted ? "checkmark.circle.fill" : "circle")
                        
                        NavigationLink(item.title) {
                            ItemDetailView(item: item)
                        }
                        .strikethrough(item.isCompleted)
                        .accessibilityIdentifier("todo-item-\(item.title)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .accessibilityIdentifier("edit-button")
                }
            }
            .navigationTitle("Todo List")
            .safeAreaInset(edge: .bottom) {
                HStack {
                    TextField("New Todo", text: $newItemTitle)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("new-todo-input")
                    
                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                    .accessibilityIdentifier("add-todo-button")
                    .disabled(newItemTitle.isEmpty)
                    .padding(.trailing)
                }
                .padding(.vertical, 8)
                .background(.bar)
            }
        } detail: {
            Text("Select a todo item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(title: newItemTitle)
            modelContext.insert(newItem)
            try? modelContext.save()
            newItemTitle = ""
            isTextFieldFocused = false
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
            try? modelContext.save()
        }
    }
}

struct ItemDetailView: View {
    @Bindable var item: Item
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
            TextField("Title", text: $item.title)
                .onChange(of: item.title) { _, _ in
                    try? modelContext.save()
                }
            Toggle("Completed", isOn: $item.isCompleted)
                .onChange(of: item.isCompleted) { _, _ in
                    try? modelContext.save()
                }
        }
        .navigationTitle("Edit Todo")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
