//
//  WebViewController.swift
//  NewsHub
//
//  Created by Kirill on 09.12.2023.
//

import UIKit
import WebKit



// MARK: - WebSceneViewController
final class WebSceneViewController: UIViewController {
    
    // MARK: Инициализаторы
    init(stringURL: String) {
        super.init(nibName: nil, bundle: nil)
        self.load(stringURL: stringURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        self.view = WebSceneView(frame: .zero, target: self)
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        
        webSceneView.setWebViewDelegate(delegate: self)
        
        guard let webViewToolBar = webSceneView.toolBar as? WebViewToolBar else {
            return
        }
        
        webViewToolBar.addActionToBackButtonItem(selector: #selector(self.goBack))
        webViewToolBar.addActionToForwardButtonItem(selector: #selector(self.goForward))
        webViewToolBar.addActionToOpenSafariButtonItem(selector: #selector(self.openSafari))
        webViewToolBar.addactionToCloseWebViewButtonItem(selector: #selector(self.closeWebView))
        webViewToolBar.addActionToUpdateButtonItem(selector: #selector(self.updateScene))
        
    }
    
}



// MARK: - Обработчики взаимодействия с панелью инструментов
extension WebSceneViewController {
    
    // MARK: Обработчик нажатия на кнопку "Назад"
    @objc private func goBack() -> Void {
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        if webSceneView.webView.canGoBack {
            webSceneView.webView.goBack()
        }
    }
    
    // MARK: Обработчик нажатия на кнопку "Вперёд"
    @objc private func goForward() -> Void {
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        if webSceneView.webView.canGoForward {
            webSceneView.webView.goForward()
        }
    }
    
    // MARK: Обработчик нажатия на кнопку "Открыть в сафари"
    @objc private func openSafari() -> Void {
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        if let url = webSceneView.webView.url {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: Обработчик нажатия на кнопку "Закрыть"
    @objc private func closeWebView() -> Void {
        self.dismiss(animated: true)
    }
    
    // MARK: Обработчик нажатия на кнопку "Обновить страницу"
    @objc private func updateScene() -> Void {
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        webSceneView.webView.reload()
    }
    
}



// MARK: - Интерфейс
extension WebSceneViewController {
    
    // MARK: Загрузка страницы по URL
    func load(stringURL: String) -> Void {
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        webSceneView.load(urlString: stringURL)
    }
    
}



// MARK: - WKNavigationDelegate
extension WebSceneViewController: WKNavigationDelegate {
    
    // MARK: didFinish
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let webSceneView = self.view as? WebSceneView else {
            return
        }
        guard let webViewToolBar = webSceneView.toolBar as? WebViewToolBar else {
            return
        }
        
        if webSceneView.webView.canGoBack {
            webViewToolBar.backButtonItem.isEnabled = true
        } else {
            webViewToolBar.backButtonItem.isEnabled = false
        }
        if webSceneView.webView.canGoForward {
            webViewToolBar.forwardButtonItem.isEnabled = true
        } else {
            webViewToolBar.forwardButtonItem.isEnabled = false
        }
    }
    
}
