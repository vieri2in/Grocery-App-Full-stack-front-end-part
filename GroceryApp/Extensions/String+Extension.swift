//
//  File.swift
//  GroceryApp
//
//  Created by bin li on 7/27/23.
//

import Foundation
extension String {
  var isEmptyOrWhiteSpace: Bool {
    self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}
