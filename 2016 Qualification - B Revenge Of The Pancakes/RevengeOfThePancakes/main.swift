//
//  main.swift
//  RevengeOfThePancakes
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let total = Int64(readLine()!)!

func flip(_ i: Int, stack: [Character]) -> [Character] {
    return stack.enumerated().map { arg -> Character in
        let (pos, value) = arg
        if pos <= i {
            return value == "+" ? "-" : "+"
        }
        return value
    }
}


for i in 1...total  {
    var stack = Array(readLine()!)
    var flips = 0
    for i in stride(from: stack.count - 1, to: -1, by: -1) {
        if stack[i] == "-" {
            stack = flip(i, stack: stack)
            flips += 1
        }
    }
    print("Case #\(i): \(flips)")
}

