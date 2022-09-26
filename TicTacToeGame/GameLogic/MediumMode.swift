//
//  MediumMode.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import Foundation

struct MediumMode: DifficultyLogic {
    var correctCombinations: [[Box]] {
        let topRow: [Box] = [.one, .two, .three]
        let middleRow: [Box] = [.four, .five, .six]
        let bottomRow: [Box] = [.seven, .eight, .nine]
        let leftColumn: [Box] = [.one, .four, .seven]
        let middleColumn: [Box] = [.two, .five, .eight]
        let rightColumn: [Box] = [.three, .six, .nine]
        let firstDiagonal: [Box] = [.one, .five, .nine]
        let secondDiagonal: [Box] = [.three, .five, .seven]
        return [topRow, middleRow, bottomRow, leftColumn, middleColumn, rightColumn, firstDiagonal, secondDiagonal]
    }
    
    func getIndexChoice(from availableBoxes: [Box], with choices: [Box], playerChoices: [Box]) -> Int {
        
        for combination in correctCombinations {
            let correctChoices = choices.filter { combination.contains($0) }
            guard correctChoices.count == 2 else { continue }
            guard let firstChoice = correctChoices.first else { continue }
            guard let lastChoice = correctChoices.last else { continue }
            
            var mutCombination = combination
            
            guard let firstChoiceIndex = mutCombination.firstIndex(of: firstChoice) else { continue }
            mutCombination.remove(at: firstChoiceIndex)
            
            guard let lastChoiceIndex = mutCombination.firstIndex(of: lastChoice) else { continue }
            mutCombination.remove(at: lastChoiceIndex)
            
            guard let neededChoice = mutCombination.first else { continue }
            guard let neededChoiceIndex = availableBoxes.firstIndex(of: neededChoice) else { continue }
            
            return neededChoiceIndex
        }
        
        return Int.random(in: 0..<availableBoxes.count)
    }
}
