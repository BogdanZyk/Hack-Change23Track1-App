//
//  AppAlert.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

enum AppAlert {
    case basic(title: String, message: String, action: (() -> Void)? = nil)
    case errors(errors: [Error], action: (() -> Void)? = nil)
    
    var title: String {
        switch self {
        case .basic(let title, _, _): return title
        case .errors: return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .basic(_, let message, _):
            return message
        case .errors(let errors, _):
            let message = errors.map { $0.localizedDescription }.joined(separator: "\n")
            return makeValidMessage(message)
        }
    }
    
    var action: (() -> Void)? {
        switch self {
        case .basic(_, _, let action):
            return action
        case .errors(_, let action):
            return action
        }
    }
    
    private func makeValidMessage(_ message: String) -> String {
        let prefixMessage = message.prefix(50)
        if prefixMessage.contains("500 error") {
            return "500 - Internal Server Error"
        } else if prefixMessage.contains("404 error") {
            return "404 - Not found"
        } else if prefixMessage.contains("502 error") {
            return "502 - Bad Gateway"
        } else {
            return String(message.prefix(300))
        }
    }
}

extension View {
    
    func appAlert(_ appAlert: Binding<AppAlert?>) -> some View {
        let alertType = appAlert.wrappedValue
        return alert(Text(alertType?.title ?? ""), isPresented: .constant(alertType != nil)) {
            Button("OK") {
                if let action = appAlert.wrappedValue?.action {
                    action()
                }
                appAlert.wrappedValue = nil
            }
        } message: {
            Text(alertType?.message ?? "Unknown error")
        }
    }
}
