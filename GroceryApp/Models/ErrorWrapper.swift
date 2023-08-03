//
//  ErrorWrapper.swift
//  GroceryApp
//
//  Created by bin li on 8/1/23.
//

import Foundation
struct ErrorWrapper: Identifiable {
  let id = UUID()
  let error: Error
  let guidance: String
}
