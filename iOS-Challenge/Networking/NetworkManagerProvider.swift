//
//  NetworkManagerProvider.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-05.
//

import Foundation
import Moya

enum NetworkManagerProvider {
    case getShows(page: Int)
    case getShowDetails(showId: Int)
    case getEpisodes(showId: Int)
}

extension NetworkManagerProvider: TargetType {
    
    var baseURL: URL {
        
        return URL(string: buildURL())!
    }
    
    var path: String {
        switch self {
        case .getShows:
            return "/shows"
        case let .getShowDetails(showId):
            return "/shows/\(showId)"
        case let .getEpisodes(showId):
            return "/shows/\(showId)/episodes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getShows, .getShowDetails, .getEpisodes:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case let .getShows(page):
            return .requestParameters(parameters: ["page" : page], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
            
        default:
            return .requestPlain
        
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}


private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension NetworkManagerProvider {
    func buildURL() -> String {
        return "http://api.tvmaze.com"
    }
}
