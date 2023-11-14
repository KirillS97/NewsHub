//
//  NetworkManager.swift
//  NewsHub
//
//  Created by Kirill on 14.11.2023.
//

import Foundation



// MARK: - NetworkManager
final class NetworkManager {
    
    // MARK: Реализация Singleton
    static let shared = NetworkManager()
    private init() {
    }
    
    // MARK: Отправка запроса на сервер и получение ответа
    func fetchNewsArticles(
        url: URL?,
        completionHandler: @escaping (Result<OkQuery, Error>) -> Void
    ) -> Void {

        guard let url else {
            let networkError = NetworkError.invalidURL
            debugPrint(networkError.rawValue)
            completionHandler(.failure(networkError))
            return Void()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("test", forHTTPHeaderField: "User-Agent")
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error {
                let networkError = NetworkError.serverError
                debugPrint(networkError.rawValue)
                if let httpResponse = response as? HTTPURLResponse {
                    debugPrint("Статус код = \(httpResponse.statusCode)")
                } else {
                    debugPrint(NetworkError.missingStatusCcode.rawValue)
                }
                debugPrint(error.localizedDescription)
                completionHandler(.failure(networkError))
            } else {
                guard let safeData = data else {
                    let networkError = NetworkError.missingData
                    debugPrint(networkError.rawValue)
                    completionHandler(.failure(networkError))
                    return Void()
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let decodedOkQuery = try jsonDecoder.decode(OkQuery.self, from: safeData)
                    DispatchQueue.main.async {
                        completionHandler(.success(decodedOkQuery))
                    }
                } catch {
                    let decodedErrorQuery = try? jsonDecoder.decode(ErrorQuery.self, from: safeData)
                    if let decodedErrorQuery {
                        debugPrint("Статус: \(decodedErrorQuery.status)")
                        debugPrint("Код: \(decodedErrorQuery.code)")
                        debugPrint("Сообщение: \(decodedErrorQuery.message)")
                        completionHandler(.failure(NetworkError.serverError))
                    } else {
                        debugPrint("Данные, полученные с сервера не были декодированы")
                        let jsonObject = try? JSONSerialization.jsonObject(with: safeData)
                        if let jsonObject {
                            debugPrint(jsonObject)
                        }
                        completionHandler(.failure(NetworkError.dataWasNotDecoded))
                    }
                }
            }
        }
        
        dataTask.resume()
        
    }
    
}
