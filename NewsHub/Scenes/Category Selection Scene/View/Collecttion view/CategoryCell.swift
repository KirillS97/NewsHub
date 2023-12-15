//
//  CategoryCell.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import UIKit



// MARK: - CategoryCell
final class CategoryCell: UICollectionViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "CategoryCell"
    
    // MARK: Свойства объектов класса
    private var iconView          : UIImageView!
    private var iconBackgroundView: UIView!
    private var nameLabel         : UILabel!
    private var verticalStackView : UIStackView!
    
    private var isChosen          : Bool = false {
        didSet {
            if self.isChosen != oldValue {
                self.choiseStateHasBeenChanged()
            }
        }
    }
    
    // MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCategoryCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - Компоновка UI
extension CategoryCell {
    
    // MARK: Настройка ячейки
    private func setUpCategoryCell() -> Void {
        self.setUpIconBackgroundView()
        self.setUpNameLabel()
        self.setUpVerticalStackView()
        self.setUpIconView()
    }
    
    // MARK: Настройка вью под иконкой ячейки
    private func setUpIconBackgroundView() -> Void {
        self.iconBackgroundView = UIView()
        self.iconBackgroundView.backgroundColor = .systemGray6
        self.iconBackgroundView.layer.cornerRadius = 15
        self.addConstraintsToIconBackgroundView()
    }
    
    private func addConstraintsToIconBackgroundView() -> Void {
        self.iconBackgroundView.widthAnchor.constraint(equalTo: self.iconBackgroundView.heightAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: Настройка метки с названием ячейки
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.setUpNameLabelTextAttributes()
        self.nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    private func setUpNameLabelTextAttributes() -> Void {
        if self.isChosen {
            self.nameLabel.textColor = .black
            self.nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        } else {
            self.nameLabel.textColor = .systemGray
            self.nameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStackView() -> Void {
        self.verticalStackView = UIStackView(arrangedSubviews: [self.iconBackgroundView, self.nameLabel])
        self.addSubview(self.verticalStackView)
        self.addConstraintsToVerticalStackView()
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .center
        self.verticalStackView.distribution = .fill
        self.verticalStackView.setCustomSpacing(5, after: self.iconBackgroundView)
    }
    
    private func addConstraintsToVerticalStackView() -> Void {
        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // MARK: Настройка iconView
    private func setUpIconView() -> Void {
        self.iconView = UIImageView()
        self.iconBackgroundView.addSubview(self.iconView)
        self.addConstraintsToIconView()
    }
    
    private func addConstraintsToIconView() -> Void {
        self.iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.iconView.centerXAnchor.constraint(equalTo: self.iconBackgroundView.centerXAnchor),
            self.iconView.centerYAnchor.constraint(equalTo: self.iconBackgroundView.centerYAnchor),
            self.iconView.widthAnchor.constraint(equalTo: self.iconBackgroundView.widthAnchor,
                                                 multiplier: 1,
                                                 constant: -40),
            self.iconView.heightAnchor.constraint(equalTo: self.iconBackgroundView.heightAnchor,
                                                  multiplier: 1,
                                                  constant: -40)
        ])
    }
    
    // MARK: Настраивает цвет изображения икноки в зависимости от того, выбрана данная категория илии нет
    private func setUpIconViewImageColor() -> Void {
        if self.isChosen {
            if let image = self.iconView.image {
                self.iconView.image = image.withTintColor(.systemBlue)
            }
        } else {
            if let image = self.iconView.image {
                self.iconView.image = image.withTintColor(.systemGray)
            }
        }
    }
    
    // MARK: Изменяет настройки иконки при изменении статуса ячейки (выбрана или нет)
    private func choiseStateHasBeenChanged() -> Void {
        self.setUpNameLabelTextAttributes()
        self.setUpIconViewImageColor()
    }
    
}



// MARK: - Публичные методы
extension CategoryCell {
    
    // MARK: Установка названия для ячейки
    func setNameLabelText(text: String) -> Void {
        self.nameLabel.text = text
    }
    
    // MARK: Установка изображения для икноки
    func setIconImage(image: UIImage) -> Void {
        let grayImage = image.withTintColor(.systemGray)
        self.iconView.image = grayImage
    }
    
    // MARK: Срабатывает при нажатии на ячейку
    func changeChoiseState(isChosen: Bool) -> Void {
        self.isChosen = isChosen
    }
    
}
