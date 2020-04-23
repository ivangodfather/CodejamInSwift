//
//  main.swift
//  SavingTheUniverseAgain
//
//  Created by Ivan Ruiz Monjo on 23/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func totalDamage(from program: [String]) -> Int {
    var damageFactor = 1
    var totalDamange = 0
    for i in program.indices {
        let instruction = program[i]
        if instruction == "C" {
            damageFactor *= 2
        } else {
            totalDamange += damageFactor
        }

    }
    return totalDamange
}

func solve(caseNumber: Int) {
    let both = readLine()!.split(separator: " ").map(String.init)
    let shieldPower = Int(both[0])!
    var program = both[1].map(String.init)
    var hacks = 0
    while totalDamage(from: program) > shieldPower {
        var modified = false
        for i in stride(from: program.count - 1, to: 0, by: -1) {
            let right = program[i]
            let left = program[i - 1]
            if left == "C" && right == "S"  {
                program.swapAt(i, i - 1)
                modified = true
                hacks += 1
                break
            }
        }
        if !modified {
            print("Case #\(caseNumber): IMPOSSIBLE")
            return
        }
    }
    print("Case #\(caseNumber): \(hacks.description)")
}

let numberOfCases = Int(readLine()!)!

for i in 1...numberOfCases {
    solve(caseNumber: i)
}
