//
//  HomeVC+.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import UIKit

extension HomeViewController {
    private func createBackgroundImageView() -> UIImageView {
        let imageV = UIImageView(image: UIImage(named: "homeBack"))
        imageV.contentMode = .scaleToFill
        return imageV
    }
    
    private func createContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .softWhite
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Please enter your name".localized()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func createLabel(with text: String, fontSize: CGFloat, weight: UIFont.Weight, color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createStackView(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 10, aligment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = aligment
        stack.distribution = distribution
        stack.axis = axis
        return stack
    }
    
    private func createStartButton() -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.bordered()
        config.title = "Start".localized()
        config.titleAlignment = .center
        config.baseBackgroundColor = .main
        config.baseForegroundColor = .softWhite
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createModeButton() -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.bordered()
        config.image = UIImage(systemName: difficultyMode.titleImage)
        config.imagePlacement = .all
        config.baseBackgroundColor = difficultyMode.color
        config.baseForegroundColor = .softWhite
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        return button
    }
    
    func setupSubviews() {
        backgroundImage = createBackgroundImageView()
        ticTacToeLabel = createLabel(with: "Tic-Tac-Toe".localized(), fontSize: 35, weight: .bold, color: .softWhite)
        
        containerView = createContainerView()
        textField = createTextField()
        welcomeLabel = createLabel(with: "Welcome!".localized(), fontSize: 24, weight: .medium)
        startButton = createStartButton()
        modeButton = createModeButton()
        containerStackView = createStackView()
        buttonsStackView = createStackView(axis: .horizontal, spacing: 5, aligment: .fill, distribution: .fill)
        
        modeSettingsPupUpView = PopUpView()
    }
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(ticTacToeLabel)
        view.addSubview(containerView)
        containerStackView.addArrangedSubview(welcomeLabel)
        containerStackView.addArrangedSubview(textField)
        
        buttonsStackView.addArrangedSubview(startButton)
        buttonsStackView.addArrangedSubview(modeButton)
        containerStackView.addArrangedSubview(buttonsStackView)
        containerView.addSubview(containerStackView)
    }
    
    func layoutSubviews() {
        backgroundImage.frame = view.bounds
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            modeButton.widthAnchor.constraint(equalToConstant: 50),
        
            ticTacToeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ticTacToeLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -100)
        ])
    }
}
