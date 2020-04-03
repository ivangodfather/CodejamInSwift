//
//  main.swift
//  AlphabetCake
//
//  Created by Ivan Ruiz Monjo on 03/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation


func initials(_ arr: [[String]]) -> Set<String> {
    Set<String>(arr.joined().filter { $0 != "?" })
}

func isValidCake(_ cake: [[String]]) -> Bool {
    
    var isValidCake = true
    initials(cake).forEach { initial in
        var pointsFound = [(Int, Int)]()
        for row in 0...cake.count - 1 {
            for col in 0...cake.first!.count - 1 {
                if cake[row][col] == initial {
                    pointsFound.append((row, col))
                }
            }
        }
        let col_values = pointsFound.map { $0.1 }.sorted()
        let row_values = pointsFound.map { $0.0 }.sorted()
        let col_min = col_values.first!
        let col_max = col_values.last!
        let row_min = row_values.first!
        let row_max = row_values.last!
        let pointColMin = pointsFound.filter { $0.1 == col_min }.first!
        let pointColMax = pointsFound.filter { $0.1 == col_max }.first!
        let sameRow = pointColMin.0 == pointColMax.0
        
        let pointRowMin = pointsFound.filter { $0.0 == row_min }.first!
        let pointRowMax = pointsFound.filter { $0.0 == row_max }.first!
        let sameCol = pointRowMin.1 == pointRowMax.1
        var sameElements = true
        for i in row_min...row_max {
            for j in col_min...col_max {
                sameElements = sameElements && cake[i][j] == initial
            }
        }
        isValidCake = isValidCake && (sameRow && sameCol) && sameElements
        
    }
    return isValidCake
}

var t = Int(readLine()!)!

for t in 1...t {
    let rowsAndCols = readLine()!.split(separator: " ").map(String.init)
    let rows = Int(rowsAndCols[0])!
    let cols = Int(rowsAndCols[1])!



    var cake = [[String]]()
    for _ in 0...rows - 1 {
        let cakeRow = readLine()!.map { $0 }.map(String.init)
        cake.append(cakeRow)
    }
    let cakeinitials = initials(cake)


    print("Case #\(t):")
    var found = false
    var randomCake = cake
    while(!found) {
        for row in 0...rows - 1 {
            for col in 0...cols - 1 {
                if randomCake[row][col] == "?" {
                    randomCake[row][col] = cakeinitials.randomElement()!
                }
            }
        }
        if isValidCake(randomCake) {
            found.toggle()
            randomCake.forEach {
                print($0.joined())
            }
        } else {
            randomCake = cake
        }
    }
}
