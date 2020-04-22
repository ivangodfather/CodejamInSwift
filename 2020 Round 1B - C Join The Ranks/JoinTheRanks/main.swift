//
//  main.swift
//  Test
//
//  Created by Ivan Ruiz Monjo on 19/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func hasValidRank(arr: [(Int, Int)]) -> Bool {
    var value = 1
    for elem in arr {
        if elem.0 == value {
        } else if elem.0 == value + 1 {
            value += 1
        } else {
            return false
        }
    }
    return true
}

func moveToFront(startIndex: Int, endIndex: Int, with arr: [(Int, Int)]) -> [(Int, Int)] {
    var output = arr
    let rangeToRemove = startIndex...endIndex
    let subArray = arr[rangeToRemove]
    output.removeSubrange(rangeToRemove)
    output.insert(contentsOf: subArray, at: 0)
    return output
}

func moveToBack(startIndex: Int, endIndex: Int, with arr: [(Int, Int)]) -> [(Int, Int)] {
    var output = arr
    let rangeToRemove = startIndex...endIndex
    let subArray = arr[rangeToRemove]
    output.removeSubrange(rangeToRemove)
    output.insert(contentsOf: subArray, at: output.endIndex)
    return output
}

func createDeck(ranks: Int, suits: Int) -> [(Int, Int)] {
    var output = [(Int, Int)](repeating: (0, 0), count: ranks * suits)
    for suit in 1...suits {
        for rank in 1...ranks {
            let index = ((suit - 1) * ranks) + rank - 1
            output[index] = (rank, suit)
        }
    }
    return output
}

func nextFirstIndex(arr: [(Int, Int)]) -> Int? {
    let valueToSearch = arr.first!.0
    var possible = false
    for i in 1...arr.count - 1 {
        let tuple = arr[i]
        if tuple.0 != valueToSearch {
            possible = true
        } else {
            if possible {
                return i
            }
        }
    }
    return nil
}

func solve(caseNumber: Int) {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    let ranks = both[0]
    let suits = both[1]
    var deck = createDeck(ranks: ranks, suits: suits)
    var moves = 0
    var movements = [(Int, Int)]()
    repeat {
        guard let nextFirst = nextFirstIndex(arr: deck) else {
            print("Case #\(caseNumber): \(moves)")
            movements.forEach {
                print($0.0.description + " " + $0.1.description)
            }
            return
        }
        let rightIndex = nextFirst.advanced(by: 1)
        if deck.indices ~= rightIndex {
            let right = deck[nextFirst.advanced(by: 1)].0
            let left = deck[...nextFirst].lastIndex { $0.0 == right }!
            let startIndex = left.advanced(by: 1)
            guard startIndex <= nextFirst else {
                fatalError()
            }
            moves += 1
            let movementA = deck.startIndex.distance(to: left) + 1
            let movementB = startIndex.distance(to: nextFirst) + 1
            movements.append((movementA, movementB))
            deck = moveToFront(startIndex: startIndex, endIndex: nextFirst, with: deck)
        } else {
            moves += 1
            let lastFirstI = lastFirstIndex(arr: deck)
            let movementA = lastFirstI + 1
            let movementB = deck.distance(from: lastFirstI, to: nextFirst).advanced(by: -1)
            movements.append((movementA, movementB))
            deck = moveToBack(startIndex: deck.indices.first!, endIndex: lastFirstIndex(arr: deck), with: deck)
        }
    } while true
}

func lastFirstIndex(arr: [(Int, Int)]) -> Int {
    var index = 0
    while arr[index].0 == arr[0].0 {
        index += 1
    }
    return index - 1
}

let numberOfCases = Int(readLine()!)!
for i in 1...numberOfCases {
    solve(caseNumber: i)
}

