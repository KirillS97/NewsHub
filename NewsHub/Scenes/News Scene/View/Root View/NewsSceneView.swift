//
//  NewsSceneView.swift
//  NewsHub
//
//  Created by Kirill on 19.11.2023.
//

import UIKit



// MARK: - NewsSceneView
final class NewsSceneView: UIView {
    
    // MARK: Свойства объекта класса
    private (set) var categoriesCollectionView: UICollectionView!
    private (set) var newsTableView           : UITableView!
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpNewsSceneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Компоновка UI
extension NewsSceneView {
    
    private func setUpNewsSceneView() -> Void {
        self.setUpCategoriesCollectionView()
        self.setUpNewsTableView()
        self.setUpBackgroundColor()
    }
    
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = .systemGray6
    }
    
    private func setUpCategoriesCollectionView() -> Void {
        self.categoriesCollectionView = CategoriesListCollectionView(frame: .zero)
        self.addSubview(self.categoriesCollectionView)
        self.addConstraintsToCategoriesCollectionView()
        self.categoriesCollectionView.backgroundColor = .none
    }
    
    private func addConstraintsToCategoriesCollectionView() -> Void {
        self.categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoriesCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.categoriesCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.categoriesCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.categoriesCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setUpNewsTableView() -> Void {
        self.newsTableView = UITableView(frame: .init(x: 0, y: 0, width: 10, height: 10), style: .plain)
        self.addSubview(self.newsTableView)
        self.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseId)
        self.newsTableView.estimatedRowHeight = 100
        self.addConstraintsToNewsTableView()
        self.newsTableView.backgroundColor = .none
        self.newsTableView.separatorStyle = .none
        self.newsTableView.showsVerticalScrollIndicator = false
    }
    
    private func addConstraintsToNewsTableView() -> Void {
        self.newsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.newsTableView.topAnchor.constraint(equalTo: self.categoriesCollectionView.bottomAnchor),
            self.newsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.newsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.newsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
}



// MARK: - Интерфейс
extension NewsSceneView {
    
    func addCollectionViewDelegate(delegate: UICollectionViewDelegate) -> Void {
        self.categoriesCollectionView.delegate = delegate
    }
    
    func addCollectionViewDataSource(dataSource: UICollectionViewDataSource) -> Void {
        self.categoriesCollectionView.dataSource = dataSource
    }
    
    func addTableViewDelegate(delegate: UITableViewDelegate) -> Void {
        self.newsTableView.delegate = delegate
    }
    
    func addTableViewDataSource(dataSource: UITableViewDataSource) -> Void {
        self.newsTableView.dataSource = dataSource
    }
    
}
