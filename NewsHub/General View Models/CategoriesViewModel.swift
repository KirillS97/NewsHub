//
//  CategoriesViewModel.swift
//  NewsHub
//
//  Created by Kirill on 16.11.2023.
//

import Foundation



// MARK: - CategoriesViewModel
final class CategoriesViewModel {
    
    // MARK: Свойства объектов класса
    private let chosenCategoriesStorageManager: NewsCategoriesStorageManagerProtocol = NewsCategoriesStorageManager.shared
    let allCategoriesArray: [NewsCategory]
    private (set) var chosenCategoriesArray: [NewsCategory]
    let lastChangedCategory: Observable<NewsCategory?>
    
    // MARK: Инициализаторы
    init()  {
        var categoriesArray: [NewsCategory] = []
        NewsCategory.allCases.forEach { category in
            categoriesArray.append(category)
        }
        self.allCategoriesArray    = categoriesArray
        self.lastChangedCategory   = .init(value: nil)
        if let chosenCategories = self.chosenCategoriesStorageManager.fetch() {
            self.chosenCategoriesArray = chosenCategories
        } else {
            self.chosenCategoriesArray = []
        }
    }
    
}


// MARK: - Интерфейс
extension CategoriesViewModel {
    
    // MARK: Срабатывает при нажатии на ячейку в коллекции категорий
    func cellHasBeenPressed(itemNumber: Int) -> Void {
        guard self.allCategoriesArray.indices.contains(itemNumber) else {
            return
        }
        let category = self.allCategoriesArray[itemNumber]
        if let index = self.chosenCategoriesArray.firstIndex(of: category) {
            self.chosenCategoriesArray.remove(at: index)
        } else {
            self.chosenCategoriesArray.append(category)
        }
        self.lastChangedCategory.value = category
    }
    
    func isChosenCatagoriesSaved() -> Bool {
        if !self.chosenCategoriesArray.isEmpty {
            self.chosenCategoriesStorageManager.save(arrayOfCategories: self.chosenCategoriesArray)
            return true
        } else {
            return false
        }
    }
    
    func getCategoryNameFromAllCategoriesArray(itemNumber: Int) -> String? {
        guard self.allCategoriesArray.indices.contains(itemNumber) else {
            return nil
        }
        return self.allCategoriesArray[itemNumber].getRussianDescription()
    }
    
    func getCategoryImageNameFromAllCategoriesArray(itemNumber: Int) -> String? {
        guard self.allCategoriesArray.indices.contains(itemNumber) else {
            return nil
        }
        return self.allCategoriesArray[itemNumber].getImageName()
    }
    
    func isThisCategoryIsChosen(itemNumber: Int) -> Bool {
        guard self.allCategoriesArray.indices.contains(itemNumber) else {
            return false
        }
        return self.chosenCategoriesArray.contains(self.allCategoriesArray[itemNumber])
    }
    
}
