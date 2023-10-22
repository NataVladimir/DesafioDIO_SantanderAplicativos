//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by Tiago Aguiar on 10/05/21.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
  public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(.horizontal, 8)
      .padding(.vertical, 16)
      .placeholderColor(Color.black)
      .background(Color.white)
      .foregroundColor(Color.black)
      .cornerRadius(24.0)
      .overlay(
        RoundedRectangle(cornerRadius: 24.0)
            .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
      )
  }
  
}
