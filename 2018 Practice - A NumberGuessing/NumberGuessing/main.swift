//
//  main.swift
//  NumberGuessing
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func solve(a: Int64, b: Int64) {
    let m = (a + b) / 2
    print(m)
    fflush(stdout)
    let s = readLine()!
    if s == "CORRECT" {
        return
    } else if s == "TOO_SMALL" {
        solve(a: m + 1, b: b)
    } else if s == "TOO_BIG" {
        solve(a: a, b: m - 1)
    } else {
        exit(0)
    }
}

let numberOfCases = Int64(readLine()!)!

for _ in 1...numberOfCases {
    let both = readLine()!.split(separator: " ").map { String($0) }
    let a = Int64(both[0])!
    let b = Int64(both[1])!
    _ = readLine()!
    solve(a: a + 1, b: b)
}
