//
//  EasyMode.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import Foundation

struct EasyMode: DifficultyLogic{
    func getIndexChoice(from availableBoxes: [Box], with choices: [Box], playerChoices: [Box]) -> Int {
        return Int.random(in: 0..<availableBoxes.count)
    }
}
