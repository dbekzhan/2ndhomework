/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import Foundation

// Wait for the user to type something in the console, and return what
// they type as a String with the trailing newline character removed.
func getln() -> String {
    let stdin = FileHandle.standardInput
    var input = NSString(data: stdin.availableData, encoding: String.Encoding.utf8.rawValue)
    input = input!.trimmingCharacters(in: NSCharacterSet.newlines) as NSString
    return input! as String
}


func didAgree(toQuestion question: String) -> Bool {
    print(question + "y | n")
    let inp = getln()
    if inp.hasPrefix("y") { return true } else { return false }
}

//extension Dictionary where Value : Equatable {
//    func returnKey(forValue val: Value) -> Key? {
//        return first(where: { $1 == val })?.key
//    }
//}

