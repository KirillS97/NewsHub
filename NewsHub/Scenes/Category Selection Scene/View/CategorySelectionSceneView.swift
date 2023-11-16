//
//  CategorySelectionSceneView.swift
//  NewsHub
//
//  Created by Kirill on 15.11.2023.
//

import UIKit



// MARK: - CategorySelectionSceneView
final class CategorySelectionSceneView: UIView {
    
    // MARK: Свойства объектов класса
    private var nameLabel           : UILabel!
    private var descriptionLabel    : UILabel!
    private (set) var collectionView: UICollectionView!
    private var noticeLabel         : UILabel!
    private var buttonOk            : UIButton!
    private var stackView           : UIStackView!
    
    // MARK: Инициализаторы
    init(frame: CGRect, categoriesNumber: Int) {
        super.init(frame: frame)
        self.setUpCategorySelectionSceneView(categoriesNumber: categoriesNumber)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Компоновка UI
extension CategorySelectionSceneView {
    
    private func setUpCategorySelectionSceneView(categoriesNumber: Int) -> Void {
        self.setUpNameLabel()
        self.setUpDescriptionLabel()
        self.setUpCollectionView(categoriesNumber: categoriesNumber)
        self.setUpNoticeLabel()
        self.setUpButtonOk()
        self.setUpStackView()
        self.setUpBackgroundColor()
    }
    
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = .systemGray
    }
    
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.nameLabel.text = "Выберите одну или несколько категорий"
        self.nameLabel.numberOfLines = 0
        self.nameLabel.textColor = .black
        self.nameLabel.backgroundColor = .white
        self.nameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        self.nameLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setUpDescriptionLabel() -> Void {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.text = "Вам будут предложены новости только по выбранным категориям"
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = .systemGray2
        self.descriptionLabel.backgroundColor = .white
        self.descriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setUpCollectionView(categoriesNumber: Int) -> Void {
        self.collectionView = CategoryCollectionView(frame: .zero, categoriesNumber: categoriesNumber)
        self.collectionView.backgroundColor = .systemBlue
    }
    
    private func setUpNoticeLabel() -> Void {
        self.noticeLabel = UILabel()
        self.noticeLabel.text = "Выбранные категории: 0"
        self.noticeLabel.numberOfLines = 0
        self.noticeLabel.layoutMargins.bottom = 300
        self.noticeLabel.textColor = .systemGray2
        self.noticeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.noticeLabel.backgroundColor = .white
    }
    
    private func setUpButtonOk() -> Void {
        self.buttonOk = UIButton()
        self.buttonOk.setTitle("Готово", for: .normal)
        self.buttonOk.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        self.buttonOk.setTitleColor(.white, for: .normal)
        self.buttonOk.setTitleColor(.systemGray3, for: .highlighted)
        self.buttonOk.backgroundColor = .systemBlue
    }
    
    private func setUpStackView() -> Void {
        self.stackView = UIStackView()
        self.addSubview(self.stackView)
        self.stackView.backgroundColor = .systemGray5
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .fill
        self.stackView.spacing = 0
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.setCustomSpacing(10, after: self.nameLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        self.stackView.addArrangedSubview(self.collectionView)
        self.stackView.addArrangedSubview(self.noticeLabel)
        self.stackView.addArrangedSubview(self.buttonOk)
        self.addConstraintsToStackView()
    }
    
    private func addConstraintsToStackView() -> Void {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            self.nameLabel.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 1),
            
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 1),
            
            self.collectionView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 1),
            self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor,
                                                        multiplier: (self.collectionView as! CategoryCollectionView).getCollectionViewHeightMultiplier(),
                                                        constant: (self.collectionView as! CategoryCollectionView).getCollectionViewHeightConstant()),
            
            self.buttonOk.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1, constant: -20)
        ])
    }
    
}



// MARK: Интерфейс
extension CategorySelectionSceneView {
    
    func setCollectionViewDelegate(delegate: UICollectionViewDelegate) -> Void {
        self.collectionView.delegate = delegate
    }
    
    func setCollectionViewDataSource(dataSource: UICollectionViewDataSource) -> Void {
        self.collectionView.dataSource = dataSource
    }
    
}



