//
//  main.swift
//  Parenting Partnering Returns
//
//  Created by Ivan Ruiz Monjo on 05/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

func printOutput(t: Int, text: String) {
    print("Case #\(t): \(text)")
}

func solve(t: Int, activities: [(Int, Int)]) {
    var startActivitiesAtMinute = [[Int]](repeating: [Int](), count: 60 * 24 + 1)
    var endActivitiesAtMinute = [[Int]](repeating: [Int](), count: 60 * 24 + 1)
    
    activities.enumerated().forEach { arg in
        startActivitiesAtMinute[arg.element.0].append(arg.offset)
        endActivitiesAtMinute[arg.element.1].append(arg.offset)
    }
    
    var currentlyWorkingCount = 0
    var jamesCurrentWorkingActivity = -1
    var output = [String](repeating: "?", count: activities.count)
    
    for index in startActivitiesAtMinute.indices {
        currentlyWorkingCount += startActivitiesAtMinute[index].count
        currentlyWorkingCount -= endActivitiesAtMinute[index].count
        
        if currentlyWorkingCount > 2 {
            printOutput(t: t, text: "IMPOSSIBLE")
            return
        }
        
        if endActivitiesAtMinute[index].contains(jamesCurrentWorkingActivity) {
            jamesCurrentWorkingActivity = -1
        }
        
        for activityIndex in startActivitiesAtMinute[index] {
            if jamesCurrentWorkingActivity == -1 {
                jamesCurrentWorkingActivity = activityIndex
                output[activityIndex] = "J"
            } else {
                output[activityIndex] = "C"
            }
        }
        

    }
    printOutput(t: t, text: output.joined())
}

let t = Int(readLine()!)!

for t in 1...t {
    let n = Int(readLine()!)!
    var matrix = [(Int, Int)]()
    for _ in 1...n {
        let both = readLine()!.split(separator: " ").map { Int($0)! }
        matrix.append((both[0], both[1]))
    }
    solve(t: t, activities: matrix)
}
