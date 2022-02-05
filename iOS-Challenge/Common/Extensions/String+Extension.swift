//
//  String+Extension.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-05.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "challenge", bundle: Bundle.main, value: "", comment: "")
    }
    
}
