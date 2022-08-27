/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Ho Le Minh Thach
 ID: s3877980
 Created  date: 27/08/2022
 Last modified: 27/08/2022
 Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

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
