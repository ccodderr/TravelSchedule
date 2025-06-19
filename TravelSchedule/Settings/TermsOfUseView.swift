//
//  TermsOfUseView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI
import WebKit

struct TermsOfUseView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer/")!)
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
            }
    }
}

private struct WebView: UIViewRepresentable {
    let url: URL
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    func makeCoordinator() -> Coordinator {
        Coordinator(colorScheme: colorScheme)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        let darkModeCSS = """
                :root {
                    color-scheme: light dark;
                    --bg-color: #121212;
                    --text-color: #E0E0E0;
                    }
                body {
                    background-color: var(--bg-color) !important;
                    color: var(--text-color) !important;
                    }
                * {
                    background-color: inherit !important;
                    color: inherit !important;
                    }
                """
        
        let colorModeCSS = darkModeCSS
        
        let script = """
                var style = document.createElement('style');
                style.innerHTML = `\(colorModeCSS)`;
                document.head.appendChild(style);
                """
        
        let userScript = WKUserScript(
            source: script,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: false
        )
        
        if isDarkMode {
            webView.configuration.userContentController.addUserScript(userScript)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        var colorScheme: ColorScheme
        
        init(colorScheme: ColorScheme) {
            self.colorScheme = colorScheme
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
        }
    }
}

struct TermsOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TermsOfUseView()
        }
    }
}
