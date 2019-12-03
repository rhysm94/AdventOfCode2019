import Foundation

class VM {
	enum Instruction {
		case add(lhs: Int, rhs: Int, index: Int)
		case multiply(lhs: Int, rhs: Int, index: Int)
		case halt
		
		init(instruction: Int, arguments: [Int]) {
			print("Instruction: \(instruction)")
			switch instruction {
				case 1:
					self = .add(lhs: arguments[0], rhs: arguments[1], index: arguments[2])
				case 2:
					self = .multiply(lhs: arguments[0], rhs: arguments[1], index: arguments[2])
				case 99:
					self = .halt
				default:
					fatalError("Shouldn't be possible")
			}
		}
	}
	
	var input: [Int]
	var instructionPointer = 0
	var halted = false
	
	init(_ input: [Int]) {
		self.input = input
	}
	
	func start() {
		repeat {
			processInstruction()
			advanceInstructionPointer()
		} while !halted
	}
	
	private func processInstruction() {
		let instruction = Instruction(instruction: input[instructionPointer], arguments: getArguments())
		
		switch instruction {
			case let .add(lhs, rhs, index):
				input[index] = input[lhs] + input[rhs]
			case let .multiply(lhs, rhs, index):
				input[index] = input[lhs] * input[rhs]
			case .halt:
				halted = true
		}
	}
	
	private func getArguments() -> [Int] {
		Array(input[instructionPointer + 1 ... instructionPointer + 3])
	}
	
	private func advanceInstructionPointer() {
		instructionPointer += 4
	}
}

let input = try String(contentsOfFile: "input.txt", encoding: .utf8)
	.split(separator: ",")
	.compactMap { Int($0) }
	
let vm = VM([1,0,0,0,99])
vm.start()
print(vm.input[0])