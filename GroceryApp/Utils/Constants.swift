//
//  Constants.swift
//  GroceryApp
//
//  Created by bin li on 7/27/23.
//

import Foundation
struct Constants {
  static let baseUrlPath = "http://127.0.0.1:8080/api"
  struct Urls {
    static let register = URL(string: "\(baseUrlPath)/register")!
    static let login = URL(string: "\(baseUrlPath)/login")!
    static func saveGroceryCategoryBy(userId: UUID) -> URL {
      return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories")!
    }
    static func groceryCategoryBy(userId: UUID) -> URL {
      return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories")!
    }
    static func deleteGroceryCategory(userId: UUID, groceryCategoryId: UUID) -> URL {
      return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)")!
    }
    static func saveGroceryItem(userId: UUID, groceryCategoryId: UUID) -> URL {
      return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
    }
    static func groceryItemBy(userId: UUID, groceryCategoryId: UUID) -> URL {
      return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
    }
    static func deleteGroceryItem(userId: UUID, groceryCategoryId: UUID, groceryItemId: UUID) -> URL {
      return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items/\(groceryItemId)")!
    }
  }
}
