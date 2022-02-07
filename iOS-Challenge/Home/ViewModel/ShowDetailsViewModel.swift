//
//  ShowDetailsViewModel.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import RxSwift
import Action
import RxCocoa
import XCoordinator

final class ShowDetailsViewModel {
    
    var router: StrongRouter<HomeRoute>
    
    let showsService = ShowService()
    
    var show: Show
    var seasons: [Int] = []
    let episodesSubject = PublishSubject<[Episode]>()
    
    let disposeBag = DisposeBag()
    
    init(router: StrongRouter<HomeRoute>, show: Show) {
        self.router = router
        self.show = show
        getEpisodesAction.execute(show.id)
        
        episodesSubject.subscribe(onNext: { [weak self] episodes in
            self?.seasons = episodes.map { $0.season ?? 0 } .removingDuplicates()
        }).disposed(by: disposeBag)
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
    
    lazy var goToEpisodeDetailsAction = Action<Episode?, Void> { [weak self] episode in
        guard let self = self else { return Observable.empty() }
        guard let episode = episode else { return Observable.empty() }
        return self.router.rx.trigger(.episodeDetails(episode: episode))
    }
    
}
