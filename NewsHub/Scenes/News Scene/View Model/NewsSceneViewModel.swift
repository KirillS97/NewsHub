//
//  NewsSceneViewModel.swift
//  NewsHub
//
//  Created by Kirill on 08.12.2023.
//

import Foundation



// MARK: - NewsSceneViewModel
final class NewsSceneViewModel {
    
    // MARK: - Свойства объектов класса
    private let chosenCategoriesStorageManager: NewsCategoriesStorageManagerProtocol = NewsCategoriesStorageManager.shared
    private let networkManager      = NetworkManager.shared
    private let urlCreator          = URLCreator.shared
    
    private var loadedPagesCount    = 1
    private let newsCountForOnePage = 10
    private var pagesCount: Int {
        if let okQuery {
            return Int(ceil(Double(okQuery.totalResults) / Double(newsCountForOnePage)))
        }
        return 0
    }
    
    private var selectedCategory: NewsCategory  {
        didSet {
            self.newsArray.value = []
            self.resetLoadedPages()
            self.fetchNewsArticles()
        }
    }
    
    private var okQuery: OkQuery? {
        didSet {
            if let okQuery {
                self.newsArray.value.append(contentsOf: okQuery.articles)
            }
        }
    }
    
    private (set) var newsArray: Observable<[Article]> = .init(value: [])
    private (set) var chosenCategoriesArray: Observable<[NewsCategory]>
    
    let actionOnUnsatisfactoryResponse: (NetworkError) -> Void
    
    
    // MARK: - Инициализаторы
    init(actionOnUnsatisfactoryResponse: @escaping (NetworkError) -> Void) {
        if let categories = self.chosenCategoriesStorageManager.fetch() {
            self.chosenCategoriesArray = .init(value: categories)
            self.selectedCategory = self.chosenCategoriesArray.value[0]
        } else {
            self.chosenCategoriesArray = .init(value: [])
            self.selectedCategory = NewsCategory.general
        }
        self.actionOnUnsatisfactoryResponse = actionOnUnsatisfactoryResponse
    }
    
}



// MARK: - Интерфейс
extension NewsSceneViewModel {
    
    // MARK: Выбор категории для отображения новостей
    func selectCategory(index: Int) -> Void {
        guard self.chosenCategoriesArray.value.indices.contains(index) else {
            return
        }
        self.selectedCategory = self.chosenCategoriesArray.value[index]
    }
    
    // MARK: Связывание view controller с view model
    func bindWithNewsArray(reactiveAction: @escaping ([Article]) -> Void) -> Void {
        self.newsArray.bind(reactiveAction: reactiveAction)
    }
    
    func bindWithChosenCategoriesArray(reactiveAction: @escaping ([NewsCategory]) -> Void) {
        self.chosenCategoriesArray.bind(reactiveAction: reactiveAction)
    }
    
    // MARK: Отправка и обработка серверного запроса
    func fetchNewsArticles() -> Void {
        let url = urlCreator.getURL(category: selectedCategory,
                                    page: self.loadedPagesCount,
                                    pageSize: self.newsCountForOnePage)
        self.networkManager.fetchNewsArticles(url: url) { (result: Result<OkQuery, NetworkError>) -> Void in
            switch result {
            case .success(let query): self.okQuery = query
            case .failure(let error): self.actionOnUnsatisfactoryResponse(error)
            }
        }
    }
    
    // MARK: Сброс количества загруженных страниц до единицы
    func resetLoadedPages() -> Void {
        self.loadedPagesCount = 1
    }
    
    // MARK: Увеличение номера страницы для загрузки на единицу
    func increasePage() -> Void {
        if self.loadedPagesCount < self.pagesCount {
            self.loadedPagesCount += 1
        }
    }
    
    // MARK: Проверка, есть ли еще сраницы для загрузки
    func areThereAnyUnloadedPages() -> Bool {
        self.loadedPagesCount < self.pagesCount
    }
    
    // MARK: Проверка, является ли категория по данному индексу выбранной
    func isSelectedCategory(indexPath: IndexPath) -> Bool {
        guard self.chosenCategoriesArray.value.indices.contains(indexPath.row) else {
            return false
        }
        return self.selectedCategory == self.chosenCategoriesArray.value[indexPath.row]
    }
    
    func updateChosenCategories() -> Void {
        if let categoriesArray = self.chosenCategoriesStorageManager.fetch() {
            self.chosenCategoriesArray.value = categoriesArray
            self.selectedCategory = self.chosenCategoriesArray.value[0]
        }
    }
    
}
