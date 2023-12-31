//
//  NewsCategory.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - Category
enum NewsCategory: String, CaseIterable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}



// MARK: - Публичные методы
extension NewsCategory {
    
    // MARK: Получение описания категории на русском языке
    func getRussianDescription() -> String {
        switch self {
        case .business      : return "Бизнес"
        case .entertainment : return "Развлечения"
        case .general       : return "Мир"
        case .health        : return "Здоровье"
        case .science       : return "Наука"
        case .sports        : return "Спорт"
        case .technology    : return "Технологии"
        }
    }
    
    // MARK: Получение названия изображения для выбранной категории
    func getImageName() -> String {
        return self.rawValue
    }
    
}



// MARK: - + Codable
extension NewsCategory: Codable {
    
}
