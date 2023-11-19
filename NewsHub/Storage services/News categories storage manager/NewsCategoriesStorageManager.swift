//
//  FileManagerStorage.swift
//  NewsHub
//
//  Created by Kirill on 17.11.2023.
//

import Foundation



// MARK: - NewsCategoriesStorageManager
final class NewsCategoriesStorageManager: NewsCategoriesStorageManagerProtocol {
    
    // MARK: Реализация singleton
    static let shared = NewsCategoriesStorageManager()
    private init() {}
    
    // MARK: Хранимые свойства объекта класса
    private let fileManager = FileManager.default
    
    // MARK: Вычисляемые свойства объекта класса
    private var documentsDirectoryURL: URL? {
        let urlArray: [URL] = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return urlArray.first
    }
    
    private var storingDirectoryURL: URL? {
        return self.documentsDirectoryURL?.appending(path: "storage")
    }
    
    private var storingFileURL: URL? {
        return self.storingDirectoryURL?.appending(path: "chosenNewsCategories")
    }
    
}


// MARK: - Приватные методы
extension NewsCategoriesStorageManager {
    
    // MARK: Создание папки, в которой будет расположен файл хранения
    private func createFolderForStoringFile() -> Void {
        guard let storingDirectoryURL else {
            return
        }
        
        if !self.fileManager.fileExists(atPath: storingDirectoryURL.path()) {
            do {
                try self.fileManager.createDirectory(at: storingDirectoryURL, withIntermediateDirectories: true)
            } catch {
                debugPrint("Не удалось создать папку")
            }
        }
        
    }
    
}



// MARK: Интерфейс
extension NewsCategoriesStorageManager {
    
    // MARK: Создание файла хранения с закодированными данными
    func save(arrayOfCategories: [NewsCategory]) -> Void {
        guard let storingFileURL else {
            return
        }
        if let encodedData = try? JSONEncoder().encode(arrayOfCategories) {
            self.createFolderForStoringFile()
            if !self.fileManager.createFile(atPath: storingFileURL.path(), contents: encodedData) {
                debugPrint("не удалось создать файл")
            }
        }
    }
    
    // MARK: Извлечение декодированных данных из файла хранения
    func fetch() -> [NewsCategory]? {
        guard let storingFileURL else {
            return nil
        }
        if let encodedData = self.fileManager.contents(atPath: storingFileURL.path()) {
            do {
                let decodedData = try JSONDecoder().decode([NewsCategory].self, from: encodedData)
                return decodedData
            } catch {
                debugPrint("Не удалось декодировать данные")
            }
        }
        return nil
    }
    
}
