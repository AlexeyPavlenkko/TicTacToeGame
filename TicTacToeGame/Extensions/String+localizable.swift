//
//  String+localizable.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 26.09.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
