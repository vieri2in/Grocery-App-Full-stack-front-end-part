//
//  LoginScreen.swift
//  GroceryApp
//
//  Created by bin li on 7/27/23.
//

import SwiftUI

struct LoginScreen: View {
  @EnvironmentObject private var model: GroceryModel
  @EnvironmentObject private var appState: AppState
  @State private var username = ""
  @State private var password = ""
  @State private var errorMessage = ""
  private var isValid: Bool {
    !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace &&
    password.count >= 6 &&
    password.count <= 10
  }
  private func login() async {
    do {
      let loginResponseDTO = try await model.login(username: username, password: password)
      if !loginResponseDTO.error {
        // take the user to the login screen
        appState.routes.append(.groceryCategoryList)
      } else {
        appState.errorWrapper = ErrorWrapper(error: GroceryError.login, guidance: loginResponseDTO.reason ?? "")
      }
    } catch {
      appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
    }
  }
  var body: some View {
    Form {
      TextField("Username", text: $username)
        .textInputAutocapitalization(.never)
      SecureField("Password", text: $password)
      HStack {
        Button("Login") {
          Task {
            await login()
          }
        }.buttonStyle(.borderless)
          .disabled(!isValid)
        Spacer()
        Button("Register") {
          appState.routes.append(.register)
        }.buttonStyle(.borderless)
      }
//      Text(errorMessage)
    }
    .navigationTitle("Login")
    .navigationBarBackButtonHidden(true)
    .sheet(item: $appState.errorWrapper) { errorWrapper in
      ErrorView(errorWrapper: errorWrapper)
        .presentationDetents([.fraction(0.25)])
    }
  }
}


#Preview {
  NavigationStack {
    LoginScreen()
      .environmentObject(GroceryModel())
  }
}
