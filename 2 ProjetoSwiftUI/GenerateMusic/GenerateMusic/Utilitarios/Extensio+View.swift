//
//  Extensio+View.swift
//  Encore BR
//
//  Created by test on 03/10/23.
//

import Foundation
import SwiftUI

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
