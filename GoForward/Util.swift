//
//  Util.swift
//  GoForward
//
//  Created by Ho Le Minh Thach on 25/08/2022.
//

import Foundation

let dataKey = "SaveData"

extension String {
    /// This function will trim the whitespace and newline on leading and trailling of a string
    /// - Parameter characterSet: the character set that will be trim - by default is the whitespace and newline
    /// - Returns: a string that has trimmed
    func trim(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        trimmingCharacters(in: characterSet)
    }
}
