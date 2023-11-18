//
//  ChosenNewsCategoriesStorageManagerProtocol.swift
//  NewsHub
//
//  Created by Kirill on 18.11.2023.
//

import Foundation



protocol ChosenNewsCategoriesStorageManagerProtocol {
    func save(arrayOfCategories: [NewsCategory]) -> Void
    func fetch() -> [NewsCategory]?
}
