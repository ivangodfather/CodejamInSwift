//
//  main.swift
//  TidyNumbers
//
//  Created by Ivan Ruiz Monjo on 23/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func isTidy(num: Int) -> Bool {
    let arr = num.description.map { String($0) }
    for i in 0..<arr.count - 1 {
        let left = Int(arr[i])!
        let right = Int(arr[i+1])!
        if left > right {
            return false
        }
    }
    return true
}

func solve(caseNumber: Int) {
    var num = Int(readLine()!)!
    while !isTidy(num: num) {
        num -= 1
    }
    print("Case #\(caseNumber): \(num.description)")
}

let numberOfCases = Int(readLine()!)!

for i in 1...numberOfCases {
    solve(caseNumber: i)
}

