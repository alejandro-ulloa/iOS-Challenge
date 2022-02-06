//
//  Show.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-05.
//

import Foundation

final class Show: Codable {
    
    let id: Int?
    let url: String?
    let name: String?
    let image: Image?
    let genres: [String]?
    let schedule: Schedule?
    let summary: String?
    
}
