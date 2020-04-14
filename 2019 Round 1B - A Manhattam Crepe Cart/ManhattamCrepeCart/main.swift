//
//  main.swift
//  ManhattamCrepeCart
//
//  Created by Ivan Ruiz Monjo on 13/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Coordinate: Hashable, CustomStringConvertible {
    let x,y: Int
    var description: String {
        return "(\(x), \(y))"
    }
}

enum Facing: String {
    case N, W, S, E
}

struct Person {
    let coordinate: Coordinate
    let facing: Facing
}

func reachablePointsByPerson(_ person: Person, with gridLines: Int) -> [Coordinate] {
    var coordinates = [Coordinate]()
    switch person.facing {
    case .N:
        for x in 0...gridLines {
            for y in person.coordinate.y + 1...gridLines {
                coordinates.append(Coordinate(x: x, y: y))
            }
        }
    case .S:
        for x in 0...gridLines {
            for y in 0...person.coordinate.y - 1 {
                coordinates.append(Coordinate(x: x, y: y))
            }
        }
    case .E:
        for x in person.coordinate.x + 1...gridLines {
            for y in 0...gridLines {
                coordinates.append(Coordinate(x: x, y: y))
            }
        }
    case .W:
        for x in 0...person.coordinate.x - 1 {
            for y in 0...gridLines {
                coordinates.append(Coordinate(x: x, y: y))
            }
        }
    }
    return coordinates
}

func createPoints(from lines: Int) -> [Coordinate] {
    var output = [Coordinate]()
    for x in 0...lines {
        for y in 0...lines {
            output.append(Coordinate(x: x, y: y))
        }
    }
    return output
}

var intersections: [Coordinate: Int] = [:]

func solve(i: Int, people: [Person], lines: Int) {
    intersections = [:]
    people.forEach { person in
        let reachableCoords = reachablePointsByPerson(person, with: lines)
        reachableCoords.forEach {
            if intersections[$0] == nil {
                intersections[$0] = 1
            } else {
                intersections[$0]! += 1
            }
        }
    }
    let sorted = intersections.sorted { (left, right) -> Bool in
        if left.value != right.value {
            return left.value > right.value
        }
        if left.key.x != right.key.x {
            return left.key.x < right.key.x
        }
        return left.key.y < right.key.y
        
    }
    print("Case #\(i): \(sorted.first!.key.x) \(sorted.first!.key.y)")
}

let numberOfCases = Int(readLine()!)!


for i in 1...numberOfCases {
    let both = readLine()!.split(separator: " ").map { Int($0)! }
    let lines = both[1]
    var people = [Person]()
    for _ in 1...both[0] {
        let both = readLine()!.split(separator: " ").map(String.init)
        let coordinate = Coordinate(x: Int(both[0])!, y: Int(both[1])!)
        let facing = Facing(rawValue: both[2])!
        people.append(Person(coordinate: coordinate, facing: facing))
        
    }
    solve(i: i, people: people, lines: lines)
}
