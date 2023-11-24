//
//  PrimaryButton.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct PrimaryButton: View {
    let label: String
    var isDisabled: Bool = false
    var isLoading: Bool = false
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            
 
            Text(label)
                .opacity(isLoading ? 0 : 1)
                .font(.primary(weight: .medium))
                .foregroundColor(.white)
                .frame(height: 50)
                .hCenter()
                .background(Color.primaryPink, in: Capsule())
                .opacity(isDisabled ? 0.5 : 1)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(1.2)
                            .tint(.white)
                    }
                }
        }
        .disabled(isDisabled || isLoading)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryButton(label: "Save", action: {})
            PrimaryButton(label: "Save", isDisabled: true, action: {})
            PrimaryButton(label: "Save", isLoading: true, action: {})
        }
       
            .padding()
    }
}
