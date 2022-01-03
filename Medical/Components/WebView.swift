//
//  WedView.swift
//  Medical
//
//  Created by 于争光 on 2021/12/5.
//
import SwiftUI
import WebKit

struct WebViewRoot : UIViewRepresentable {
    let url: String
    let isLink: Bool
    
    func makeUIView(context: UIViewRepresentableContext<WebViewRoot>) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebViewRoot>) {
        if isLink {
            DispatchQueue.main.async {
                uiView.loadHTMLString(url, baseURL: nil)
            }
           
        }else{
            let request = URLRequest(url:URL(string: url)!)
            DispatchQueue.main.async {
                uiView.load(request)
            }
        }
        
    }
}
