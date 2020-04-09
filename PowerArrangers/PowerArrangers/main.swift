//
//  main.swift
//  PowerArrangers
//
//  Created by Ivan Ruiz Monjo on 09/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let length = 5

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

func missingLetter(combination: [String]) -> String {
    let allLetters = ["A", "B", "C", "D", "E"]
    for i in allLetters.indices {
        let letter = allLetters[i]
        if !combination.contains(letter) {
            return letter
        }
    }
    return ""
}

func minIndex(from arr: [Int], without letters: [String]) -> Int {
    let notIncluding = letters.map { position($0) }
    var min = Int.max
    var index = 0
    arr.enumerated().forEach {
        if $0.element < min && !notIncluding.contains($0.offset) {
            min = $0.element
            index = $0.offset
        }
    }
    return index
}
func factorial(_ n: Int) -> Int {
  return (1...n).reduce(1, *)
}

let both = readLine()!.split(separator: " ").map(String.init)
let numberOfCases = Int(both[0])!
var maxRetries = Int(both[1])!

func solve(i: Int) {
    var combination = [String]()
    var indexes = [Int]()
    for i in stride(from: 1, to: factorial(length) * length - length, by: length) {
        indexes.append(i)
    }
    repeat {
        var letters = [Int](repeating: 0, count: length)
        var indexesByLetters = [[Int]](repeating: [], count: length)
        for i in indexes {
            print(i)
            fflush(stdout)
            let letter = readLine()!
            letters[position(letter)] += 1
            indexesByLetters[position(letter)].append(i)
        }
        let idx = minIndex(from: letters, without: combination)
        combination.append(letter(from: idx))
        indexes = indexesByLetters[idx].map { $0 + 1 }
        if indexes.count == 0 {
            combination.append(missingLetter(combination: combination))
        }
    } while combination.count < length
    
    print(combination.joined())
    fflush(stdout)
    if readLine()! != "Y" { fatalError() }
}

for i in 1...numberOfCases {
    solve(i: i)
}


