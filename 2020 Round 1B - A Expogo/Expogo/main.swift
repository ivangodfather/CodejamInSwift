//
//  main.swift
//  Expogo
//
//  Created by Ivan Ruiz Monjo on 20/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

var currentJump = -1

func addJump() -> Int {
    currentJump += 1
    return Int(pow(Double(2),Double(currentJump)))
}

func allTupelsFrom<T>(_ elements: [T], withLength k : Int,
    combinedWith prefix : [T] = []) -> [[T]] {
        if k == 0 {
            return [prefix]
        }
        var result : [[T]] = []

        for e in elements {
            result += allTupelsFrom(elements, withLength: k-1, combinedWith: prefix + [e])
        }
        return result
}

func solve(i: Int) {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    let x = both[0]
    let y = both[1]
    var availableJumps = [Int]()
    for _ in 0...4 {
        availableJumps.append(addJump())
    }
    for j in 0...8 {
        let possibilities = allTupelsFrom(["N", "S", "E", "W"], withLength: j)
        for possibility in possibilities {
            var current = (0, 0)
            possibility.forEach { direction in
                if direction == "N" {
                    current.1 += addJump()
                }
                if direction == "S" {
                    current.1 -= addJump()
                }
                if direction == "E" {
                    current.0 += addJump()
                }
                if direction == "W" {
                    current.0 -= addJump()
                }
            }
            if current.0 == x && current.1 == y {
                let path =  possibility.joined(separator: "")
                print("Case #\(i): \(path)")
                return
            }
            currentJump = -1
        }
    }
    print("Case #\(i): IMPOSSIBLE")
}


let numberOfCases = Int(readLine()!)!


for i in 1...numberOfCases {
    solve(i: i)
}
