//
//  HomeViewModel.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation
import FirebaseAuth
import Combine

class HomeViewModel: ObservableObject{
    
    @Published var isTabBarHidden = false
    
    var userID = ""
    
    func user() -> String{
        if let user = Auth.auth().currentUser {
            userID = user.uid
            print("UserID:", userID)
        }
        return userID
    }
    
}
