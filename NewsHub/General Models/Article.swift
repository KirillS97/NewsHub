//
//  Article.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - Article
struct Article: Decodable {
    let source     : ArticleSource?
    let author     : String?
    let title      : String?
    let description: String?
    let url        : String?
    let urlToImage : String?
    let publishedAt: String?
    let content    : String?
}



// MARK: - Article +
extension Article {
    
    // MARK: Возвращает строку с датой, актуальной для региона устройства в нужном формате
    func getDateInTheRequiredFormat() -> String? {
        let dateFormatterInput = ISO8601DateFormatter()
        let dateFormatterOutput = DateFormatter()
        
        dateFormatterInput.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        dateFormatterInput.timeZone = .gmt
        dateFormatterOutput.timeZone = .current
        dateFormatterOutput.dateFormat = "dd.MM.yyyy, HH:mm"
        
        if let publishedAt, let date = dateFormatterInput.date(from: publishedAt) {
            return dateFormatterOutput.string(from: date)
        } else {
            return nil
        }
    }

}
