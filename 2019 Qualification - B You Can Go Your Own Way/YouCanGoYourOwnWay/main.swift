//
//  main.swift
//  YouCanGoYourOwnWay
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let testCases = Int(readLine()!)!

func transform(_ x: Character) -> Character {
    if x == "S" { return "E" }
    return "S"
}
for i in 1...testCases {
    let _ = Int(readLine()!)!
    let path = readLine()!
    let result = String(path.map(transform))
    print("Case #\(i): \(result)")
}

