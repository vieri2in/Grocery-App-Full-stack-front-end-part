//
//  AddGroceryCategoryScreen.swift
//  GroceryApp
//
//  Created by bin li on 7/29/23.
//

import SwiftUI
import GroceryAppSharedDTO
struct AddGroceryCategoryScreen: View {
  @EnvironmentObject private var model: GroceryModel
  @State private var title: String = ""
  @State private var colorCode: String = ""
  @Environment(\.dismiss) private var dismiss
  private var isFormValid: Bool {
    !title.isEmptyOrWhiteSpace && !colorCode.isEmpty
  }
  private func saveGroceryCategory() async {
    let groceryCategoryRequestDTO = GroceryCategoryRequestDTO(title: title, colorCode: colorCode)
    do {
      try await model.saveGroceryCategory(groceryCategoryRequestDTO)
      dismiss()
    } catch {
      print(error.localizedDescription)
    }
  }
  var body: some View {
    Form {
      TextField("Title", text: $title)
      ColorSelector(colorCode: $colorCode)
    }
    .navigationTitle("New Category")
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button("Close") {
          dismiss()
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Save") {
          Task {
            await saveGroceryCategory()
          }
        }.disabled(!isFormValid)
      }
    }
  }
}

#Preview {
  NavigationStack {
    AddGroceryCategoryScreen()
      .environmentObject(GroceryModel())
  }
}
