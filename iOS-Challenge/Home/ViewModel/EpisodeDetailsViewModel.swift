//
//  EpisodeDetailsViewModel.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import RxSwift
import Action
import RxCocoa
import XCoordinator

final class EpisodeDetailsViewModel {
    
    var router: StrongRouter<HomeRoute>
    
    var episode: Episode
    
    init(router: StrongRouter<HomeRoute>, episode: Episode) {
        self.router = router
        self.episode = episode
    }
        
}
