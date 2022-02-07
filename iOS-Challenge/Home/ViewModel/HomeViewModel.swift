//
//  HomeViewModel.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-02.
//

import RxSwift
import Action
import RxCocoa
import XCoordinator

final class HomeViewModel {
    
    var router: StrongRouter<HomeRoute>
    
    let showsService = ShowService()
    
    var shows: [Show] = []
    var currentPage = 0
    let showsSubject = PublishSubject<[Show]>()
    
    let disposeBag = DisposeBag()
    
    init(router: StrongRouter<HomeRoute>) {
        self.router = router
        getShowsAction.execute(currentPage)
    }
    
    lazy var getShowsAction = Action<Int, Void> { [weak self] page in
        guard let self = self else { return Observable.empty() }
        return self.showsService.getShows(page: page)
            .do( onError: { error -> Void in
                debugPrint(error.localizedDescription)
                return
            })
            .asObservable()
            .flatMap { response -> Observable<Void> in
                self.shows.append(contentsOf: response)
                self.showsSubject.onNext(self.shows)
                return Observable.empty()
            }
    }
    
    lazy var searchShowsAction = Action<String, Void> { [weak self] query in
        guard let self = self else { return Observable.empty() }
        if query.isEmpty {
            self.showsSubject.onNext(self.shows)
            return Observable.empty()
        }
        return self.showsService.searchShows(query: query)
            .do( onError: { error -> Void in
                debugPrint(error.localizedDescription)
                return
            })
            .asObservable()
            .flatMap { response -> Observable<Void> in
                self.showsSubject.onNext(response.map{ $0.show })
                return Observable.empty()
            }
    }
    
    lazy var goToShowDetailsAction = Action<Show?, Void> { [weak self] show in
        guard let self = self else { return Observable.empty() }
        guard let show = show else { return Observable.empty() }
        return self.router.rx.trigger(.showDetails(show: show))
    }
    
    func getNextPage() {
        currentPage = currentPage + 1
        getShowsAction.execute(currentPage)
    }
}
