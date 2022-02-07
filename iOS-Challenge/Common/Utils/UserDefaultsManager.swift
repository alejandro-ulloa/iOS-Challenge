//
//  UserDefaultsManager.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import Foundation

enum UserDefaultsKeys: String {
    case favourites
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
    
    func getFavourites() -> [String] {
        return defaults.stringArray(forKey: UserDefaultsKeys.favourites.rawValue) ?? []
    }
    
    func addToFavourites(id: String) {
        var currentFavourites = getFavourites()
        currentFavourites.append(id)
        set(key: .favourites, value: currentFavourites)
    }
    
    func removeFromFavourites(id: String) {
        var currentFavourites = getFavourites()
        currentFavourites.removeAll(where: { $0 == id })
        set(key: .favourites, value: currentFavourites)
    }
    
    func toggleFavourites(id: String) {
        var currentFavourites = getFavourites()
        if currentFavourites.contains(where: { $0 == id }) {
            currentFavourites.removeAll(where: { $0 == id })
        } else {
            currentFavourites.append(id)
        }
        set(key: .favourites, value: currentFavourites)
    }
    
}
