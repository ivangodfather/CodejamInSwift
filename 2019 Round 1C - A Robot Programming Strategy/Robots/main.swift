//
//  main.swift
//  Robots
//
//  Created by Ivan Ruiz Monjo on 08/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

private func getWinner(_ char: Character) -> Character {
    if char == "R" {
        return "P"
    }
    if char == "P" {
        return "S"
    }
    return "R"
}

func solve(_ i: Int, _ countAdvesaries: Int) {
    var responses =  [[Character]]()
    for _ in 1...countAdvesaries {
        responses.append(readLine()!.map(Character.init))
    }
    var winnerSequence = [Character]()
    var index = 0
    while !responses.isEmpty {
        let firstAnswerAdversaries = responses.map { $0[index % $0.count] }
        let setFirstAnswerAdversaries = Set(firstAnswerAdversaries)
        if setFirstAnswerAdversaries.count > 2 {
            print("Case #\(i): IMPOSSIBLE")
            return
        } else if setFirstAnswerAdversaries.count == 1 {
            winnerSequence.append(getWinner(setFirstAnswerAdversaries.first!))
            print("Case #\(i): \(winnerSequence.map(String.init).joined())")
            return
        } else {
            if setFirstAnswerAdversaries.contains("R") &&  setFirstAnswerAdversaries.contains("P") {
                winnerSequence.append("P")
                let losers = firstAnswerAdversaries.enumerated().filter { $0.element == "R" }.map { $0.offset }
                losers.sorted { $0 > $1 }.forEach { responses.remove(at: $0) }
            }
            if setFirstAnswerAdversaries.contains("R") &&  setFirstAnswerAdversaries.contains("S") {
                winnerSequence.append("R")
                let losers = firstAnswerAdversaries.enumerated().filter { $0.element == "S" }.map { $0.offset }
                losers.sorted { $0 > $1 }.forEach { responses.remove(at: $0) }
            }
            if setFirstAnswerAdversaries.contains("S") &&  setFirstAnswerAdversaries.contains("P") {
                winnerSequence.append("S")
                let losers = firstAnswerAdversaries.enumerated().filter { $0.element == "P" }.map { $0.offset }
                losers.sorted { $0 > $1 }.forEach { responses.remove(at: $0) }
            }
        }

        index += 1
    }
    print("Case #\(i): \(winnerSequence)")

}


let numberOfCases = Int(readLine()!)!

for i in 1...numberOfCases {
    let a = Int(readLine()!)!
    solve(i, a)
}
