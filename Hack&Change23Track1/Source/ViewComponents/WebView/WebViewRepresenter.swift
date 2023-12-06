//
//  WebViewRepresenter.swift
//  TestApp1
//
//  Created by Bogdan Zykov on 06.12.2023.
//

import Foundation
import SwiftUI
import Combine
import WebKit

class WebViewModel: ObservableObject {
    
    @Published var isLoaderVisible: Bool = false
    @Published private(set) var videoId: String?
    
    
    func setVideoIdUrl(_ url: URL?) {
        
        guard let pathComponents = url?.pathComponents else { return }
        
        if pathComponents.contains("watch") {
            print("video id", url?.query())
            videoId = removeVParameter(from: url?.query())
        } else if pathComponents.contains("shorts") {
            print("shorts id", pathComponents.last)
            videoId = pathComponents.last
        }
    }
    
    private func removeVParameter(from string: String?) -> String? {
        guard let string else { return nil }
        if let range = string.range(of: "v=") {
            return string.replacingCharacters(in: range, with: "")
        }
        return string
    }
}

struct WebView: UIViewRepresentable {
    
    var url: String?
    
    @ObservedObject var viewModel: WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        
        let webView = WKWebView(frame: CGRect.zero)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.setAllMediaPlaybackSuspended(true)
        webView.scrollView.isScrollEnabled = true
       
        if let url, let requestUrl = URL(string: url) {
            webView.load(URLRequest(url: requestUrl))
        }
        return webView
    
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        var parent: WebView
        
        init(_ webView: WebView) {
            self.parent = webView
            
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            guard let key = change?[NSKeyValueChangeKey.newKey] as? URL else { return }
            self.parent.viewModel.setVideoIdUrl(key)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("didFinish")
            self.parent.viewModel.isLoaderVisible = false
            webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("didStartProvisionalNavigation")
            self.parent.viewModel.isLoaderVisible = true
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("didFailProvisionalNavigation")
            self.parent.viewModel.isLoaderVisible = false
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("didCommit")
            self.parent.viewModel.isLoaderVisible = true
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("didFail")
            self.parent.viewModel.isLoaderVisible = false
        }
    }
}

