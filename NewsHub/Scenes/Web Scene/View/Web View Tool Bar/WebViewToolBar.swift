//
//  WebViewToolBar.swift
//  NewsHub
//
//  Created by Kirill on 11.12.2023.
//

import UIKit



// MARK: - WebViewToolBar
final class WebViewToolBar: UIToolbar {
    
    // MARK: Свойства объектов класса
    private (set) var backButtonItem   : UIBarButtonItem!
    private (set) var forwardButtonItem: UIBarButtonItem!
    private var updateButtonItem       : UIBarButtonItem!
    private var openSafariButtonItem   : UIBarButtonItem!
    private var closeWebViewButtonItem : UIBarButtonItem!
    private var fixedSpaceButtonItem   : UIBarButtonItem!
    private var flexibleSpaceButtonItem: UIBarButtonItem!
    
    // MARK: Инициализаторы
    init(frame: CGRect, target: Any) {
        super.init(frame: frame)
        self.setUpWebViewToolBar(target: target)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Компоновка UI
extension WebViewToolBar {
    
    private func setUpWebViewToolBar(target: Any) -> Void {
        self.setUpBackButtonItem(target: target)
        self.setUpFixedSpaceButtonItem()
        self.setUpForwardButtonItem(target: target)
        self.setUpFlexibleButtonItem()
        self.setUpUpdateButtonItem(target: target)
        self.setUpCloseWebViewButtonItem(target: target)
        self.setUpOpenSafariButtonItem(target: target)
        self.setItems([self.backButtonItem,
                       self.fixedSpaceButtonItem,
                       self.forwardButtonItem,
                       self.flexibleSpaceButtonItem,
                       self.openSafariButtonItem,
                       self.flexibleSpaceButtonItem,
                       self.closeWebViewButtonItem,
                       self.fixedSpaceButtonItem,
                       self.updateButtonItem],
                      animated: false)
        self.barTintColor = .systemGray5
    }
    
    private func setUpBackButtonItem(target: Any) -> Void {
        self.backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left") ?? UIImage(),
                                              style: .done,
                                              target: target,
                                              action: nil)
        self.backButtonItem.tintColor = .black
    }
    
    private func setUpFixedSpaceButtonItem() -> Void {
        //let space =
        self.fixedSpaceButtonItem = UIBarButtonItem(systemItem: .fixedSpace)
        self.fixedSpaceButtonItem.width = 20
    }
    
    private func setUpForwardButtonItem(target: Any) -> Void {
        self.forwardButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right") ?? UIImage(),
                                                 style: .done,
                                                 target: target,
                                                 action: nil)
        self.forwardButtonItem.tintColor = .black
    }
    
    private func setUpFlexibleButtonItem() -> Void {
        self.flexibleSpaceButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
    }
    
    private func setUpOpenSafariButtonItem(target: Any) -> Void {
        self.openSafariButtonItem = UIBarButtonItem(image: UIImage(systemName: "safari") ?? UIImage(),
                                                    style: .done,
                                                    target: target,
                                                    action: nil)
        self.openSafariButtonItem.tintColor = .black
    }
    
    private func setUpCloseWebViewButtonItem(target: Any) -> Void {
        self.closeWebViewButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                      style: .done,
                                                      target: target,
                                                      action: nil)
        self.closeWebViewButtonItem.tintColor = .black
    }
    
    private func setUpUpdateButtonItem(target: Any) -> Void {
        self.updateButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise") ?? UIImage(),
                                                style: .done,
                                                target: target,
                                                action: nil)
        self.updateButtonItem.tintColor = .black
    }
    
}



// MARK: - Интерфейс
extension WebViewToolBar {
    
    // MARK: Добавление обработчика нажатия на кнопку backButtonItem
    func addActionToBackButtonItem(selector: Selector) -> Void {
        self.backButtonItem.action = selector
    }
    
    // MARK: Добавление обработчика нажатия на кнопку forwardButtonItem
    func addActionToForwardButtonItem(selector: Selector) -> Void {
        self.forwardButtonItem.action = selector
    }
    
    // MARK: Добавление обработчика нажатия на кнопку updateButtonItem
    func addActionToUpdateButtonItem(selector: Selector) -> Void {
        self.updateButtonItem.action = selector
    }
    
    // MARK: Добавление обработчика нажатия на кнопку openSafariButtonItem
    func addActionToOpenSafariButtonItem(selector: Selector) -> Void {
        self.openSafariButtonItem.action = selector
    }
    
    // MARK: Добавление обработчика нажатия на кнопку closeWebViewButtonItem
    func addactionToCloseWebViewButtonItem(selector: Selector) -> Void {
        self.closeWebViewButtonItem.action = selector
    }
    
}

