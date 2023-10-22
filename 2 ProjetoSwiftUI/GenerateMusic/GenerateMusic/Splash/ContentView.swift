//
//  ContentView.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var viewModel = ContentViewModel()
  var body: some View {
    ZStack {
      if viewModel.isLogged {
          HomeView(viewModel: HomeViewModel())
      } else {
          SignInView()
      }
    }.onAppear {
      viewModel.onAppear()
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
