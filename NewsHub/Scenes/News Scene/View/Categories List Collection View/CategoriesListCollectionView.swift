//
//  CategoriesListCollectionView.swift
//  NewsHub
//
//  Created by Kirill on 19.11.2023.
//

import UIKit

// MARK: - CategoriesListCollectionView
class CategoriesListCollectionView: UICollectionView {
    
    // MARK: Свойства объектов класса
    private let flowLayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 80, height: 50)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    // MARK: Инициализаторы
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: self.flowLayout)
        self.setUpCategoriesListCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Конфигурация UI
extension CategoriesListCollectionView {
    
    // MARK: Настройка CategoriesListCollectionView
    func setUpCategoriesListCollectionView() -> Void {
        self.register(CategoriesListCollectionViewCell.self,
                      forCellWithReuseIdentifier: CategoriesListCollectionViewCell.reuseId)
        self.showsHorizontalScrollIndicator = false
    }
    
}
