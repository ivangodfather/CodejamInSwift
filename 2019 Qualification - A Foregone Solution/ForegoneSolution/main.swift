//
//  main.swift
//  ForegoneSolution
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func myPow(_ x: Int, _ y: Int) -> Int {
    guard y > 0  else { return 1 }
    
    var value = 1
    for _ in 1...y {
        value *= x
    }
    return value
}

let numberOfCases = Int(readLine()!)!

func notContainsFour(_ num: Int) -> Bool {
    return !num.description.contains("4")
}

func split_v1(_ value: String) -> (Int, Int) {
    let value = Int(value)!
    while(true) {
        let a = Int.random(in: 1...value)
        let b = value - a
        if notContainsFour(a) && notContainsFour(b) {
            return (a, b)
        }
    }
}

func split_v2(_ value: String) -> (Int, Int) {
    var a = 0
    var b = 0
    value.enumerated().forEach { arg in
        let digit = Int(String(arg.element))!
        if notContainsFour(digit) {
            a += Int(arg.element.description)! * myPow(10, value.count - arg.offset - 1)
        } else {
            let splitted = 2 * myPow(10, value.count - arg.offset - 1)
            a += splitted
            b += splitted
        }
    }
    return (Int(a), Int(b))
}

for i in 1...numberOfCases {
    let value = readLine()!
    let result = split_v2(value)
    print("Case #\(i): \(result.0) \(result.1)")
}
