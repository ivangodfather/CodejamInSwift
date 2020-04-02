//
//  main.swift
//  StandingOvation
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let numberOfTests = Int(readLine()!)!

for i in 1...numberOfTests {
    let both = readLine()!.split(separator: " ")
    let people = Array(both[1])
    var newAtt = 0
    var total = 0
    people.enumerated().forEach { arg in
        let (index, elem) = arg
        let num = Int(String(elem))!
        if num > 0 && (index > total) {
            let peopleToAdd = index - total
            total += peopleToAdd
            newAtt += peopleToAdd
        }
        total += num
    }
    
    print("Case #\(i): \(newAtt)")
}
