//
//  CategorySelectionSceneViewController.swift
//  NewsHub
//
//  Created by Kirill on 15.11.2023.
//

import UIKit



// MARK: - CategorySelectionSceneViewController
final class CategorySelectionSceneViewController: UIViewController {
    
    private var viewModel = CategoriesViewModel()
    
    override func loadView() {
        super.loadView()
        let categorySelectionView = CategorySelectionSceneView(frame: .zero, categoriesNumber: self.viewModel.allCategoriesArray.count)
        categorySelectionView.setCollectionViewDataSource(dataSource: self)
        categorySelectionView.setCollectionViewDelegate(delegate: self)
        categorySelectionView.addTargetToButtonOk(target: self, action: #selector(self.buttonOkHander))
        categorySelectionView.setChosenCategoriesCount(count: self.viewModel.chosenCategoriesArray.count)
        self.view = categorySelectionView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindVCWithViewModel()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /*
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let categorySelectionSceneView = self.view as? CategorySelectionSceneView {
            categorySelectionSceneView.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    */
    
}



// MARK: - Приватные методы
extension CategorySelectionSceneViewController {
    
    // MARK: Связывание вью контроллера с вью моделью
    private func bindVCWithViewModel() -> Void {
        self.viewModel.lastChangedCategory.bind(reactiveAction: { [weak self] (category: NewsCategory?) in
            guard self != nil else {
                return
            }
            guard let category else {
                return
            }
            guard let indexInAllCategoriesArray: Int = self!.viewModel.allCategoriesArray.firstIndex(of: category) else {
                return
            }
            if let categorySelectionView = self!.view as? CategorySelectionSceneView {
                if let cell = categorySelectionView.collectionView.cellForItem(at: IndexPath(item: indexInAllCategoriesArray, section: 0)) as? CategoryCell {
                    if self!.viewModel.chosenCategoriesArray.contains(category) {
                        cell.changeChoiseState(isChosen: true)
                    } else {
                        cell.changeChoiseState(isChosen: false)
                    }
                    categorySelectionView.setChosenCategoriesCount(count: self!.viewModel.chosenCategoriesArray.count)
                }
            }
        })
    }
    
    // MARK: Обработчик нажатия на кнопку готово
    @objc func buttonOkHander() -> Void {
        if self.viewModel.chosenCategoriesArray.count == 0 {
            if let categorySelectionView = view as? CategorySelectionSceneView {
                categorySelectionView.note()
            }
        } else {
            self.viewModel.saveChosenNewsCategories()
            print("chosenCategoriesArray.count != 0")
        }
    }
    
}



// MARK: - UICollectionViewDataSource
extension CategorySelectionSceneViewController: UICollectionViewDataSource {
    
    // MARK: numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.allCategoriesArray.count
    }
    
    // MARK: cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let view = self.view as? CategorySelectionSceneView {
            if let cell = view.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell {
                if let name = self.viewModel.getCategoryNameFromAllCategoriesArray(itemNumber: indexPath.item) {
                    cell.setNameLabelText(text: name)
                }
                if let imageName = self.viewModel.getCategoryImageNameFromAllCategoriesArray(itemNumber: indexPath.item) {
                    if let image = UIImage(named: imageName) {
                        cell.setIconImage(image: image)
                    }
                }
                if self.viewModel.isThisCategoryIsChosen(itemNumber: indexPath.item) {
                    cell.changeChoiseState(isChosen: true)
                }
                return cell
            }
        }
        return CategoryCell(frame: .zero)
    }
    
}



// MARK: - UICollectionViewDelegate
extension CategorySelectionSceneViewController: UICollectionViewDelegate {
    
    // MARK: didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.cellHasBeenPressed(itemNumber: indexPath.item)
    }
    
}



// MARK: - UICollectionViewDelegateFlowLayout
extension CategorySelectionSceneViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let view = self.view as? CategorySelectionSceneView {
            if let categoryCollectionView = view.collectionView as? CategoryCollectionView {
                return categoryCollectionView.getCellSize()
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
}




