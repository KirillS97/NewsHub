//
//  Observable.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - Observable
final class Observable<T>: ObservableProtocol {
    
    typealias SomeType = T
    
    var value: SomeType {
        didSet {
            self.react()
        }
    }
    private var reactiveAction: ((SomeType) -> Void)?
    
    init(value: SomeType) {
        self.value = value
    }
    
    func bind(reactiveAction: @escaping (SomeType) -> Void) -> Void {
        self.reactiveAction = reactiveAction
    }
    
    private func react() -> Void {
        self.reactiveAction?(value)
    }
    
}

