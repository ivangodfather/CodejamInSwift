//
//  main.swift
//  AmpleSyrup
//
//  Created by Ivan Ruiz Monjo on 26/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Pancake: Equatable, Hashable, Comparable {
    static func < (lhs: Pancake, rhs: Pancake) -> Bool {
        return lhs.topSurface < rhs.topSurface
    }
    
    let uuid = UUID()
    let r: Double
    let h: Double
    
    var topSurface: Double { return Double.pi * r * r }
    var lateralSurface: Double { return 2 * Double.pi * r * h }
}

func readPancakes(n: Int) -> [Pancake] {
    var output = [Pancake]()
    output.reserveCapacity(n)
    for _ in 0..<n {
        let tuple = readLine()!.split(separator: " ").map { Double($0)! }
        let r = tuple[0]
        let h = tuple[1]
        output.append(Pancake(r: r, h: h))
    }
    return output
}

func areaFromStack(arr: [Pancake]) -> Double {
    var surface = arr[0].topSurface
    surface += arr.reduce(0) { result, pancake in
        return result + pancake.lateralSurface
    }
    return surface
}

func solve(caseNumber: Int) {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    let n = both[0]
    let k = both[1]
    let pancakes = readPancakes(n: n).sorted { $0.r < $1.r}
    var combinations = [[Pancake]]()
    for pankcake in pancakes.enumerated() {
        var pancakesByContribution = pancakes.sorted { $0.lateralSurface < $1.lateralSurface }
        combinations.append([pankcake.element]) // adds all bases to possible combinations
        while !pancakesByContribution.isEmpty && combinations[pankcake.offset].count != k {
            let m = pancakesByContribution.popLast()!
            if m.r <= pankcake.element.r && m != pankcake.element {
                combinations[pankcake.offset].append(m)
                
            }
        }
    }
    
    let maxSurface = combinations.reduce(0) { total, combination in
        return max(total, areaFromStack(arr: combination))
    }
    
    print("Case #\(caseNumber): \(maxSurface)")
}

let numberOfCases = Int(readLine()!)!

for caseNumber in 1...numberOfCases {
    solve(caseNumber: caseNumber)
}


