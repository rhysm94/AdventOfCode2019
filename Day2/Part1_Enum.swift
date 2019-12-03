import Foundation

let input = try String(contentsOfFile: "input.txt", encoding: .utf8)
	.split(separator: ",")
	.compactMap { Int($0) }
	
enum VMState {
	enum Instruction {
		case add(lhs: Int, rhs: Int, index: Int)
		case multiply(lhs: Int, rhs: Int, index: Int)
		case halt
		
		init(data: [Int], pointer: Int) {
			let opCode = data[pointer]
			switch opCode {
				case 1:
					self = .add(lhs: data[data[pointer + 1]], rhs: data[data[pointer + 2]], index: data[pointer + 3])
				case 2:
					self = .multiply(lhs: data[data[pointer + 1]], rhs: data[data[pointer + 2]], index: data[pointer + 3])
				case 99:
					self = .halt
				default:
					fatalError("Shouldn't be possible")
			}
		}
	}
	
	case operating(data: [Int], pointer: Int = 0)
	case halted(data: [Int])
	
	func process() -> VMState {
		if case .halted = self {
			return self
		}
		
		return processInstruction().process()
	}
	
	private func processInstruction() -> VMState {
		switch self {
			case let .operating(data, pointer):
				let instruction = Instruction(data: data, pointer: pointer)
				let nextPointer = pointer + 4

				switch instruction {
					case let .add(lhs, rhs, index):
						let result = lhs + rhs
						let newData = Array(data[data.startIndex ..< index] + [result] + data[index + 1 ..< data.endIndex])
						return .operating(data: newData, pointer: nextPointer)
					case let .multiply(lhs, rhs, index):
						let result = lhs * rhs
						let newData = Array(data[data.startIndex ..< index] + [result] + data[index + 1 ..< data.endIndex])
						return .operating(data: newData, pointer: nextPointer)
					case .halt:
						return .halted(data: data)
				}
			case .halted:
				return self
		}
	}
	
	func getResult() -> Int {
		switch self {
			case let .operating(data, _), let .halted(data):
			return data[0]
		}
	}
}

let endState = VMState.operating(data: input).process()
print(endState.getResult())