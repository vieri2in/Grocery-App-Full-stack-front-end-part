//
//  GroceryItemListView.swift
//  GroceryApp
//
//  Created by bin li on 8/1/23.
//

import SwiftUI
import GroceryAppSharedDTO
struct GroceryItemListView: View {
  let groceryItems: [GroceryItemResponseDTO]
  let onDelete: (UUID) -> Void
  private func deleteGroceryItem(at offsets: IndexSet) {
    offsets.forEach { index in
      let groceryItem = groceryItems[index]
      onDelete(groceryItem.id)
    }
  }
    var body: some View {
      List {
        ForEach(groceryItems) { groceryItem in
          Text(groceryItem.title)
        }
        .onDelete(perform: deleteGroceryItem)
      }
    }
}

#Preview {
  GroceryItemListView(groceryItems: [
    GroceryItemResponseDTO(id: UUID(), title: "meat", price: 12.99, quantity: 12),
    GroceryItemResponseDTO(id: UUID(), title: "milk", price: 3.99, quantity: 4)], onDelete: { _ in }
  )
}
