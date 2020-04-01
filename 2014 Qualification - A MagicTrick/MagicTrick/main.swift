//
//  main.swift
//  MagicTrick
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let numberOfCases = Int(readLine()!)!

func row() -> [String] {
    let answer = Int(readLine()!)!
    var valueToReturn = [String]()
    
    for x in 1...4 {
        let row = readLine()!
        if x == answer {
            valueToReturn = row.split(separator: " ").map { $0.description }
        }
    }
    return valueToReturn
}

for i in 1...numberOfCases {
    let result = Set(row()).intersection(Set(row()))
    
    let text = "Case #\(i): "
    switch result.count {
    case 1: print("\(text)\(result.first!)")
    case 0: print("\(text)Volunteer cheated!")
    default: print("\(text)Bad magician!")
    }
}
