//
//  main.swift
//  CoreTraining
//
//  Created by Ivan Ruiz Monjo on 30/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func findMinIndexes(arr: [Double]) -> [Int] {
    var output = [Int]()
    output.reserveCapacity(arr.count)
    var min = Double.greatestFiniteMagnitude
    for i in arr.indices {
        if arr[i] < min {
            min = arr[i]
            output = [Int]()
            output.append(i)
        } else if arr[i] == min {
            output.append(i)
        }
    }
    return output
}

func minInArray(arr: [Double]) -> Int {
    var output = 0
    var min = Double.greatestFiniteMagnitude
    for i in arr.indices {
        if arr[i] < min {
            min = arr[i]
            output = i
        }
    }
    return output
}

func solve(caseNumber: Int) {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    let n = both[0]
    let k = Double(both[1])
    var u = Double(readLine()!)!
    var p = readLine()!.split(separator: " ").map { Double($0)! }

    while (u > 0) {
        let min1 = p.min()!
        let minCount = p.filter { $0 - min1 < 1e-06 }.count

        if (minCount == n) {
            for i in 0...n-1 {
                p[i] += u / Double(n)
            }
            u = 0.0

        } else {
            let min2 = p.filter { $0 > min1 + 1e-06 }.min()!

            let toAdd = min(Double(minCount) * (min2 - min1), u)
            for i in 0...n-1 {
                if (p[i] - min1 < 1e-06) {
                    p[i] += toAdd / Double(minCount)
                }
            }
            u -= toAdd
        }
    }
    let res = p.reduce(1, *)
    print("Case #\(caseNumber): \(res)")
}

for i in 1...Int(readLine()!)! {
    solve(caseNumber: i)
}
