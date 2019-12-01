import Foundation

let answer = try String(contentsOfFile: "input.txt", encoding: .utf8)
	.split { $0.isNewline }
	.compactMap { Int($0) }
	.map { ($0 / 3) - 2 }
	.reduce(0, +)
	
print(answer)