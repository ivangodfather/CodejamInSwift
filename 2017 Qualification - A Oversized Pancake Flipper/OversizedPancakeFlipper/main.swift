//
//  main.swift
//  OversizedPancakeFlipper
//
//  Created by Ivan Ruiz Monjo on 23/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation


func solve(caseNum: Int) {
    let both = readLine()!.split(separator: " ").map(String.init)
    var pankakes = both[0].map { $0 }
    let k = Int(both[1])!
    var count = 0
    for index in 0...pankakes.count - k {
        let cake = pankakes[index]

        if cake == "-" {
            count += 1
            for i in 0..<k {
                let current = pankakes[index + i]
                if current == "-" {
                }
                pankakes[index + i] = current == "-" ? "+" : "-"
            }
        }
        
    }
    let result = pankakes.filter { $0 == "-" }.isEmpty ? count.description : "IMPOSSIBLE"
    print("Case #\(caseNum): \(result)")

}

let numberOfCases = Int(readLine()!)!
for caseNum in 1...numberOfCases {
    solve(caseNum: caseNum)
}
