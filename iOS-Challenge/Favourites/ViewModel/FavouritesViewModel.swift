//
//  FavouritesViewModel.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-07.
//

import RxSwift
import Action
import RxCocoa
import XCoordinator

final class FavouritesViewModel {

    var router: StrongRouter<FavouritesRoute>

    let showsService = ShowService()

    var shows: [Show] = []
    var currentPage = 0
    let showsSubject = PublishSubject<[Show]>()

    let semaphore = DispatchSemaphore(value: 1)
    let disposeBag = DisposeBag()

    init(router: StrongRouter<FavouritesRoute>) {
        self.router = router
        loadFavourites()
    }

    lazy var goToShowDetailsAction = Action<Show?, Void> { [weak self] show in
        guard let self = self else { return Observable.empty() }
        guard let show = show else { return Observable.empty() }
        return self.router.rx.trigger(.showDetails(show: show))
    }

    func loadFavourites() {
        showsSubject.onNext(UserDefaultsManager.shared.getFavourites())
    }
}
