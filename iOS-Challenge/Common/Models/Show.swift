//
//  Show.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-05.
//

import Foundation

class Show: Codable {
    
    let id: Int
    let url: String
    let name: String
    let image: Image
    
}

class Image: Codable {
    
    let medium: String
    let original: String
    
}
