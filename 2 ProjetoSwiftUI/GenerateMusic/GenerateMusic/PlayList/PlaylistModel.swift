//
//  PlaylistModel.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation

struct SavedSong: Identifiable {
    var id: String
    var name: String
    var text: String
    var downloadURL: URL
}
