//
//  main.swift
//  Indicium
//
//  Created by Ivan Ruiz Monjo on 05/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation


func allTupelsFrom<T>(_ elements: [T], length: Int,
                      combinedWith prefix : [T] = []) -> [[T]] {
    if length == 0 { return [prefix] }
    var result : [[T]] = []
    for e in elements {
        result += allTupelsFrom(elements, length: length-1, combinedWith: prefix + [e])
    }
    return result
}

func arrayWith(n: Int, k : Int) -> [Int] {
    let startElement = k / n
    var remainder = k % n
    var output = [Int](repeating: startElement, count: n)
    repeat {
        let randomNumberToSubstract: Int
        if remainder == 0 {
            randomNumberToSubstract = 0
        } else {
            randomNumberToSubstract = Int.random(in: 1...remainder)
        }
        remainder -= randomNumberToSubstract
        let positionToAdd = Int.random(in: 0..<n)
        output[positionToAdd] += randomNumberToSubstract
    } while remainder != 0
    return output.shuffled()
}

func hasRepeatedColOrRow(matrix: [[Int]]) -> Bool {
    for row in matrix {
        if Set(row).count != row.count {
            return true
        }
    }
    for j in 0..<matrix.count {
        var col = [Int]()
        for i in 0..<matrix.count {
            col.append(matrix[i][j])
        }
        if Set(col).count != col.count {
            return true
        }
    }
    return false
}

func validValuesInIndex(for matrix: [[Int]], in position: (Int, Int) , with elements: Set<Int>) -> [Int] {
    var invalidValues = matrix[position.0]
    for i in 0..<matrix.count {
        invalidValues.append(matrix[i][position.1])
    }
    
    return elements.filter { !invalidValues.contains($0) }
}

func fillWithRandomValidValues(_ elements: Set<Int>, matrix: [[Int]]) -> [[Int]]? {
    var filledMatrix = matrix
    for i in 0..<matrix.count {
        for j in 0..<matrix.count {
            if filledMatrix[i][j] == 0 {
                if let random = validValuesInIndex(for: filledMatrix, in: (i, j), with: elements).randomElement() {
                    filledMatrix[i][j] = random

                } else {
                    return nil
                }
            }
        }
    }
    return filledMatrix
}

func printOutput(t: Int, matrix: [[Int]]?) {
    var text = "Case #\(t): "
    text += matrix == nil ? "IMPOSSIBLE" : "POSSIBLE"
    print(text)
    if let matrix = matrix {
        matrix.forEach { row in
            print(row.map { String($0) }.joined(separator: " "))
        }
    }
}

let t = Int(readLine()!)!

func solve(t: Int, n: Int, k: Int) {
    let retries = 10
    var possibleMatrixs = [[[Int]]]()
    for _ in 0..<retries {
        let trace = arrayWith(n: n, k: k)
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        trace.enumerated().forEach { arg in
            matrix[arg.offset][arg.offset] = arg.element
        }
        possibleMatrixs.append(matrix)
        let elements = Set((1...n).map { $0 })
        var filledMatrix: [[Int]]? = nil
        var retriesFillMatrix = 4
        repeat {
            filledMatrix = fillWithRandomValidValues(elements, matrix: matrix)
            retriesFillMatrix -= 1
        } while retriesFillMatrix > 0 && filledMatrix == nil
        if let filledMatrix = filledMatrix {
            printOutput(t: t, matrix: filledMatrix)
            return
        }
    }
    printOutput(t: t, matrix: nil)
}



for t in 1...t {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    solve(t: t, n: both[0], k: both[1])
}
