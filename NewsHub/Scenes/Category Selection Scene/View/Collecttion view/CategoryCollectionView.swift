//
//  CategoryCollectionView.swift
//  NewsHub
//
//  Created by Kirill on 15.11.2023.
//

import UIKit



// MARK: - CategoryCollectionView
final class CategoryCollectionView: UICollectionView {
    
    // MARK: Свойства объектов класса
    private let flowLayout = UICollectionViewFlowLayout()
    
    private let lineSpacing       = CGFloat(23.25)
    private let interItemSpacing  = CGFloat(23.25)
    private let horizontalIndent  = CGFloat(23.25)
    private let verticalIndent    = CGFloat(23.25)
    
    private let differenceBetweenCellHeightAndWidth: CGFloat = 0
    
    private let numberOfColumnsForCells = 3
    private let numberOfRowsForCells: Int
    
    // MARK: Инициализаторы
    init(frame: CGRect, categoriesNumber: Int) {
        self.numberOfRowsForCells = Int(ceil(Double(categoriesNumber) / Double(self.numberOfColumnsForCells)))
        super.init(frame: frame, collectionViewLayout: self.flowLayout)
        self.setUpCategoryCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Конфигурирование CategoryCollectionView
extension CategoryCollectionView {
    
    // MARK: Настройка коллекции
    private func setUpCategoryCollectionView() -> Void {
        self.setUpFlowLayout()
        self.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
        self.setUpBackgroundColor()
    }
    
    // MARK: Установка цвета фона
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = .none
    }
    
    // MARK: Настройка UICollectionViewFlowLayout
    private func setUpFlowLayout() -> Void {
        self.flowLayout.scrollDirection = .vertical
        self.flowLayout.minimumLineSpacing = self.lineSpacing
        self.flowLayout.minimumInteritemSpacing = self.interItemSpacing
        self.flowLayout.sectionInset = .init(top:    self.verticalIndent,
                                             left:   self.horizontalIndent,
                                             bottom: self.verticalIndent,
                                             right:  self.horizontalIndent)
    }
    
}



// MARK: - Публичные методы
extension CategoryCollectionView {
    
    // MARK: getCellSize
    // Используется в CategorySelectionSceneViewController для получения такого размера ячейки, который бы позволил разделить коллекцию на 4 столбца, расстояние между которыми бы точно соответствовало размеру interItemSpacing при отступах от левой и правой границ коллекции до ближайших столбцов, равных horizontalIndent. Округление ширины ячейки до 3 знака используется т.к. не всегда рассчетная ширина получается точной. Таким образом, данный метод позволяет сделать размер ячейки адаптивным в зависимости от размеров экрана.
    func getCellSize() -> CGSize {
        let firstTerm  = self.frame.width / CGFloat(self.numberOfColumnsForCells)
        let secondTerm = -1 * self.interItemSpacing
        let thirdTerm  = self.interItemSpacing / CGFloat(self.numberOfColumnsForCells)
        let fourthTerm = (-2 * self.horizontalIndent) / CGFloat(self.numberOfColumnsForCells)
        
        let cellWidth  = firstTerm + secondTerm + thirdTerm + fourthTerm
        
        let cellRoundedWidth = (cellWidth * 1000).rounded(.down) / 1000
        let cellHeight = cellRoundedWidth + self.differenceBetweenCellHeightAndWidth
        
        return CGSize(width: cellRoundedWidth, height: cellHeight)
    }
    
    // MARK: getCollectionViewHeightMultiplier
    // Используется в CategorySelectionSceneView в качестве множителя для высоты коллекции относительно её ширины при указании ограничений для этой коллекции. Данный метод с методом getCollectionViewHeightConstant позволяют сделать высоту фрейма коллекции адаптивной и подстраиваться под высоту ячеек и количество строк в коллекции.
    func getCollectionViewHeightMultiplier() -> CGFloat {
        CGFloat(self.numberOfRowsForCells) / CGFloat(self.numberOfColumnsForCells)
    }
    
    // MARK: getCollectionViewHeightConstant
    // Используется в CategorySelectionSceneView в качестве константы для высоты коллекции относительно её ширины при указании ограничений для этой коллекции. Данный метод с методом getCollectionViewHeightMultiplier позволяют сделать высоту фрейма коллекции адаптивной и подстраиваться под высоту ячеек и количество строк в коллекции.
    func getCollectionViewHeightConstant() -> CGFloat {
        let firstTerm  = CGFloat(-self.numberOfRowsForCells) * self.interItemSpacing
        let secondTerm = (CGFloat(self.numberOfRowsForCells) * self.interItemSpacing) / CGFloat(self.numberOfColumnsForCells)
        let thirdTerm  = (-2 * self.horizontalIndent * CGFloat(self.numberOfRowsForCells)) / CGFloat(self.numberOfColumnsForCells)
        let fourthTerm = CGFloat(self.numberOfRowsForCells) * self.differenceBetweenCellHeightAndWidth
        let fifthTerm  = CGFloat(self.numberOfRowsForCells - 1) * self.lineSpacing
        let sixthTerm  = 2 * self.verticalIndent
        
        let constant   = firstTerm + secondTerm + thirdTerm + fourthTerm + fifthTerm + sixthTerm
        
        return constant
    }
    
}
