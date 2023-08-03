//
//  ErrorView.swift
//  GroceryApp
//
//  Created by bin li on 8/1/23.
//

import SwiftUI

struct ErrorView: View {
  let errorWrapper: ErrorWrapper
  var body: some View {
    VStack {
      Text("Error has occured in the app.")
        .font(.headline)
        .padding(.bottom, 10)
      Text(errorWrapper.error.localizedDescription)
      Text(errorWrapper.guidance)
        .font(.caption)
    }.padding()
  }
}
