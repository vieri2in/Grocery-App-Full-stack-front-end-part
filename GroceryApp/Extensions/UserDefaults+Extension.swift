//
//  UserDefaults+Extension.swift
//  GroceryApp
//
//  Created by bin li on 7/29/23.
//

import Foundation
extension UserDefaults {
  var userId: UUID? {
    get {
      guard let userIdString = string(forKey: "userId") else {
        return nil
      }
      return UUID(uuidString: userIdString)
    }
    set {
      set(newValue?.uuidString, forKey: "userId")
    }
  }
}
