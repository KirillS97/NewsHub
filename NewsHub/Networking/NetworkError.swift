//
//  NetworkError.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - NetworkError
enum NetworkError: String, Error, Equatable {
    case invalidURL         = "Недействительный URL"
    case serverError        = "Ошибка сервера"
    case missingStatusCcode = "Отсутствует статус-код"
    case missingData        = "Отсутствуют данные"
    case dataWasNotDecoded  = "Данные не были декодированы"
}
