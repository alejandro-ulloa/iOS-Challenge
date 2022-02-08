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

    func setDecodedShows(shows: [Show]) {
        do {
            let encodedData = try JSONEncoder().encode(shows)
            UserDefaultsManager.shared.set(key: .favourites, value: encodedData)
        } catch {
            debugPrint("Error encoding response")
        }
    }

    func remove(key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }

    func get(key: UserDefaultsKeys) -> Any? {
      return defaults.object(forKey: key.rawValue)
    }
    
    func getFavourites() -> [Show] {
        var currentFavourites: [Show] = []
        do {
          let encodedData = get(key: .favourites) as? Data
            currentFavourites = try JSONDecoder().decode([Show].self, from: encodedData ?? Data())
        } catch {
          debugPrint("fetchMegaDiscounts - Failed to decode mega discounts")
        }

        return currentFavourites
    }
    
    func addToFavourites(show: Show) {
        var currentFavourites = getFavourites()
        currentFavourites.append(show)
        setDecodedShows(shows: currentFavourites)
    }
    
    func removeFromFavourites(id: Int) {
        var currentFavourites = getFavourites()
        currentFavourites.removeAll(where: { $0.id == id })
        setDecodedShows(shows: currentFavourites)
    }
    
    func toggleFavourites(show: Show) {
        var currentFavourites = getFavourites()
        if currentFavourites.contains(where: { $0.id == show.id }) {
            currentFavourites.removeAll(where: { $0.id == show.id })
        } else {
            currentFavourites.append(show)
        }
        setDecodedShows(shows: currentFavourites)
    }
    
}
