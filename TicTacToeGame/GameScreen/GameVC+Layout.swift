//
//  GameVC+.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import UIKit

extension GameViewController {
    private func createBackgroundImageView() -> UIImageView {
        let imageV = UIImageView(image: UIImage(named: "gameBack"))
        imageV.contentMode = .scaleToFill
        return imageV
    }
    
    private func createLabel(with text: String, fontSize: CGFloat, weight: UIFont.Weight, color: UIColor = .softWhite) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat, aligment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = aligment
        stack.distribution = distribution
        stack.axis = axis
        return stack
    }
    
    private func createExitButton() -> UIButton {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "remove"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .main
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createBoxImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondary
        return imageView
    }

    func setupSubviews() {
        backgroundImageView = createBackgroundImageView()
        
        labelesStackView = createStackView(axis: .vertical, spacing: 5, aligment: .top)
        
        difficultyStackView = createStackView(axis: .horizontal, spacing: 10)
        difficultyLabel = createLabel(with: "Difficulty:".localized(), fontSize: 22, weight: .medium)
        difficultyModeLabel = createLabel(with: "", fontSize: 22, weight: .bold)
        
        scoreLabel = createLabel(with: "Score:".localized(), fontSize: 22, weight: .medium)
        
        playerStackView = createStackView(axis: .horizontal, spacing: 10)
        playerChoiceLabel = createLabel(with: "(X)", fontSize: 20, weight: .regular)
        playerLabel = createLabel(with: "Player:", fontSize: 20, weight: .regular)
        playerCountLabel = createLabel(with: "0", fontSize: 20, weight: .regular)
        
        computerStackView = createStackView(axis: .horizontal, spacing: 10)
        computerChoiceLabel = createLabel(with: "(O)", fontSize: 20, weight: .regular)
        computerLabel = createLabel(with: "Computer:".localized(), fontSize: 20, weight: .regular)
        computerCountLabel = createLabel(with: "0", fontSize: 20, weight: .regular)
        
        exitButton = createExitButton()
        
        containerView = createContainerView()
        imagesStackView = createStackView(axis: .vertical, spacing: 10, distribution: .fillEqually)
        row1StackView = createStackView(axis: .horizontal, spacing: 10, distribution: .fillEqually)
        row2StackView = createStackView(axis: .horizontal, spacing: 10, distribution: .fillEqually)
        row3StackView = createStackView(axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        box1 = createBoxImageView()
        box2 = createBoxImageView()
        box3 = createBoxImageView()
        box4 = createBoxImageView()
        box5 = createBoxImageView()
        box6 = createBoxImageView()
        box7 = createBoxImageView()
        box8 = createBoxImageView()
        box9 = createBoxImageView()
    }

    func addSubviews() {
        view.addSubview(backgroundImageView)
        
        difficultyStackView.addArrangedSubview(difficultyLabel)
        difficultyStackView.addArrangedSubview(difficultyModeLabel)
        
        playerStackView.addArrangedSubview(playerChoiceLabel)
        playerStackView.addArrangedSubview(playerLabel)
        playerStackView.addArrangedSubview(playerCountLabel)
        
        computerStackView.addArrangedSubview(computerChoiceLabel)
        computerStackView.addArrangedSubview(computerLabel)
        computerStackView.addArrangedSubview(computerCountLabel)
        
        labelesStackView.addArrangedSubview(difficultyStackView)
        labelesStackView.addArrangedSubview(scoreLabel)
        labelesStackView.addArrangedSubview(playerStackView)
        labelesStackView.addArrangedSubview(computerStackView)
        
        row1StackView.addArrangedSubview(box1)
        row1StackView.addArrangedSubview(box2)
        row1StackView.addArrangedSubview(box3)
        
        row2StackView.addArrangedSubview(box4)
        row2StackView.addArrangedSubview(box5)
        row2StackView.addArrangedSubview(box6)
        
        row3StackView.addArrangedSubview(box7)
        row3StackView.addArrangedSubview(box8)
        row3StackView.addArrangedSubview(box9)
        
        
        imagesStackView.addArrangedSubview(row1StackView)
        imagesStackView.addArrangedSubview(row2StackView)
        imagesStackView.addArrangedSubview(row3StackView)
        
        containerView.addSubview(imagesStackView)
        
        view.addSubview(containerView)
        view.addSubview(labelesStackView)
        view.addSubview(exitButton)
    }
    
    func layoutSubview() {
        backgroundImageView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            labelesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            
            imagesStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imagesStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            imagesStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            imagesStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
}
