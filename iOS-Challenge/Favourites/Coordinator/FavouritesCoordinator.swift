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
    case showDetails(show: Show)
    case episodeDetails(episode: Episode)
}

final class FavouritesCoordinator: NavigationCoordinator<FavouritesRoute> {
    
    init() {
        super.init(initialRoute: .favourites)
    }
    
    override func prepareTransition(for route: FavouritesRoute) -> NavigationTransition {
        switch route {
        case .favourites:
            let vc = FavouritesViewController()
            vc.bind(to: FavouritesViewModel(router: strongRouter))
            return .push(vc)

        case let .showDetails(show):
            let vc = ShowDetailsViewController()
            vc.bind(to: ShowDetailsViewModel(router: strongRouter, show: show))
            return .push(vc)

        case let .episodeDetails(episode):
            let vc = EpisodeDetailsViewController()
            vc.bind(to: EpisodeDetailsViewModel(episode: episode))
            return .present(vc)
            
        }
    }
    
}
