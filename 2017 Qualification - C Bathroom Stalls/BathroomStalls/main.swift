//
//  main.swift
//  BathroomStalls
//
//  Created by Ivan Ruiz Monjo on 24/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func solve(caseNumber: Int) {
    let tuple = readLine()!.split(separator: " ").map { Int($0)! }
    let stalls = tuple[0]
    var persons = tuple[1]
    if persons > stalls * 2 / 3 {
        print("Case #\(caseNumber): \(0) \(0)")
        return
    }
    var heap = Heap<ClosedRange<Int>>(sort: { left, right -> Bool in
        if right.lowerBound.distance(to: right.upperBound) > left.lowerBound.distance(to: left.upperBound)  {
            return false
        }
        return true
    })
    let initialRange = 0...stalls - 1
    heap.insert(initialRange)
    var maxPositions = initialRange.lowerBound.distance(to: initialRange.upperBound)
    var minPositions = (initialRange.lowerBound + initialRange.upperBound) / 2
    while persons > 0 {
        persons -= 1
        let removedRange = heap.remove()!
        let middle = (removedRange.upperBound + removedRange.lowerBound) / 2

        if removedRange.lowerBound <= middle - 1  {
            let left = removedRange.lowerBound...middle - 1
            heap.insert(left)
            minPositions = removedRange.lowerBound.distance(to: middle)
        } else {
            minPositions = 0
        }

        if middle + 1 <= removedRange.upperBound {
            let right = middle + 1...removedRange.upperBound
            heap.insert(right)
            maxPositions = (middle).distance(to: removedRange.upperBound)
        } else {
            maxPositions = 0
        }

    }
    print("Case #\(caseNumber): \(maxPositions) \(minPositions)")
}


let numberOfCases = Int(readLine()!)!

for caseNumber in 1...numberOfCases {
    solve(caseNumber: caseNumber)
}

