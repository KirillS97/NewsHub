//
//  WebView.swift
//  NewsHub
//
//  Created by Kirill on 09.12.2023.
//

import UIKit
import WebKit



// MARK: - WebView
final class WebSceneView: UIView {
    
    // MARK: Свойства объектов класса
    private (set) var webView: WKWebView!
    private (set) var toolBar: UIToolbar!
    
    // MARK: Инициализаторы
    init(frame: CGRect, target: Any) {
        super.init(frame: frame)
        self.setUpWebSceneView(target: target)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Компоновка UI
extension WebSceneView {
    
    private func setUpWebSceneView(target: Any) -> Void {
        self.setUpWebView()
        self.setUpToolBar(target: target)
    }
    
    private func setUpWebView() -> Void {
        self.webView = WKWebView()
        self.addSubview(self.webView)
        self.addConstraintsToWebView()
    }
    
    private func addConstraintsToWebView() -> Void {
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func setUpToolBar(target: Any) -> Void {
        self.toolBar = WebViewToolBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100), target: target)
        self.addSubview(self.toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.toolBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.toolBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.toolBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}



// MARK: - Интерфейс
extension WebSceneView {
    
    // MARK: загрузка страницы по URL
    func load(urlString: String) -> Void {
        let url = URL(string: urlString)
        if let url {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
        }
    }
    
    // MARK: установка делегата для webView
    func setWebViewDelegate(delegate: WKNavigationDelegate) -> Void {
        self.webView.navigationDelegate = delegate
    }
    
}
