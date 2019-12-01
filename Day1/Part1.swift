import Foundation

let answer = try String(contentsOfFile: "input.txt", encoding: .utf8)
	.split(separator: "\n")
	.compactMap { Int($0) }
	.map { ($0 / 3) - 2 }
	.reduce(0, +)
	
print(answer)