//
//  HomeViewModel.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-02.
//

import RxSwift
import Action
import RxCocoa


class HomeViewModel {
    
    let showsService = ShowService()
    
    var shows: [Show] = []
    var currentPage = 0
    let showsSubject = PublishSubject<[Show]>()
    
    init() {
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
    
    func getNextPage() {
        currentPage = currentPage + 1
        getShowsAction.execute(currentPage)
    }
}
