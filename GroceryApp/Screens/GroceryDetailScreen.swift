//
//  GroceryDetailScreen.swift
//  GroceryApp
//
//  Created by bin li on 7/31/23.
//

import SwiftUI
import GroceryAppSharedDTO
struct GroceryDetailScreen: View {
  @State private var isPresented: Bool = false
  let groceryCategory: GroceryCategoryResponseDTO
  @EnvironmentObject private var model: GroceryModel
  private func populateGroceryItems() async {
    do {
      try await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
    } catch {
      print(error.localizedDescription)
    }
  }
  private func deleteGroceryItem(groceryItemId: UUID) {
    Task {
      do {
        let _ = try await model.deleteGroceryItem(groceryCategoryId: groceryCategory.id, groceryItemId: groceryItemId)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  var body: some View {
    VStack {
      if model.groceryItems.isEmpty {
        Text("No grocery items found.")
      } else {
        GroceryItemListView(groceryItems: model.groceryItems, onDelete: deleteGroceryItem)
      }
    }
    .navigationTitle(groceryCategory.title)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Add Grocery Item") {
          isPresented = true
        }
      }
    }
    .sheet(isPresented: $isPresented) {
      NavigationStack {
        AddGroceryItemScreen()
      }
    }
    .onAppear {
      model.groceryCategory = groceryCategory
    }
    .task {
      await populateGroceryItems()
    }
  }
}

#Preview {
  NavigationStack {
    GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(uuidString: "d3601325-067f-4fdf-ad80-4730e24c372c")!, title: "Nuts", colorCode: "#3498db"))
      .environmentObject(GroceryModel())
  }
}
