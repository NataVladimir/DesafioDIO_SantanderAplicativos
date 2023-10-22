//
//  SignInRepository.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//
//

import Foundation
import FirebaseAuth

class SignInRepository {
    
    func signIn(withEmail email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            guard let user = result?.user, err == nil else {
                print(err!)
                completion(err!.localizedDescription)
                return
            }
            print("usuario logado \(user.uid)")
            completion(nil)
        }
    }
}
