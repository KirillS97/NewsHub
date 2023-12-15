//
//  NewsSceneViewController.swift
//  NewsHub
//
//  Created by Kirill on 19.11.2023.
//

import UIKit


// MARK: - NewsSceneViewController
final class NewsSceneViewController: UIViewController {
    
    // MARK: Свойства объектов класса
    private var viewModel: NewsSceneViewModel!
    
    // MARK: loadView
    override func loadView() {
        super.loadView()
        let newsSceneView = NewsSceneView(frame: .zero)
        self.view = newsSceneView
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpViewModel()
        
        if let newsSceneView = self.view as? NewsSceneView {
            newsSceneView.addCollectionViewDelegate(delegate: self)
            newsSceneView.addCollectionViewDataSource(dataSource: self)
            newsSceneView.addTableViewDataSource(dataSource: self)
            newsSceneView.addTableViewDelegate(delegate: self)
        }
        
        self.viewModel.fetchNewsArticles()
        
        self.viewModel.bindWithNewsArray { (newsArray: [Article]) in
            if let newsSceneView = self.view as? NewsSceneView {
                newsSceneView.newsTableView.reloadData()
            }
        }
        
        self.viewModel.bindWithChosenCategoriesArray { (categoriesArray: [NewsCategory]) in
            if let newsSceneView = self.view as? NewsSceneView {
                newsSceneView.categoriesCollectionView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.updateChosenCategories()
    }
    
}



// MARK: - Приватные методы
extension NewsSceneViewController {
    
    // MARK: Настройка view model
    private func setUpViewModel() -> Void {
        self.viewModel = NewsSceneViewModel(actionOnUnsatisfactoryResponse: { (networkError: NetworkError) -> Void in
            switch networkError {
            case .invalidURL:
                self.showAlert(title: "Не корректный URL")
            case .missingStatusCcode:
                self.showAlert(title: "Отсутствует статус-код")
            case .serverError:
                self.showAlert(title: "Сервер отправил ошибку")
            case .missingData:
                self.showAlert(title: "В ответе с сервера отсуствуют данные")
            case .dataWasNotDecoded:
                self.showAlert(title: "Данные не удалось декодировать")
            }
        })
    }
    
    // MARK: Показ уведомления в случае ошибки при получении ответа от сервера
    private func showAlert(title: String) -> Void {
        let alert = UIAlertController(title: title, message: "Не удалось получить данные", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(buttonOk)
        self.present(alert, animated: true)
    }
    
}


// MARK: - UICollectionViewDataSource
extension NewsSceneViewController: UICollectionViewDataSource {
    
    // MARK: numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.chosenCategoriesArray.value.count
    }
    
    // MARK: cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let newsSceneView = self.view as? NewsSceneView {
            if let categoriesCollectionView = newsSceneView.categoriesCollectionView as? CategoriesListCollectionView {
                if let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesListCollectionViewCell.reuseId, for: indexPath) as? CategoriesListCollectionViewCell {
                    cell.setName(name: self.viewModel.chosenCategoriesArray.value[indexPath.item].getRussianDescription())
                    cell.setImage(image: UIImage(named: self.viewModel.chosenCategoriesArray.value[indexPath.item].getImageName()) ?? UIImage())
                    if self.viewModel.isSelectedCategory(indexPath: indexPath) {
                        cell.select()
                    }
                    return cell
                }
            }
        }
        return CategoriesListCollectionViewCell(frame: .zero)
    }
    
}



// MARK: - UICollectionViewDelegate
extension NewsSceneViewController: UICollectionViewDelegate {
    
    // MARK: didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectCategory(index: indexPath.item)
        if let newsSceneView = self.view as? NewsSceneView {
            newsSceneView.categoriesCollectionView.reloadData()
        }
    }
    
}



// MARK: - UITableViewDataSource
extension NewsSceneViewController: UITableViewDataSource {
    
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.newsArray.value.count
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let newsSceneView = self.view as? NewsSceneView {
            if viewModel.newsArray.value.indices.contains(indexPath.row) {
                let news = self.viewModel.newsArray.value[indexPath.row]
                let returnedCell: NewsTableViewCell
                if let cell = newsSceneView.newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId, for: indexPath) as? NewsTableViewCell {
                    returnedCell = cell
                } else {
                    returnedCell = NewsTableViewCell(style: .default, reuseIdentifier: NewsTableViewCell.reuseId)
                }
                returnedCell.setTitle(title: news.title ?? "Title")
                returnedCell.setAuthor(author: news.author ?? "Author")
                returnedCell.setPublicationDate(date: news.getDateInTheRequiredFormat() ?? "Date")
                return returnedCell
            }
        }
        return UITableViewCell()
    }
    
}



// MARK: - UITableViewDelegate
extension NewsSceneViewController: UITableViewDelegate {
    
    // MARK: willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.newsArray.value.count - 1 {
            if self.viewModel.areThereAnyUnloadedPages() {
                self.viewModel.increasePage()
                self.viewModel.fetchNewsArticles()
            }
        }
    }
    
    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = self.viewModel.newsArray.value[indexPath.row]
        if let urlString = news.url {
            let webSceneViewController = WebSceneViewController(stringURL: urlString)
            self.present(webSceneViewController, animated: true)
        }
    }
    
}
