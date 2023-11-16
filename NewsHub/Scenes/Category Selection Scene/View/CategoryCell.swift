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
        self.iconBackgroundView.backgroundColor = .systemGray5
        self.iconBackgroundView.layer.cornerRadius = 15
        self.iconBackgroundView.layer.borderWidth = 5
        self.iconBackgroundView.layer.borderColor = UIColor.systemYellow.cgColor
        self.addConstraintsToIconBackgroundView()
    }
    
    private func addConstraintsToIconBackgroundView() -> Void {
        self.iconBackgroundView.widthAnchor.constraint(equalTo: self.iconBackgroundView.heightAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: Настройка метки с названием ячейки
    private func setUpNameLabel() -> Void {
        self.nameLabel = UILabel()
        self.nameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        self.nameLabel.textColor = .black
        self.nameLabel.backgroundColor = .white
        self.nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    // MARK: Настройка вертикального стека
    private func setUpVerticalStackView() -> Void {
        self.verticalStackView = UIStackView(arrangedSubviews: [self.iconBackgroundView, self.nameLabel])
        self.addSubview(self.verticalStackView)
        self.addConstraintsToVerticalStackView()
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .center
        self.verticalStackView.distribution = .fill
        self.verticalStackView.backgroundColor = .systemBlue
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
        self.iconView.image = UIImage(named: "business")
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
    
}



// MARK: - Публичные методы
extension CategoryCell {
    func setNameLabelText(text: String) -> Void {
        self.nameLabel.text = text
    }
}
