//
//  main.swift
//  problemA
//
//  Created by Ivan Ruiz Monjo on 11/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

let numberOfCases = Int(readLine()!)!

class Pattern {
    
    var prefix = ""
    var sufix = ""
    var inner = [String]()
    
    init(pattern: String) {
        let pattern = pattern.replacingOccurrences(of: "**", with: "*")
        var split = pattern.split(separator: "*")
        if let first = pattern.first, first != "*" {
            prefix = String(split.remove(at: 0))
        }
        if let last = pattern.last, last != "*" {
            if split.isEmpty {
                sufix = prefix
            } else {
                sufix = String(split.removeLast())
            }
        }
        inner = split.map(String.init)
        
    }
}

func handle(patterns: [Pattern]) -> String {
    var longestPrefix = ""
    var longestSufix = ""
    
    for pattern in patterns {
        if pattern.prefix.count > longestPrefix.count {
            longestPrefix = pattern.prefix
        }
        if pattern.sufix.count > longestSufix.count {
            longestSufix = pattern.sufix
        }
    }
    
    for pattern in patterns {
        if !longestPrefix.hasPrefix(pattern.prefix) {
            return "*"
        }
        if !longestSufix.hasSuffix(pattern.sufix) {
            return "*"
        }
    }
    var output = longestPrefix
    patterns.forEach { pattern in
        pattern.inner.forEach {
            output.append($0)
        }
    }
    output.append(longestSufix)
    return output
}

for i in 1...numberOfCases {
    let rows = Int(readLine()!)!
    var patterns = [Pattern]()
    for _ in 0..<rows {
        patterns.append(Pattern(pattern: readLine()!))
    }
    print("Case #\(i): \(handle(patterns: patterns)) ")
}
