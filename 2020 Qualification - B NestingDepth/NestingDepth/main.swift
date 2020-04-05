//
//  main.swift
//  NestingDepth
//
//  Created by Ivan Ruiz Monjo on 04/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let t = Int(readLine()!)!

func pendingParentesisAfter(_ intValue: Int, in container: String) -> String {
    let left = container.filter { $0 == "(" }.count
    let right =  container.filter { $0 == ")" }.count
    let totalOpenend =  (left - right)
    let needToClose = max(totalOpenend - intValue, 0)
    return [String](repeating: ")", count: needToClose).joined()
}
func pendingParentesisBefore(_ intValue: Int, in container: String) -> String {
    let left = container.filter { $0 == "(" }.count
    let right =  container.filter { $0 == ")" }.count
    let total =  intValue - (left - right)
    return [String](repeating: "(", count: max(total, 0)).joined()
}

for t in 1...t {
    var output = ""
    let input = readLine()!.map(String.init).map { Int($0)! }
    for digit in input {

        output.append(pendingParentesisAfter(digit, in: output))
        output.append(pendingParentesisBefore(digit, in: output))
        output.append(digit.description)
    }
    let left = output.filter { $0 == "(" }.count
    let right =  output.filter { $0 == ")" }.count
    let totalOpenend =  (left - right)
    for _ in 0..<totalOpenend {
        output.append(")")
    }
    print("Case #\(t): \(output)")
}
