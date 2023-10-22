//
//  ContentViewModel.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//


import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
  
  @Published var isLogged = Auth.auth().currentUser != nil
  
  func onAppear() {
    Auth.auth().addStateDidChangeListener { auth, user in
      self.isLogged = user != nil
    }
  }
  
}
