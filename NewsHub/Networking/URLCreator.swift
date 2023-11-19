//
//  URLCreator.swift
//  NewsHub
//
//  Created by Kirill on 19.11.2023.
//

import Foundation



// MARK: - URLCreator. Приватные свойства и методы
struct URLCreator {
    
    // MARK: Реализация Singleton
    static let shared = URLCreator()
    private init() {
    }
    
    // MARK: Путь
    private let baseURL  = URL(string: "https://newsapi.org/v2")
    private let endPoint = "/top-headlines"
    
    // MARK: Параметры запроса
    private let country  = ["country": "ru"]
    private let apiKey   = ["apiKey": "ee55424affd8412999444d53e7677a59"]
    private let pageSize = ["pageSize": 10]
    
}



// MARK: - URLCreator. Публичные свойства и методы
extension URLCreator {
    
    // MARK: Получение опционального URL
    func getURL(category: NewsCategory, page: Int) -> URL? {
        guard  let baseURL else {
            debugPrint("URL не был создан объектом URLCreator: baseURL = nil")
            return nil
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        urlComponents?.path.append(contentsOf: self.endPoint)
        
        let queryCountryItem  = URLQueryItem(name: self.country.keys.first ?? "",
                                             value: self.country.values.first ?? "")
        
        let queryCategoryItem = URLQueryItem(name: "category",
                                             value: category.rawValue)
        
        let queryAppIdKeyItem = URLQueryItem(name: self.apiKey.keys.first ?? "",
                                             value: self.apiKey.values.first ?? "")
        
        let queryPageSizeItem = URLQueryItem(name: self.pageSize.keys.first ?? "",
                                             value: String(self.pageSize.values.first ?? 15))
        
        let queryPageItem     = URLQueryItem(name: "page",
                                             value: String(page))
        
        urlComponents?.queryItems = [
            queryCountryItem,
            queryCategoryItem,
            queryPageItem,
            queryPageSizeItem,
            queryAppIdKeyItem
        ]
        
        return urlComponents?.url
    }
    
}
