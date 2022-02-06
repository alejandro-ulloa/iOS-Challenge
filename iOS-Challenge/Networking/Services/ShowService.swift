//
//  ShowService.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-05.
//

import Foundation
import Moya
import RxSwift


protocol ShowServiceProtocol {
    func getShows(page: Int) -> Single<[Show]>
    func getShowDetail(showId: Int) -> Single<Show>
    func getEpisodes(showId: Int) -> Single<[Episode]>
}

class ShowService: ShowServiceProtocol {
    
    private let provider = MoyaProvider<NetworkManagerProvider>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    func getShows(page: Int) -> Single<[Show]> {
        return provider.rx.request(.getShows(page: page))
            .map([Show].self)
    }
    
    func getShowDetail(showId: Int) -> Single<Show> {
        return provider.rx.request(.getShowDetails(showId: showId))
            .map(Show.self)
    }
    
    func getEpisodes(showId: Int) -> Single<[Episode]> {
        return provider.rx.request(.getEpisodes(showId: showId))
            .map([Episode].self)
    }
}
