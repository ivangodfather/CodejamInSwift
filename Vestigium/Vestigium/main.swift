//
//  main.swift
//  Vestigium
//
//  Created by Ivan Ruiz Monjo on 04/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let t = Int(readLine()!)!

func trace(_ matrix: [[Int]]) -> Int {
    var total = 0
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if i == j {
                total += matrix[i][j]
            }
        }
    }
    return total
}

func repeatedValues(_ matrix: [[Int]]) -> (Int, Int) {
    var rows = 0
    var cols = 0
    for i in 0..<matrix.count {
        let row = matrix[i]
        let elems = Set(row)
        if row.count != elems.count {
            rows += 1
        }
    }
    for j in 0..<matrix.count {
        var colum = [Int]()
        for i in 0..<matrix.count {
            let elem = matrix[i][j]
            colum.append(elem)
        }
        if colum.count != Set(colum).count {
            cols += 1
        }
    }
    return (rows, cols)
}

for i in 1...t {
    let size = Int(readLine()!)!
    var matrix = [[Int]]()
    for _ in 0..<size {
        let row = readLine()!.split(separator: " ").map(String.init).map { Int($0)! }
        matrix.append(row)
    }
    let (rows, cols) = repeatedValues(matrix)
    print("Case #\(i): \(trace(matrix)) \(rows) \(cols)")
}

