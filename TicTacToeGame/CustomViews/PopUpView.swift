//
//  PopUpView.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 26.09.2022.
//

import UIKit

class PopUpView: UIView {

    //MARK: - SubViews
    private lazy var easyModeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.bordered()
        config.cornerStyle = .fixed
        config.title = DifficultyMode.easy.description
        config.titleAlignment = .center
        config.baseBackgroundColor = DifficultyMode.easy.color
        config.baseForegroundColor = .softWhite
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var mediumModeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.bordered()
        config.cornerStyle = .fixed
        config.title = DifficultyMode.medium.description
        config.titleAlignment = .center
        config.baseBackgroundColor = DifficultyMode.medium.color
        config.baseForegroundColor = .softWhite
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var hardModeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.bordered()
        config.cornerStyle = .fixed
        config.title = DifficultyMode.hard.description
        config.titleAlignment = .center
        config.baseBackgroundColor = DifficultyMode.hard.color
        config.baseForegroundColor = .softWhite
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.borderless()
        config.cornerStyle = .fixed
        config.title = "Close"
        config.titleAlignment = .center
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .main
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Variables
    var actionHandler: ((DifficultyMode?) -> Void)?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .softWhite
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addConstraints()
    }
    
    //MARK: - Actions & @objc
    @objc private func buttonDidTapped(_ sender: UIButton) {
        print("\(sender) did tapped")
        if sender == easyModeButton {
            actionHandler?(.easy)
        } else if sender == mediumModeButton {
            actionHandler?(.medium)
        } else if sender == hardModeButton {
            actionHandler?(.hard)
        } else {
            actionHandler?(nil)
        }
    }
    
    //MARK: - Methods
    private func setupSubviews() {
        stackView.addArrangedSubview(easyModeButton)
        stackView.addArrangedSubview(mediumModeButton)
        stackView.addArrangedSubview(hardModeButton)
        stackView.addArrangedSubview(closeButton)
        addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
