//
//  GameViewController.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import UIKit

enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}

enum Choice: String {
    case cross, circle
}

enum ChoicePlayer {
    case player, computer
}

class GameViewController: UIViewController {

    //MARK: - Outlets & Subviews
    var backgroundImageView: UIImageView!
    
    var labelesStackView: UIStackView!
    
    var difficultyStackView: UIStackView!
    var difficultyLabel: UILabel!
    var difficultyModeLabel: UILabel!
    
    var scoreLabel: UILabel!
    
    var playerStackView: UIStackView!
    var playerChoiceLabel: UILabel!
    var playerLabel: UILabel!
    var playerCountLabel: UILabel!
    
    var computerStackView: UIStackView!
    var computerChoiceLabel: UILabel!
    var computerLabel: UILabel!
    var computerCountLabel: UILabel!
    
    var exitButton: UIButton!
    
    var containerView: UIView!
    var imagesStackView: UIStackView!
    var row1StackView: UIStackView!
    var row2StackView: UIStackView!
    var row3StackView: UIStackView!
    
    var box1: UIImageView!
    var box2: UIImageView!
    var box3: UIImageView!
    var box4: UIImageView!
    var box5: UIImageView!
    var box6: UIImageView!
    var box7: UIImageView!
    var box8: UIImageView!
    var box9: UIImageView!
    
    //MARK: - Variables
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    public var playerName: String!
    public var difficultyName: String!
    public var computerLogic: DifficultyLogic!
    private var lastChoice: Choice = .circle
    private var playerChoices: [Box] = []
    private var computerChoices: [Box] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutSubview()
    }
    
    //MARK: - Actions & @objc

    @objc private func exitButtonDidTapped() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc private func boxDidTapped(_ sender: UITapGestureRecognizer) {
        let selectedBoxImageView = getBoxImageView(from: sender.name ?? "")
        makeChoice(selectedBoxImageView)
        playerChoices.append(Box(rawValue: sender.name!)!)
        let isFinished = checkGameStatus()
        if isFinished {
            resetGame(lastChoicePlayer: .player)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.computerMakeChoice()
            let isFinished = self?.checkGameStatus()
            if isFinished ?? false {
                self?.resetGame(lastChoicePlayer: .computer)
            }
        }
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        setupSubviews()
        addSubviews()
        addGesturesToBoxes()
        playerLabel.text = playerName + ":"
        difficultyModeLabel.text = difficultyName
        exitButton.addTarget(self, action: #selector(exitButtonDidTapped), for: .touchUpInside)
    }
    
    private func addGesturesToBoxes() {
        let enumeratedBoxes =  [box1, box2, box3, box4, box5, box6, box7, box8, box9].enumerated()
        enumeratedBoxes.forEach { (index, boxImageView) in
            let tap = UITapGestureRecognizer(target: self, action: #selector(boxDidTapped(_:)))
            tap.name = Box.allCases[index].rawValue
            boxImageView?.isUserInteractionEnabled = true
            boxImageView?.addGestureRecognizer(tap)
        }
    }
    
    private func getBoxImageView(from name: String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        switch box {
        case .one: return box1
        case .two: return box2
        case .three: return box3
        case .four: return box4
        case .five: return box5
        case .six: return box6
        case .seven: return box7
        case .eight: return box8
        case .nine: return box9
        }
    }
    
    private func makeChoice(_ selectedBoxImageView: UIImageView) {
        switch lastChoice {
        case .cross:
            selectedBoxImageView.image = UIImage(named: Choice.circle.rawValue)
            selectedBoxImageView.isUserInteractionEnabled = false
            lastChoice = .circle
        case .circle:
            selectedBoxImageView.image = UIImage(named: Choice.cross.rawValue)
            selectedBoxImageView.isUserInteractionEnabled = false
            lastChoice = .cross
        }
    }
    
    private func computerMakeChoice() {
        var availableSpaces = [UIImageView]()
        var availabelBoxes = [Box]()
        for box in Box.allCases {
            let boxImageView = getBoxImageView(from: box.rawValue)
            if boxImageView.image == nil {
                availableSpaces.append(boxImageView)
                availabelBoxes.append(box)
            }
        }
        
        let indexChoice = computerLogic.getIndexChoice(from: availabelBoxes, with: computerChoices, playerChoices: playerChoices)
        makeChoice(availableSpaces[indexChoice])
        computerChoices.append(availabelBoxes[indexChoice])
    }
    
    private func checkGameStatus() -> Bool {
        var correctCombinations = [[Box]]()
        let topRow: [Box] = [.one, .two, .three]
        let middleRow: [Box] = [.four, .five, .six]
        let bottomRow: [Box] = [.seven, .eight, .nine]
        let leftColumn: [Box] = [.one, .four, .seven]
        let middleColumn: [Box] = [.two, .five, .eight]
        let rightColumn: [Box] = [.three, .six, .nine]
        let firstDiagonal: [Box] = [.one, .five, .nine]
        let secondDiagonal: [Box] = [.three, .five, .seven]
        correctCombinations += [topRow, middleRow, bottomRow, leftColumn, middleColumn, rightColumn, firstDiagonal, secondDiagonal]
        
        for combination in correctCombinations {
            let userMatchesCount = playerChoices.filter { combination.contains($0) }.count
            let computerMatchesCount = computerChoices.filter { combination.contains($0) }.count
            
            if userMatchesCount == combination.count {
                playerCountLabel.text = String(((Int(playerCountLabel.text ?? "0")) ?? 0) + 1)
                showSnackbar(with: "🥳 \(playerName ?? "") " + "won!".localized())
                return true
            } else if computerMatchesCount == combination.count {
                computerCountLabel.text = String(((Int(computerCountLabel.text ?? "0")) ?? 0) + 1)
                showSnackbar(with: "🤖 " + "Computer won!".localized())
                return true
            }
        }
        
        if computerChoices.count + playerChoices.count == 9 {
            showSnackbar(with: "🥶 " + "Draw!".localized())
            return true
        }
        
        return false
    }
    
    private func resetGame(lastChoicePlayer: ChoicePlayer) {
        for box in Box.allCases {
            let boxImageView = getBoxImageView(from: box.rawValue)
            boxImageView.image = nil
            boxImageView.isUserInteractionEnabled = true
        }
        lastChoice = lastChoice == .cross ? .circle : .cross
        playerChoices = []
        computerChoices = []
        switch lastChoicePlayer {
        case .player:
            playerChoiceLabel.text = lastChoice == .cross ? "(X)" : "(O)"
            computerChoiceLabel.text = lastChoice == .cross ? "(O)" : "(X)"
        case .computer:
            playerChoiceLabel.text = lastChoice == .cross ? "(O)" : "(X)"
            computerChoiceLabel.text = lastChoice == .cross ? "(X)" : "(O)"
        }
    }
    
}
