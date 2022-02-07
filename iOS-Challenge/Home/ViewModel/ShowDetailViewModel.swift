//
//  ShowDetailViewModel.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import RxSwift
import Action
import RxCocoa
import XCoordinator

final class ShowDetailViewModel {
    
    var router: StrongRouter<HomeRoute>
    
    let showsService = ShowService()
    
    var show: Show
    let episodesSubject = PublishSubject<[Episode]>()
    
    init(router: StrongRouter<HomeRoute>, show: Show) {
        self.router = router
        self.show = show
        getEpisodesAction.execute(show.id)
    }
    
    lazy var getEpisodesAction = Action<Int?, Void> { [weak self] showId in
        guard let self = self else { return Observable.empty() }
        guard let showId = showId else { return Observable.empty() }
        return self.showsService.getEpisodes(showId: showId)
            .do( onError: { error -> Void in
                debugPrint(error.localizedDescription)
                return
            })
            .asObservable()
            .flatMap { response -> Observable<Void> in
                self.episodesSubject.onNext(response)
                return Observable.empty()
            }
    }
    
}
