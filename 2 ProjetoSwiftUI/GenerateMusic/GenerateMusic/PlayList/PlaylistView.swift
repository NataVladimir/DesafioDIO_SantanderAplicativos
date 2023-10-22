//
//  PlaylistView.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import Foundation
import SwiftUI

struct SavedSongsView: View {
    @ObservedObject var viewModel: SavedSongsViewModel

    var body: some View {
        NavigationView {
            List(viewModel.songs) { song in
                NavigationLink(destination: CancanTFMView(viewModel: CancaoTFMVIewModel(text: song.text))) {
                    Text(song.name)
                }
            }
            .navigationTitle("Músicas Salvas")
        }
    }
}
