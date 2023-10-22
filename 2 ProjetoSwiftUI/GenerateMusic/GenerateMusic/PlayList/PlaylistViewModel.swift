//
//  PlaylistViewModel.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation
import FirebaseFirestore

class SavedSongsViewModel: ObservableObject {
    @Published var songs: [SavedSong] = []
    
    init() {
        fetchSavedSongs()
    }
    
    func fetchSavedSongs() {
        Firestore.firestore().collection("audios").getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No songs found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.songs = documents.compactMap { document -> SavedSong? in
                guard let name = document.data()["name"] as? String,
                      let text = document.data()["text"] as? String,
                      let downloadURLString = document.data()["downloadURL"] as? String,
                      let downloadURL = URL(string: downloadURLString) else {
                    return nil
                }
                
                return SavedSong(id: document.documentID, name: name, text: text, downloadURL: downloadURL)
            }
        }
    }
}
