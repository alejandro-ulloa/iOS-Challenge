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
    
    
    func htmlTransform() -> String {
        var transformedString = self
        transformedString = transformedString.replacingOccurrences(of: "\r", with: "")
        transformedString = transformedString.replacingOccurrences(of: "\n", with: "")
        transformedString = transformedString.replacingOccurrences(of: "<b>", with: "")
        transformedString = transformedString.replacingOccurrences(of: "</b>", with: "")
        transformedString = transformedString.replacingOccurrences(of: "<p>", with: "")
        transformedString = transformedString.replacingOccurrences(of: "</li>", with: "")
        transformedString = transformedString.replacingOccurrences(of: "<ol>", with: "\n")
        transformedString = transformedString.replacingOccurrences(of: "</p>", with: "\n")
        transformedString = transformedString.replacingOccurrences(of: "</ol>", with: "\n")
        transformedString = transformedString.replacingOccurrences(of: "<ul>", with: "\n")
        transformedString = transformedString.replacingOccurrences(of: "</ul>", with: "\n")
        transformedString = transformedString.replacingOccurrences(of: "<br>", with: "")
        transformedString = transformedString.replacingOccurrences(of: "<br/>", with: "\n")
        transformedString = transformedString.replacingOccurrences(of: "<li>", with: " • ")
        return transformedString
    }
}
