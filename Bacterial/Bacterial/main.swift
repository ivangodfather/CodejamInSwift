//
//  main.swift
//  Bacterial
//
//  Created by Ivan Ruiz Monjo on 09/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
typealias Matrix = [[Character]]


func availableCoordinates(from matrix: [[Character]]) -> [(Int, Int)] {
    var output = [(Int, Int)]()
    matrix.enumerated().forEach { rowIndex, row in
        row.enumerated().forEach { colIndex, col in
            if matrix[rowIndex][colIndex] == "." {
                output.append((rowIndex, colIndex))
            }
        }
    }
    return output
}

func validElements(for coordinate: (row: Int, col: Int), with matrix: Matrix) -> [Character] {
    var output = [Character]()
    let left = max(coordinate.col - 1, 0)
    let right = min(coordinate.col + 1, matrix.first!.count - 1)
    let leftElement = matrix[coordinate.row][left]
    let rightElement = matrix[coordinate.row][right]
    if leftElement != "#" && rightElement != "#" {
        output.append("H")
    }
    let top = max(0, coordinate.row - 1)
    let bottom = min(matrix.count - 1, coordinate.row + 1)
    let topElement = matrix[top][coordinate.col]
    let bottomElement = matrix[bottom][coordinate.col]
    if topElement != "#" && bottomElement != "#" {
        output.append("V")
    }
    
    return output
}

func findValidIndexes(row: [Character], position: Int) -> ClosedRange<Int> {
    var leftIndex = position
    var rightIndex = position
    
    for i in stride(from: position, to: -1, by: -1) {
        if row[i] == "." {
            leftIndex = i
        } else {
            break
        }
    }
    for i in position...row.count - 1 {
        if row[i] == "." {
            rightIndex = i
        } else { break}
    }
    return leftIndex...rightIndex
}

func makeMove(matrix: Matrix, element: Character, in position: (x: Int, y: Int)) -> Matrix {
    var output = matrix
    if element == "H" {
        let validRange = findValidIndexes(row: output[position.x], position: position.y)
        for j in 0..<matrix.first!.count {
            if output[position.x][j] == "." && validRange ~= j  {
                output[position.x][j] = "H"
            }
        }
    } else if element == "V" {
        var col = [Character]()
        for i in 0..<matrix.count {
            col.append(output[i][position.y])
        }
        
        let validRange = findValidIndexes(row: col, position: position.x)
        for i in 0..<matrix.count {
            if output[i][position.y]  == "."  && validRange ~= i {
                output[i][position.y] = "V"
            }
        }
    }
    return output
}

func play(matrix: Matrix) -> [Matrix] {
    var output = [Matrix]()
    let coordinates = availableCoordinates(from: matrix)
    if coordinates.count == 0 {
        return []
    }
    
    for coordinate in coordinates {
        let validElementsForCoordinate = validElements(for: coordinate, with: matrix)
        if validElementsForCoordinate.count == 0 {
            return []
        }
        
        for element in validElementsForCoordinate { // TODO
            output.append(makeMove(matrix: matrix, element: element, in: coordinate))
        }
    }
    return output
}

enum Player {
    case becca
    case terry
}

func winnerGamesByBecca(currentPlayer: Player, matrix: Matrix, wins: Int) -> Int {
    var winningCombinations = wins

    let possibleScenarios = play(matrix: matrix)
    if possibleScenarios.isEmpty {
        return currentPlayer == .terry ? 1 : 0
    }
    let player: Player = currentPlayer == .becca ? .terry : .becca
    for scenario in possibleScenarios {
        if winnerGamesByBecca(currentPlayer: player, matrix: scenario, wins: 0) > 0 {
            winningCombinations += 1
        }
    }
    return winningCombinations
}

func solve(_ caseNumber: Int, matrix: Matrix) {
    
    let winnsByBeca = winnerGamesByBecca(currentPlayer: .becca, matrix: matrix, wins: 0)
    if winnsByBeca > 0 {
        print("Case #\(caseNumber): \(winnsByBeca)")
    } else {
        print("Case #\(caseNumber): 0")
    }
}




let numberOfCases = Int(readLine()!)!

for i in 1...numberOfCases {
    let both = readLine()!.split(separator: " ")
    let rows = Int(both[0])!
    var arr = Matrix()
    for _ in 0..<rows {
        arr.append(readLine()!.map { $0 })
    }
    solve(i, matrix: arr)
}
