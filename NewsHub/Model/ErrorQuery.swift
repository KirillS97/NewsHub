//
//  ErrorQuery.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - ErrorQuery
struct ErrorQuery: Decodable {
    let status : String
    let code   : String
    let message: String
}
