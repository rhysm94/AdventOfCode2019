import Foundation

func fuelRequirement(mass: Int) -> Int {
	let requirement = mass / 3 - 2
	guard requirement >= 0 else {
		return 0
	}

	return requirement + fuelRequirement(mass: requirement)
}

let answer = try String(contentsOfFile: "input.txt", encoding: .utf8)
	.split { $0.isNewline }
	.compactMap { Int($0) }
	.map(fuelRequirement)
	.reduce(0, +)

print(answer)
