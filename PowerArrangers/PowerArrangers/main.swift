//
//  main.swift
//  PowerArrangers
//
//  Created by Ivan Ruiz Monjo on 09/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func position(_ letter: String) -> Int {
    switch letter {
    case "A": return 0
    case "B": return 1
    case "C": return 2
    case "D": return 3
    default: return 4
    }
}

func letter(from index: Int) -> String {
    switch index {
    case 0: return "A"
    case 1: return "B"
    case 2: return "C"
    case 3: return "D"
    default: return "E"
    }
}

func minIndex(from arr: [Int]) -> Int {
    var min = 0
    var index = 0
    arr.enumerated().forEach {
        if $0.element < min {
            min = $0.element
            index = $0.offset
        }
    }
    return index
}

let both = readLine()!.split(separator: " ").map(String.init)
let numberOfCases = Int(both[0])!
var maxRetries = Int(both[1])!

func solve(i: Int) {
    var combination = [String]()
    var indexes = [Int]()
    for i in stride(from: 1, to: 595, by: 5) {
        indexes.append(i)
    }
    repeat {
        var letters = [Int](repeating: 0, count: 5)
        var indexesByLetters = [[Int]](repeating: [], count: 5)
        for i in indexes {
            print(i)
            fflush(stdout)
            let letter = readLine()!
            letters[position(letter)] += 1
            indexesByLetters[position(letter)].append(i)
        }
        let idx = minIndex(from: letters)
        combination.append(letter(from: idx))
        indexes = indexesByLetters[idx].map { $0 + 1 }
    } while combination.count < 5
    print("Case #\(i): \(combination)")
}

for i in 1...numberOfCases {
    solve(i: i)
}



