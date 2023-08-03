//
//  GroceryItemResponseDTO.swift
//  GroceryApp
//
//  Created by bin li on 8/1/23.
//

import Foundation
import GroceryAppSharedDTO
extension GroceryItemResponseDTO: Identifiable, Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  public static func == (lhs: GroceryItemResponseDTO, rhs: GroceryItemResponseDTO) -> Bool {
    return lhs.id == rhs.id
  }
}
