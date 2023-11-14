//
//  ObservableProtocol.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - ObservableProtocol
protocol ObservableProtocol {
    associatedtype SomeType
    
    var value: SomeType { get set }
    
    func bind(reactiveAction: @escaping (SomeType) -> Void) -> Void
}
