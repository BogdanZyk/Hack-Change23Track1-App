//
//  ShareSheet.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct ShareSheet: View {
    let code: String
    @State private var isTap: Bool = false
    var body: some View {
        VStack(spacing: 24) {
            Text("QR-code room")
                .font(.large())
            Image("qrcode")
                .resizable()
                .frame(width: 160, height: 160)
                .cornerRadius(12)
            Text(code)
                .font(.primary())
                .padding()
                .hCenter()
                .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay {
                    if isTap {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.primaryPink)
                    }
                }
                .onTapGesture {
                    UIPasteboard.general.string = code
                    isTap = true
                }
            HStack {
                ForEach(Links.allCases, id: \.self) { link in
                    Button {
                        
                    } label: {
                        VStack {
                            Image(link.rawValue)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(link.title)
                                .font(.small(weight: .semibold))
                        }
                    }
                    .hCenter()
                }
            }
        }
        .allFrame()
        .padding(.top, 8)
        .padding()
        .background(Color.primaryBg.ignoresSafeArea())
        .foregroundColor(.primaryFont)
    }
    
    enum Links: String, CaseIterable {
        case tg, vk, wb, fb
        
        var title: String {
            switch self {
            case .tg:
                return "Telegram"
            case .vk:
                return "VK"
            case .wb:
                return "WhatsApp"
            case .fb:
                return "Facebook"
            }
        }
    }
}

struct ShareSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheet(code: "123456ABC")
    }
}
