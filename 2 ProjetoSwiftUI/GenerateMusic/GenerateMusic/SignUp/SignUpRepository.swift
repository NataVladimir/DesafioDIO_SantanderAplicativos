//
//  SignUpRepository.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpRepository {
    
    func signUp(withEmail email: String,
                 password: String,
                 name: String,
                 phone: String,
                 completion: @escaping (String?) -> Void) {
         
         Auth.auth().createUser(withEmail: email, password: password) { result, err in
             guard let user = result?.user, err == nil else {
                 completion(err!.localizedDescription)
                 return
             }
             
             self.createUser(withEmail: email, name: name, phone: phone) { success, error in
                 if success {
                     completion(nil)
                 } else {
                     completion(error)
                 }}}}

    private func createUser(withEmail: String, name: String, phone: String, completion: @escaping (Bool, String?) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(false, "Erro ao acessar usuário autenticado.")
            return
        }
        
        Firestore.firestore().collection("users")
            .document(id)
            .setData([
                "email" : withEmail,
                "name": name,
                "uuid": id,
                "phone": phone,
            ]) { err in
                if let err = err {
                    print(err.localizedDescription)
                    completion(false, err.localizedDescription)
                } else {
                    completion(true, nil)
                }
            }}}
