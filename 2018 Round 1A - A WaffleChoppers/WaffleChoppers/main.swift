//
//  main.swift
//  WaffleChoppers
//
//  Created by Ivan Ruiz Monjo on 30/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
typealias Matrix = [[String]]

func readWaffle(r: Int, c: Int) -> Matrix {
    var output = Matrix()
    for _ in 0..<r {
        let row = readLine()!.map { String($0) }
        output.append(row)
    }
    return output
}

func checkMatrix(_ matrix: Matrix, withHRange range: ClosedRange<Int>, totalChocolate: Int) -> Bool {
    var total = 0
    for i in range {
        for j in 0..<matrix.first!.count {
            if matrix[i][j] == "@" { total += 1 }
        }
    }
    return total == totalChocolate
}

func checkMatrix(_ matrix: Matrix, withVRange range: ClosedRange<Int>, totalChocolate: Int) -> Bool {
    var total = 0
    for j in range {
        for i in 0..<matrix.count {
            if matrix[i][j] == "@" { total += 1 }
        }
    }
    return total == totalChocolate
}




func isPossible(matrix: Matrix, hCuts: [Int], rCuts: [Int]) -> Bool {
    let newHCuts: [Int] = [0] + hCuts + [matrix.count]
    var hRanges = [ClosedRange<Int>]()
    for i in 0..<newHCuts.count - 1 {
        hRanges.append(newHCuts[i]...newHCuts[i+1])
    }
    var totalsH = [Int](repeating: 0, count: hRanges.count)

    for hRange in hRanges.enumerated() {
        for i in hRange.element.lowerBound..<hRange.element.upperBound {
            for j in 0..<matrix.first!.count {
                if matrix[i][j] == "@" {
                    totalsH[hRange.offset] += 1
                }
            }
        }
    }

    if let firstH = totalsH.first {
        for i in totalsH.indices {
            if totalsH[i] != firstH {
                return false
            }
        }
    }
    return true
}

func getTotalChocolate(_ matrix: Matrix) -> Int {
    var total = 0
    for row in matrix.indices {
        for col in matrix[row].indices {
            if matrix[row][col] == "@" {
                total += 1
            }
        }
    }
    return total
}

func checkMatrix(_ matrix: Matrix, hasNChoco: Int, hRange: ClosedRange<Int>, vRange: ClosedRange<Int>) -> Bool {
    var total = 0
    for i in hRange {
        for j in vRange {
            if matrix[i][j] == "@" {
                total += 1
            }
        }
    }
    return total == hasNChoco
}

func solve(caseNumber: Int) {
    let both =  readLine()!.split(separator: " ").map { Int($0)! }
    let r = both[0]
    let c = both[1]
    let h = both[2]
    let v = both[3]
    let matrix = readWaffle(r: r, c: c)
    let totalChocolate = getTotalChocolate(matrix)
    guard totalChocolate > 0 else {
        print("Case #\(caseNumber): POSSIBLE")
        return
    }
    guard totalChocolate %  (h + 1) == 0  &&  totalChocolate % (v + 1) == 0 else {
        print("Case #\(caseNumber): IMPOSSIBLE")
        return
    }
    let chocolateInH = totalChocolate / (h + 1)
    let chocolateInV = totalChocolate / (v + 1)

    var lowerBound = 0
    var totalHPositives = 0
    var hRanges = [ClosedRange<Int>]()
    for i in 0..<matrix.count {
        if checkMatrix(matrix, withHRange: lowerBound...i, totalChocolate: chocolateInH) {
            hRanges.append(lowerBound...i)
            totalHPositives += 1
            lowerBound = i + 1
        }
    }
    guard totalHPositives == h + 1 else {
        print("Case #\(caseNumber): IMPOSSIBLE")
        return
    }

    lowerBound = 0
    var totalVPositives = 0
    var vRanges = [ClosedRange<Int>]()
    for i in 0..<matrix.first!.count {
        if checkMatrix(matrix, withVRange: lowerBound...i, totalChocolate: chocolateInV) {
            vRanges.append(lowerBound...i)
            totalVPositives += 1
            lowerBound = i + 1
        }
    }
    guard totalVPositives == v + 1 else {
        print("Case #\(caseNumber): IMPOSSIBLE")
        return
    }


    guard (chocolateInH % (v + 1) == 0) && (chocolateInV % (h + 1) == 0) else {
        print("Case #\(caseNumber): IMPOSSIBLE")
        return
    }
    let nChocoPerSegment = chocolateInH / (v + 1)
    for hRange in hRanges {
        for vRange in vRanges {
            if !checkMatrix(matrix, hasNChoco: nChocoPerSegment, hRange: hRange, vRange: vRange) {
                print("Case #\(caseNumber): IMPOSSIBLE")
                return
            }
        }
    }
    print("Case #\(caseNumber): POSSIBLE")

}

for i in 1...Int(readLine()!)! {
    solve(caseNumber: i)
}

