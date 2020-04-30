import Foundation

// http://qiita.com/y_mazun/items/dc2a0cad8da1c0e88a40
extension String: Collection {} // to enable String.split()

func readInput() -> Int {
    return readLine().flatMap { Int($0) }!
}

func readInput() -> [Int] {
    return readLine().flatMap { $0.split(separator: " ").flatMap { Int($0)} }!
}

func readInput() -> (Int, Int) {
    let inputs = readInput() as [Int]
    return (inputs[0], inputs[1])
}

func readInput() -> Double {
    return readLine().flatMap { Double($0) }!
}

func readInput() -> [Double] {
    return readLine().flatMap { $0.split(separator: " ").flatMap { Double($0)} }!
}

func readInput() -> (Double, Double) {
    let inputs = readInput() as [Double]
    return (inputs[0], inputs[1])
}

func readInput() -> (Int, Double) {
    let inputs = readInput() as [Double]
    return (Int(inputs[0]), inputs[1])
}

func readInput() -> String {
    return readLine()!
}

func readInput() -> (Int, Int, Int, Int, Int, Int, Int) {
    let inputs = readInput() as [Int]
    return (inputs[0], inputs[1], inputs[2], inputs[3], inputs[4], inputs[5], inputs[6])
}

func readInput() -> [String] {
    return readLine()!.split(separator: " ").map(String.init)
}
