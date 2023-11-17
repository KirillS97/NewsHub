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
    let allCategoriesArray: [NewsCategory]
    var chosenCategoriesArray: [NewsCategory]
    let lastChangedCategory: Observable<NewsCategory?>
    
    // MARK: Инициализаторы
    init()  {
        var categoriesArray: [NewsCategory] = []
        NewsCategory.allCases.forEach { category in
            categoriesArray.append(category)
        }
        self.allCategoriesArray    = categoriesArray
        self.chosenCategoriesArray = []
        self.lastChangedCategory   = .init(value: nil)
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
    
}
