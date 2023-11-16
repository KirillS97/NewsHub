//
//  CategorySelectionSceneViewController.swift
//  NewsHub
//
//  Created by Kirill on 15.11.2023.
//

import UIKit



// MARK: - CategorySelectionSceneViewController
final class CategorySelectionSceneViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        let categorySelectionView = CategorySelectionSceneView(frame: .zero, categoriesNumber: 7)
        categorySelectionView.setCollectionViewDataSource(dataSource: self)
        categorySelectionView.setCollectionViewDelegate(delegate: self)
        self.view = categorySelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}



extension CategorySelectionSceneViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let view = self.view as? CategorySelectionSceneView {
            if let cell = view.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell {
                cell.setNameLabelText(text: "NameNameName")
                return cell
            }
        }
        return CategoryCell()
    }
    
}



extension CategorySelectionSceneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(1)
    }
}



extension CategorySelectionSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let view = self.view as? CategorySelectionSceneView {
            if let categoryCollectionView = view.collectionView as? CategoryCollectionView {
                return categoryCollectionView.getCellSize()
            }
        }
        return CGSize(width: 0, height: 0)
    }
}
