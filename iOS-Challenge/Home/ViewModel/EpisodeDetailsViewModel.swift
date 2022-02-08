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
    
    var episode: Episode
    
    init( episode: Episode) {
        self.episode = episode
    }
        
}
