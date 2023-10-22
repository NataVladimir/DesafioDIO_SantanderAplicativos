import SwiftUI

// Extensão para modificar a cor do placeholder
extension View {
    func placeholderColor(_ color: Color, alpha: Double = 1.0) -> some View {
        self.modifier(PlaceholderColorModifier(color: color, alpha: alpha))
    }
}

private struct PlaceholderColorModifier: ViewModifier {
    var color: Color
    var alpha: Double

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        if geometry.size.width == 0 {
                            Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                        }
                    }
                }
            )
            .onPreferenceChange(WidthPreferenceKey.self) { width in
                if width == 0 {
                    UITextField.appearance().setPlaceholderTextColor(UIColor(color).withAlphaComponent(CGFloat(alpha)))
                }
            }
    }
}

private struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

extension UITextField {
    func setPlaceholderTextColor(_ color: UIColor) {
        let placeholderText = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

// Seu código original
struct EditTextView: View {
  
    @Binding var text: String
  
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none
  
    var body: some View {
            VStack {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(Color.black)
                        .keyboardType(keyboard)
                        .textFieldStyle(CustomTextFieldStyle())
                        .placeholderColor(.black, alpha: 1.3) // Adicione esta linha
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(Color.black)
                        .keyboardType(keyboard)
                        .autocapitalization(autocapitalization)
                        .textFieldStyle(CustomTextFieldStyle())
                        .onChange(of: text) { value in
                            if let mask = mask {
                                Mask.mask(mask: mask, value: value, text: &text)
                            }
                        }
                        .placeholderColor(.black, alpha: 1.0)
                }
          
                if let error = error, failure == true, !text.isEmpty {
                    Text(error).foregroundColor(.red)
                }
            }
            .padding(.bottom, 10)
        }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                EditTextView(text: .constant(""),
                             placeholder: "E-mail",
                             error: "Campo inválido",
                             failure: "a@a.com".count < 3)
                
                EditTextView(text: .constant("Text"), 
                             placeholder: "",
                             isSecure: false)
            
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme($0)
        }
    }
}
