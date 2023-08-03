//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by bin li on 7/30/23.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
  @EnvironmentObject private var model: GroceryModel
  @EnvironmentObject private var appState: AppState
  @State private var isPresented: Bool = false
  private func fetchGroceryCategories() async {
    do {
      try await model.populateGroceryCategories()
    } catch {
      print(error.localizedDescription)
    }
  }
  private func deleteGroceryCategory(at offsets: IndexSet) {
    offsets.forEach { index in
      let groceryCategory = model.groceryCategories[index]
      Task {
        do {
          let _ = try await model.deleteGroceryCategory(groceryCategoryId: groceryCategory.id)
        } catch {
          print(error.localizedDescription)
        }
      }
    }
  }
  var body: some View {
    List {
      if model.groceryCategories.isEmpty {
        Text("No grocery categories found.")
      } 
      ForEach(model.groceryCategories) { groceryCategory in
        NavigationLink(value: Route.groceryCategoryDetail(groceryCategory)) {
          HStack {
            Circle()
              .fill(Color.fromHex(groceryCategory.colorCode))
              .frame(width: 25, height: 25)
            Text(groceryCategory.title)
          }
        }
      }
      .onDelete(perform: deleteGroceryCategory)
    }.task {
      await fetchGroceryCategories()
    }
    .navigationTitle("Categories")
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button("Logout") {
          model.logout()
          appState.routes.append(.login)
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          isPresented = true
        } label: {
          Image(systemName: "plus")
        }
      }
    }
    .sheet(isPresented: $isPresented) {
      NavigationStack {
        AddGroceryCategoryScreen()
      }
    }
  }
}

#Preview {
  NavigationStack {
    GroceryCategoryListScreen()
      .environmentObject(GroceryModel())
  }
}
