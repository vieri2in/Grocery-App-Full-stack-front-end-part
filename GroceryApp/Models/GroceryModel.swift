//
//  GroceryModel.swift
//  GroceryApp
//
//  Created by bin li on 7/27/23.
//

import Foundation
import GroceryAppSharedDTO
class GroceryModel: ObservableObject {
  @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
  @Published var groceryCategory: GroceryCategoryResponseDTO?
  @Published var groceryItems: [GroceryItemResponseDTO] = []
  let httpClient = HTTPClient()
  func register(username: String, password: String) async throws -> RegisterResponseDTO {
    let registerData = ["username": username, "password": password]
    let resoure = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
    
    let registerResponseDTO = try await httpClient.load(resoure)
    return registerResponseDTO
  }
  func login(username: String, password: String) async throws -> LoginResponseDTO {
    let loginPostData = ["username": username, "password": password]
    let resoure = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: LoginResponseDTO.self)
    
    let loginResponseDTO = try await httpClient.load(resoure)
    if !loginResponseDTO.error
        && loginResponseDTO.token != nil
        && loginResponseDTO.userId != nil {
      let defaults = UserDefaults.standard
      defaults.set(loginResponseDTO.token, forKey: "authToken")
      defaults.set(loginResponseDTO.userId!.uuidString, forKey: "userId")
    }
    return loginResponseDTO
  }
  func logout() {
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: "userId")
    defaults.removeObject(forKey: "authToken")
  }
  func populateGroceryCategories() async throws {
    guard let userId = UserDefaults.standard.userId else {
      return
    }
    let resourse = Resource(
      url: Constants.Urls.groceryCategoryBy(userId: userId),
      modelType: [GroceryCategoryResponseDTO].self)
    let result = try await httpClient.load(resourse)
    DispatchQueue.main.async {
      self.groceryCategories = result
    }
  }
  func populateGroceryItemsBy(groceryCategoryId: UUID) async throws {
    guard let userId = UserDefaults.standard.userId else {
      return
    }
    let resource = Resource(url: Constants.Urls.groceryItemBy(userId: userId, groceryCategoryId: groceryCategoryId),
                            modelType: [GroceryItemResponseDTO].self)
    let result = try await httpClient.load(resource)
    DispatchQueue.main.async {
      self.groceryItems = result
    }
  }
  func deleteGroceryCategory(groceryCategoryId: UUID) async throws -> String {
    guard let userId = UserDefaults.standard.userId else {
      return "BAD"
    }
    let resource = Resource(
      url: Constants.Urls.deleteGroceryCategory(userId: userId, groceryCategoryId: groceryCategoryId),
      method: .delete,
      modelType: GroceryCategoryResponseDTO.self)
    let deletedGroceryCategory = try await httpClient.load(resource)
    let result = groceryCategories.filter {$0.id != deletedGroceryCategory.id}
    DispatchQueue.main.async {
      self.groceryCategories = result
    }
    return "OK"
  }
  func deleteGroceryItem(groceryCategoryId: UUID, groceryItemId: UUID) async throws -> String {
    guard let userId = UserDefaults.standard.userId else {
      return "BAD"
    }
    let resource = Resource(
      url: Constants.Urls.deleteGroceryItem(userId: userId, groceryCategoryId: groceryCategoryId, groceryItemId: groceryItemId),
      method: .delete,
      modelType: GroceryItemResponseDTO.self)
    let deletedGroceryItem = try await httpClient.load(resource)
    let result = groceryItems.filter {$0.id != deletedGroceryItem.id}
    DispatchQueue.main.async {
      self.groceryItems = result
    }
    return "OK"
  }
  func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
    guard let userId = UserDefaults.standard.userId else {
      return
    }
    let resourse = try Resource(
      url: Constants.Urls.saveGroceryCategoryBy(userId: userId),
      method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)),
      modelType: GroceryCategoryResponseDTO.self)
    let newGroceryCategory = try await httpClient.load(resourse)
    // add new grocery category into the list
    DispatchQueue.main.async {
      self.groceryCategories.append(newGroceryCategory)
    }
  }
  func saveGroceryItem(_ groceryItemRequestDTO: GroceryItemRequestDTO, groceryCategoryId: UUID) async throws {
    guard let userId = UserDefaults.standard.userId else {
      return
    }
    let resource = try Resource(
      url: Constants.Urls.saveGroceryItem(userId: userId, groceryCategoryId: groceryCategoryId),
      method: .post(JSONEncoder().encode(groceryItemRequestDTO)),
      modelType: GroceryItemResponseDTO.self)
    let newGroceryItem = try await httpClient.load(resource)
    DispatchQueue.main.async {
      self.groceryItems.append(newGroceryItem)
    }
  }
}
