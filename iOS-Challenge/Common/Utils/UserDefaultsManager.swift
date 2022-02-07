//
//  UserDefaultsManager.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import Foundation

enum UserDefaultsKeys: String {
    case favorites
}

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func set(key: UserDefaultsKeys, value: Any) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func remove(key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func getFavorites() -> [String] {
        return defaults.stringArray(forKey: UserDefaultsKeys.favorites.rawValue) ?? []
    }
    
    func addToFavorites(id: String) {
        var currentFavorites = getFavorites()
        currentFavorites.append(id)
        set(key: .favorites, value: currentFavorites)
    }
    
    func removeFromFavorites(id: String) {
        var currentFavorites = getFavorites()
        currentFavorites.removeAll(where: { $0 == id })
        set(key: .favorites, value: currentFavorites)
    }
    
    func toggleFavorites(id: String) {
        var currentFavorites = getFavorites()
        if currentFavorites.contains(where: { $0 == id }) {
            currentFavorites.removeAll(where: { $0 == id })
        } else {
            currentFavorites.append(id)
        }
        set(key: .favorites, value: currentFavorites)
    }
    
}
