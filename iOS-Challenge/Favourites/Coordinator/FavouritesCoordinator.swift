//
//  FavouritesCoordinator.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import Foundation
import XCoordinator

enum FavouritesRoute: Route {
    case favourites
}

final class FavouritesCoordinator: NavigationCoordinator<FavouritesRoute> {
    
    init() {
        super.init(initialRoute: .favourites)
    }
    
    override func prepareTransition(for route: FavouritesRoute) -> NavigationTransition {
        switch route {
        case .favourites:
            let vc = FavouritesViewController()
            vc.bind(to: FavouritesViewModel())
            return .push(vc)
            
        }
    }
    
}
