//
//  ContentView.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//


import Foundation
import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel(repo: SignInRepository())
    @State var isOk: Bool = false
    
    var body: some View {
        NavigationView {
            HStack{
                ScrollView(showsIndicators: false){
                    VStack {
                       
                        Image(systemName: "globe.americas.fill")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(height: 200)
                        
                        TextFieldEmail
                        TextFieldPassword
                        entrarButton
                        
                        Divider()
                        
                        
                        NavigationLink(
                            destination: SignUpView()) {
                                Text("Não tem uma conta? Clique aqui")
                                    .foregroundColor(Color.white)
                            }
                            .padding(.vertical, 5)
                        NavigationLink(
                            destination:  SignUpView()){
                                Text("Resgatar senha")
                                    .foregroundColor(Color.red)
                            }
                        
                    }
                }.resignKeyboardOnDragGesture()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 32)
                .background(Color("ColorBack"))
                .navigationTitle("Login")
                .navigationBarHidden(true)
                .preferredColorScheme(.light)
            }
        }
    }
}

extension SignInView{
    var TextFieldEmail: some View{
        ZStack{
            EditTextView(text: $viewModel.email,
                         placeholder: "Email",
                         keyboard: .emailAddress,
                         failure: !viewModel.email.isEmail())
        }
    }
}

extension SignInView{
    var TextFieldPassword: some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     failure: viewModel.password.count < 6).placeholderColor(Color.black)
    }
}

extension SignInView {
    var entrarButton: some View {
        LoadingButtonView(action: {
            
            viewModel.signIn()
        },
                          text: "Entrar",
                          disabled: !viewModel.email.isEmail() ||
                          viewModel.password.count < 6)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


