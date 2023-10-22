//
//  SignUpView.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//


import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel(repo: SignUpRepository())
    @State var isOk: Bool = false
    
    
    var body: some View {
        HStack{
            ScrollView(showsIndicators: false){
                VStack(alignment: .center) {
                    Image(systemName: "globe.americas.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                    
                        .padding(.bottom, 50)
                    
                    VStack {
                        
                        TextFieldfullName
                        
                        TextFieldEmial
                        
                        TextFieldPassword
                        
                        TextFieldPhone // TexField para digitar o numero de telefone.
                    
                        saveButton
                    }
                }
            }
        }
        
    }
}



// name - email - senha - telefone - cnpj
extension SignUpView{
    var TextFieldfullName: some View{
        EditTextView(text: $viewModel.name,
                     placeholder: "Nome",
                     keyboard: .alphabet,
                     error: "Nome deve ter mais de 3 caracteres",
                     failure: viewModel.name.count < 3,
                     autocapitalization: .words)
    }
}


extension SignUpView{
    var TextFieldEmial: some View{
        EditTextView(text: $viewModel.email,
                     placeholder: "Email",
                     keyboard: .emailAddress,
                     error: "Email invalido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView{
    var TextFieldPassword: some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     error: "Senha deve conter 6 ou mais numeros.",
                     failure: viewModel.password.count < 6,
                     isSecure: true)
    }
}

extension SignUpView{
    var TextFieldPhone: some View{
        EditTextView(text: $viewModel.phone,
                     placeholder: "Celular",
                     mask: "(##) ####-####",
                     keyboard: .numberPad,
                     error: "Numero neste formato (##) ####-####",
                     failure: viewModel.phone.count < 14 || viewModel.phone.count > 15
                     
        )
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
            isOk = true
        },
                          text: "Realize o seu Cadastro",
                          disabled: !viewModel.email.isEmail() ||
                          viewModel.password.count < 6 ||
                          viewModel.name.count < 3 ||
                          //adicionar aqui o validador do code SMS do firebase, deixando o usuario fazer o cadastro, somente apos o numero for confirmado.
                          
                          viewModel.phone.count < 14 || viewModel.phone.count > 15)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
