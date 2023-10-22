//  HomeView.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var userInputText: String = ""
    @State private var isActive: Bool = false  // Variável de estado para controlar a NavigationLink

    var body: some View {
        NavigationView {
            ZStack {
                // Cor de fundo
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // Elemento de entrada de texto
                VStack {
                    Text("Escreva seu texto")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    TextEditor(text: $userInputText)
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    
                    Button(action: {
                        self.isActive = true  // Ative a NavigationLink
                    }) {
                        Text("Carregar para a próxima tela")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(10)
                    }
                }
                .padding()

                // NavigationLink oculto
                NavigationLink(destination: CancanTFMView(viewModel: CancaoTFMVIewModel(text: userInputText)), isActive: $isActive) {
                    EmptyView()
                }
            }
            .navigationTitle("Tela text")
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}


