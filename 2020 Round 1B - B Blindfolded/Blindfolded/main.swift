//
//  main.swift
//  Blindfolded
//
//  Created by Ivan Ruiz Monjo on 20/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation


let both = readLine()!.split(separator: " ").map { Int($0)! }
let numberOfCases = both[0]
let a = both[1]
let y = both[2]
var bbounds = 1_000_000_000

enum Status: String {
    case miss
    case center
    case hit
    case wrong
}

func throwDart(_ x: Int, _ y: Int) -> Status {
    print("\(x) \(y)")
    fflush(stdout)
    let answer = readLine()!
    if answer == "MISS" {
        return .miss
    } else if answer == "CENTER" {
        return.center
    } else if answer == "HIT" {
        return .hit
    } else {
        fatalError("not reachable X: \(y) Y: \(y)")
    }
}


func solve(caseNumber: Int) {
    var randomCurrent: (Int, Int)? = nil
    let bounds = (-bbounds - 1, bbounds + 1, -bbounds - 1, bbounds + 1)
    while randomCurrent == nil {
        let randomTry = (Int.random(in: bounds.0...bounds.1), Int.random(in: bounds.2...bounds.3))
        let status = throwDart(randomTry.0, randomTry.1)
        if status == .center {
            return
        }
        if status == .hit {
            randomCurrent = randomTry
        }
    }
    guard var current = randomCurrent  else { fatalError() }
    var leftBound = bounds.0
    var leftX = current.0
    while leftBound + 1 < leftX {
        let midX = (leftBound + leftX) / 2
        let status = throwDart(midX, current.1)
        if status == .center {
            return
        }
        if status == .miss {
            leftBound = midX
        }
        if status == .hit {
            leftX = midX
        }
    }

    var rightBound = bounds.1
    var rightX = current.0
    while rightX + 1 < rightBound  {
        let midX = (rightBound + rightX) / 2
        let status = throwDart(midX, current.1)
        if status == .center {
            return
        }
        if status == .miss {
            rightBound = midX
        }
        if status == .hit {
            rightX = midX
        }
    }

    current.0 = (leftX + rightX) / 2 // Should be in the right spot

    var bottomBound = bounds.2
    var bottomY = current.1
    while bottomBound + 1 < bottomY {
        let midY = (bottomBound + bottomY) / 2
        let status = throwDart(current.0, midY)
        if status == .center {
            return
        }
        if status == .miss {
            bottomBound = midY
        }
        if status == .hit {
            bottomY = midY
        }
    }


    var upperBound = bounds.3
    var upperY = current.1
    while upperY + 1 < upperBound {
        let midY = (upperBound + upperY) / 2
        let status = throwDart(current.0, midY)
        if status == .center {
            return
        }
        if status == .miss {
            upperBound = midY
        }
        if status == .hit {
            upperY = midY
        }
    }

    current.1 = (bottomY + upperY) / 2

    let status = throwDart(current.0, current.1)
    if status != .center {
        fatalError("something went wrong... X: \(current.0) Y: \(current.1)")
    }
}

for i in 1...numberOfCases {
    solve(caseNumber: i)
}

