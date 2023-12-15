//
//  CategoriesListCollectionViewCell.swift
//  NewsHub
//
//  Created by Kirill on 19.11.2023.
//

import UIKit



// MARK: - CategoriesListCollectionViewCell
final class CategoriesListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "CategoriesListCollectionViewCell"
    
    // MARK: Свойства объектов класса
    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    private var stackView: UIStackView!
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCategoriesListCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}



// MARK: - Компоновка UI
extension CategoriesListCollectionViewCell {
    
    // MARK: Настройка ячейки CategoriesListCollectionViewCell
    private func setUpCategoriesListCollectionViewCell() -> Void {
        self.setUpBackgroundColor()
        self.setUpNameLabel()
        self.setUpImageView()
        self.setUpStackView()
    }
    
    // MARK: Настройка цвета фона ячейки CategoriesListCollectionViewCell
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = .none
    }
    
    // MARK: Настройка метки nameLabel
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.nameLabel.textColor = .black
        self.nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    // MARK: Настройка imageVIew
    private func setUpImageView() -> Void {
        self.imageView = UIImageView()
    }
    
    // MARK: Настройка stackView
    private func setUpStackView() -> Void {
        self.stackView = UIStackView()
        self.stackView.addArrangedSubview(self.imageView)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.spacing = 5
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.stackView.layoutMargins = .init(top: 5, left: 10, bottom: 5, right: 10)
        self.addSubview(self.stackView)
        self.addConstraintsToStackView()
        //self.stackView.layer.borderWidth = 2
        self.stackView.layer.cornerRadius = 15
        self.stackView.layer.borderColor = UIColor.systemBlue.cgColor
        self.stackView.backgroundColor = .systemGray5
    }
    
    private func addConstraintsToStackView() -> Void {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            self.imageView.heightAnchor.constraint(equalToConstant: 30),
            self.imageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}




// MARK: - Интерфейс
extension CategoriesListCollectionViewCell {
    
    // MARK: Установка названия категории
    func setName(name: String) -> Void {
        self.nameLabel.text = name
    }
    
    // MARK: Установка изображения для категории
    func setImage(image: UIImage) -> Void {
        self.imageView.image = image
    }
    
    // MARK: Выделение ячейки
    func select() -> Void {
        self.nameLabel.textColor = .systemBlue
        let image = self.imageView.image?.withTintColor(.systemBlue)
        self.imageView.image = image
    }
    
}



// MARK: - CategoriesListCollectionViewCell +
extension CategoriesListCollectionViewCell {
    
    // MARK: Подготовка к переиспользованию
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.textColor = .black
    }
    
}
