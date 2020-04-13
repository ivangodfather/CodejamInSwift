//
//  main.swift
//  problemB
//
//  Created by Ivan Ruiz Monjo on 11/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

typealias Matrix = [[Double]]

struct Coordinate: Hashable, CustomStringConvertible {
    let row, k: Int
    
    var description: String {
        return "\(row + 1) \(k + 1)"
    }
}

func createPascalTriangle(rows: Int)-> Matrix {
    var output = Matrix()
    for r in 1...rows {
        var row = [Double]()
        for k in 1...r {
            if k == 1 || k == r {
                row.append(1)
            } else {
                let elem = output[r - 2][k - 2] + output[r - 2][k - 1]
                row.append(elem)
            }
        }
        output.append(row)
    }
    return output
}


func availableCoordinates(matrix: Matrix, from coordinate: Coordinate, alreadyVisited: [Coordinate]) -> [Coordinate] {
    var output = [Coordinate]()
    
    let coordinates: [Coordinate] = [
        Coordinate(row: coordinate.row - 1, k: coordinate.k - 1),
        Coordinate(row: coordinate.row - 1, k: coordinate.k),
        Coordinate(row: coordinate.row, k: coordinate.k - 1),
        Coordinate(row: coordinate.row, k: coordinate.k + 1),
        Coordinate(row: coordinate.row + 1, k: coordinate.k),
        Coordinate(row: coordinate.row + 1, k: coordinate.k + 1)]
    coordinates.forEach { coordinate in
        let visited = alreadyVisited.contains(where: { $0.row == coordinate.row && $0.k == coordinate.k })
        if !visited && 0..<matrix.count ~= coordinate.row {
            let row = matrix[coordinate.row]
            if 0..<row.count ~= coordinate.k {
                output.append(coordinate)
            }
        }
    }
    return output
}

extension Array where Element == Coordinate {
    func sum(matrix: Matrix) -> Double {
        var output = Double(0)
        forEach {
            output += matrix[$0.row][$0.k]
        }
        return output
    }
}

var visited = [[Coordinate]: [Coordinate]]()

func breadthFirst(n: Double, path: [Coordinate], matrix: Matrix) -> [Coordinate] {
    if path.sum(matrix: matrix) == Double(n) { return path }
    
    if visited[path] == nil {
        visited[path] = [Coordinate](repeating: Coordinate(row: 0, k: 0), count: 1)
    }
    let availableCoordiantes = availableCoordinates(matrix: matrix, from:path.last!, alreadyVisited: path + visited[path]!)
    if path.count > 500 || availableCoordiantes.isEmpty {
        var newPath = path
        newPath.removeLast()
        return breadthFirst(n: n, path: newPath, matrix: matrix)
    }
    if let randomCoordinate = availableCoordiantes.randomElement() {
        let newPath = path + [randomCoordinate]
        
        visited[path]!.append(randomCoordinate)
        
        let pathSum =  path.sum(matrix: matrix)
        if pathSum == n {
            return newPath
        } else if pathSum < n {
            return breadthFirst(n: n, path: newPath, matrix: matrix)
        } else if pathSum > n {
            return breadthFirst(n: n, path: path, matrix: matrix)
        }
    }
    fatalError("Not expected to be executed")
}

func solve(n: Double, caseNumber: Int) {
    visited = [[Coordinate]: [Coordinate]]()
    let coordinates = breadthFirst(n: n, path: [Coordinate(row: 0, k: 0)], matrix: createPascalTriangle(rows: 2000))
    print("Case #\(caseNumber):")
    coordinates.forEach { print($0.description) }
}

let numberOfCases = Int(readLine()!)!

for caseNumber in 1...numberOfCases {
    let n = Double(readLine()!)!
    solve(n: n, caseNumber: caseNumber)
}
