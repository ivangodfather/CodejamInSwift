//
//  main.swift
//  CountingSheep
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let total = Int64(readLine()!)!

for i in 1...total  {
    var result = 0
    var numbersSeen = Set<String>()
    let number = readLine()!
    number.forEach { digit in
        numbersSeen.insert(String(digit))
    }
    if number != "0" {
        var multiply = 2
        while numbersSeen.count < 10 {
            result = Int(number)! * multiply
            multiply += 1
            String(result).forEach { digit in
                numbersSeen.insert(String(digit))
            }
        }
        
    }
    let text = result == 0 ? "INSOMNIA" : result.description
    print("Case #\(i): \(text)")
}
