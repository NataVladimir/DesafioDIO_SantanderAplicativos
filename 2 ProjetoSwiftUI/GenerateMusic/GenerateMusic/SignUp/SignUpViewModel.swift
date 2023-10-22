//
//  SignUpViewModel.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation
import FirebaseAuth
import Firebase

class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    @Published var code = ""
    
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    private let repo: SignUpRepository
    
    init(repo: SignUpRepository) {
        self.repo = repo
    }
    
    func signUp() {
        print("nome: \(name), email: \(email), senha: \(password)")
        
        if name.isEmpty == true {
            formInvalid = true
            alertText = "Erro nos dados"
            return
        }
        
        isLoading = true
        
        repo.signUp(withEmail: email, password: password, name: name, phone: phone) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
                print(err)
            }
            self.isLoading = false
        }
    }
}




