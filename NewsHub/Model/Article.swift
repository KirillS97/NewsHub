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
