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
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let title {
                Text(title)
                    .font(.large())
            }
            TextField(text: $text) {
                Text(label)
                    .foregroundColor(.black.opacity(0.4))
            }
            .font(.primary())
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 16))
        }
        .foregroundColor(.primaryFont)
    }
}

struct PrimaryTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryTextField(text: .constant(""), label: "Label")
            PrimaryTextField(text: .constant(""), label: "Label", title: "Title")
        }
        .padding()
    }
}
