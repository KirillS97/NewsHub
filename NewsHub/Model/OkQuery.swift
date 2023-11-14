//
//  OkQuery.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - OkQuery
struct OkQuery: Decodable {
    let status      : String
    let totalResults: Int
    let articles    : [Article]
}
