//
//  DifficultyMode.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import UIKit

protocol DifficultyLogic {
    func getIndexChoice(from availableBoxes: [Box], with choices: [Box], playerChoices: [Box]) -> Int 
}

enum DifficultyMode {
    case easy
    case medium
    case hard
    
    var difficultyLogic: DifficultyLogic {
        switch self {
        case .easy:
            return EasyMode()
        case .medium:
            return MediumMode()
        case .hard:
            return HardMode()
        }
    }
    
    var description: String {
        switch self {
        case .easy:
            return "Easy".localized()
        case .medium:
            return "Medium".localized()
        case .hard:
            return "Human".localized()
        }
    }
    
    var titleImage: String {
        "command"
    }
    
    var color: UIColor {
        switch self {
        case .easy:
            return .modeGreen
        case .medium:
            return .modeYellow
        case .hard:
            return .modeRed
        }
    }
}
