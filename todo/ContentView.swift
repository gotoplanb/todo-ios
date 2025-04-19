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
            ScrollView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            HStack {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                                    .onTapGesture {
                                        withAnimation {
                                            item.isCompleted.toggle()
                                        }
                                    }
                                Text(item.title)
                                    .strikethrough(item.isCompleted)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .navigationTitle("Todo List")
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
        } detail: {
            Text("Select a todo item")
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("New todo", text: $newItemTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .focused($isTextFieldFocused)
                
                Button(action: addItem) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .disabled(newItemTitle.isEmpty)
                .padding(.trailing)
            }
            .padding(.vertical, 8)
            .background(.bar)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(title: newItemTitle)
            modelContext.insert(newItem)
            newItemTitle = ""
            isTextFieldFocused = false
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

struct ItemDetailView: View {
    @Bindable var item: Item
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
            TextField("Title", text: $item.title)
            Toggle("Completed", isOn: $item.isCompleted)
        }
        .navigationTitle("Edit Todo")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
