//
//  PrimaryTextField.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct PrimaryTextField: View {
    @Binding var text: String
    var label: String
    var title: String?
    var isSecure: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let title {
                Text(title)
                    .font(.large())
            }
            Group {
                if isSecure {
                    SecureField(text: $text) {
                        labelView
                    }
                } else {
                    TextField(text: $text) {
                        labelView
                    }
                }
            }
            .font(.primary())
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 16))
        }
        .foregroundColor(.primaryFont)
    }
    
   private var labelView: some View {
        Text(label)
            .foregroundColor(.secondaryGray)
    }
}

struct PrimaryTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryTextField(text: .constant(""), label: "Label")
            PrimaryTextField(text: .constant(""), label: "Label", title: "Title")
            PrimaryTextField(text: .constant(""), label: "Label", title: "Title", isSecure: true)
        }
        .padding()
    }
}
