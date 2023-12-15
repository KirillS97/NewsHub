//
//  NewsTableViewCell.swift
//  NewsHub
//
//  Created by Kirill on 07.12.2023.
//

import UIKit



// MARK: - NewsTableViewCell
final class NewsTableViewCell: UITableViewCell {
    
    // MARK: Свойства класса
    static let reuseId = "NewsTableViewCell"
    
    // MARK: Свойства объектов класса
    private var titleLabel          : UILabel!
    private var authorLabel         : UILabel!
    private var publicationDateLabel: UILabel!
    private var stackView           : UIStackView!
    
    // MARK: Инициализаторы
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpNewsTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - Компоновка UI
extension NewsTableViewCell {
    
    // MARK: Настройка ячейки NewsTableViewCell
    private func setUpNewsTableViewCell() -> Void {
        self.setUpBackgroundColor()
        self.setUpTitleLabel()
        self.setUpAuthorLabel()
        self.setUpPublicationDateLabel()
        self.setUpStackView()
        self.selectionStyle = .none
    }
    
    private func setUpBackgroundColor() -> Void {
        self.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    // MARK: Настройка titleLabel
    private func setUpTitleLabel() -> Void {
        self.titleLabel = UILabel()
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        self.titleLabel.textColor = .black
    }
    
    // MARK: Настройка authorLabel
    private func setUpAuthorLabel() -> Void {
        self.authorLabel = UILabel()
        self.authorLabel.numberOfLines = 0
        self.authorLabel.font = .systemFont(ofSize: 18, weight: .medium)
        self.authorLabel.textColor = .gray
    }
    
    // MARK: Настройка publicationDateLabel
    private func setUpPublicationDateLabel() -> Void {
        self.publicationDateLabel = UILabel()
        self.publicationDateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        self.publicationDateLabel.textColor = .systemGray
    }
    
    // MARK: Настройка stackView
    private func setUpStackView() -> Void {
        self.stackView = UIStackView()
        self.addSubview(self.stackView)
        self.stackView.axis = .vertical
        self.stackView.alignment = .leading
        self.stackView.distribution = .fill
        self.stackView.spacing = 0
        self.stackView.addArrangedSubview(self.authorLabel)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.publicationDateLabel)
        self.stackView.setCustomSpacing(10, after: self.authorLabel)
        self.stackView.setCustomSpacing(10, after: self.titleLabel)
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        self.addConstraintsToStackView()
        self.stackView.backgroundColor = .white
        self.stackView.layer.cornerRadius = 15
    }
    
    private func addConstraintsToStackView() -> Void {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
}



// MARK: - Интерфейс
extension NewsTableViewCell {
    
    // MARK: Установка заголовка
    func setTitle(title: String) -> Void {
        self.titleLabel.text = title
    }
    
    // MARK: Установка автора
    func setAuthor(author: String) -> Void {
        self.authorLabel.text = author
    }
    
    // MARK: Установка даты публикации
    func setPublicationDate(date: String) -> Void {
        self.publicationDateLabel.text = date
    }
    
}




// MARK: - NewsTableViewCell +
extension NewsTableViewCell {
    
    // MARK: Подготовка к переиспользованию
    override func prepareForReuse() {
        self.titleLabel.text = ""
        self.authorLabel.text = ""
        self.publicationDateLabel.text = ""
    }
    
}



