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
    private var scrollView          : UIScrollView!
    
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
    
    // MARK: Настройка CategorySelectionSceneView
    private func setUpCategorySelectionSceneView(categoriesNumber: Int) -> Void {
        self.setUpScrollView()
        self.setUpNameLabel()
        self.setUpDescriptionLabel()
        self.setUpCollectionView(categoriesNumber: categoriesNumber)
        self.setUpNoticeLabel()
        self.setUpButtonOk()
        self.setUpBackgroundColor()
    }
    
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = .white
    }
    
    // MARK: Настройка scroll view
    private func setUpScrollView() -> Void {
        self.scrollView = UIScrollView()
        self.addSubview(self.scrollView)
        self.addConstraintsToScrollView()
        self.scrollView.backgroundColor = .white
    }
    
    private func addConstraintsToScrollView() -> Void {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    // MARK: Настройка nameLabel
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.scrollView.addSubview(self.nameLabel)
        self.addConsraintsToNameLabel()
        self.nameLabel.text = "Выберите одну или несколько категорий"
        self.nameLabel.numberOfLines = 0
        self.nameLabel.textColor = .black
        self.nameLabel.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private func addConsraintsToNameLabel() -> Void {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor, constant: 10),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: Настройка descriptionLabel
    private func setUpDescriptionLabel() -> Void {
        self.descriptionLabel = UILabel()
        self.scrollView.addSubview(self.descriptionLabel)
        self.addConsraintsToDescriptionLabel()
        self.descriptionLabel.text = "Вам будут предложены новости только по выбранным категориям"
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = .systemGray2
        self.descriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func addConsraintsToDescriptionLabel() -> Void {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor)
        ])
    }
    
    // MARK: Настройка collectionView
    private func setUpCollectionView(categoriesNumber: Int) -> Void {
        self.collectionView = CategoryCollectionView(frame: .zero, categoriesNumber: categoriesNumber)
        self.scrollView.addSubview(self.collectionView)
        self.addConstraintsToCollectionView()
    }
    
    private func addConstraintsToCollectionView() -> Void {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 50)
        ])
        if let categoryCollectionView = self.collectionView as? CategoryCollectionView {
            NSLayoutConstraint.activate([
                self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor,
                                                            multiplier: categoryCollectionView.getCollectionViewHeightMultiplier(),
                                                            constant: categoryCollectionView.getCollectionViewHeightConstant())
            ])
        }
    }
    
    // MARK: Настройка noticeLabel
    private func setUpNoticeLabel() -> Void {
        self.noticeLabel = UILabel()
        self.scrollView.addSubview(self.noticeLabel)
        self.addConstraitsToNoticeLabel()
        self.noticeLabel.text = "Выбранные категории: 0"
        self.noticeLabel.numberOfLines = 0
        self.noticeLabel.layoutMargins.bottom = 300
        self.noticeLabel.textColor = .systemGray2
        self.noticeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.noticeLabel.backgroundColor = .white
    }
    
    private func addConstraitsToNoticeLabel() -> Void {
        self.noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noticeLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.noticeLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.noticeLabel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 20),
            
            self.scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.noticeLabel.bottomAnchor, constant: 100)
        ])
    }
    
    // MARK: Настройка buttonOk
    private func setUpButtonOk() -> Void {
        self.buttonOk = UIButton()
        self.addSubview(self.buttonOk)
        self.addConstraintsToButtonOk()
        self.buttonOk.setTitle("Готово", for: .normal)
        self.buttonOk.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        self.buttonOk.setTitleColor(.white, for: .normal)
        self.buttonOk.setTitleColor(.systemGray3, for: .highlighted)
        self.buttonOk.backgroundColor = .systemBlue
        self.buttonOk.layer.cornerRadius = 12.5
    }
    
    private func addConstraintsToButtonOk() -> Void {
        self.buttonOk.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.buttonOk.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -20),
            self.buttonOk.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.buttonOk.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.buttonOk.heightAnchor.constraint(equalToConstant: self.buttonOk.intrinsicContentSize.height + 10)
        ])
    }
    

    
}



// MARK: Интерфейс
extension CategorySelectionSceneView {
    
    // MARK: установка делегата для collectionView
    func setCollectionViewDelegate(delegate: UICollectionViewDelegate) -> Void {
        self.collectionView.delegate = delegate
    }
    
    // MARK: установка источника данных для collectionView
    func setCollectionViewDataSource(dataSource: UICollectionViewDataSource) -> Void {
        self.collectionView.dataSource = dataSource
    }
    
    // MARK: установка количества выбранных категорий
    func setChosenCategoriesCount(count: Int) -> Void {
        self.noticeLabel.text = "Выбранные категории: \(count)"
        if self.noticeLabel.textColor != .systemGray {
            self.noticeLabel.textColor = .systemGray
        }
    }
    
    // MARK: вызов уведомления
    func note() -> Void {
        self.noticeLabel.text = "Выберите хотя бы одну категорию!"
        self.noticeLabel.textColor = .systemRed
    }
    
    // MARK: добавление обработчика нажатия на кнопку buttonOk
    func addTargetToButtonOk(target: Any? , action: Selector) -> Void {
        self.buttonOk.addTarget(target, action: action, for: .touchUpInside)
    }

}



