//
//  HomeViewController.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 25.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Outlets & Subviews
    var backgroundImage: UIImageView!
    var ticTacToeLabel: UILabel!
    
    var containerView: UIView!
    var textField: UITextField!
    var welcomeLabel: UILabel!
    var startButton: UIButton!
    var modeButton: UIButton!
    var containerStackView: UIStackView!
    var buttonsStackView: UIStackView!
    
    var modeSettingsPupUpView: PopUpView!
    
    //MARK: - Variables
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    var difficultyMode: DifficultyMode = .easy {
        didSet {
            updateModeButtonColor()
        }
    }
    
    var isPopUpShown: Bool = false

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutSubviews()
    }
    
    //MARK: - Actions & @objc
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    @objc private func startButtonDidTapped() {
        guard let text = textField.text, !text.isEmpty else {
            showSnackbar(with: "🗿 " + "Enter your name".localized())
            return
        }
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.playerName = text
        gameVC.computerLogic = difficultyMode.difficultyLogic
        gameVC.difficultyName = difficultyMode.description
        textField.text = nil
        present(gameVC, animated: false)
    }
    
    @objc private func modeButtonDidTapped() {
        if isPopUpShown {
            dismissPopUp()
        } else {
            showPopUp()
        }
    }
    
    //MARK: - Private Methods
    private func initialSetup() {
        setupSubviews()
        addSubviews()
        textField.delegate = self
        startButton.addTarget(self, action: #selector(startButtonDidTapped), for: .touchUpInside)
        modeButton.addTarget(self, action: #selector(modeButtonDidTapped), for: .touchUpInside)
        configurePopUpCallBacks()
    }
    
    private func updateModeButtonColor() {
        modeButton.configuration?.baseBackgroundColor = difficultyMode.color
    }
    
    private func showPopUp() {
        isPopUpShown = true
        let frame = CGRect(x: 0, y: 0, width: containerView.frame.width / 2, height: containerView.frame.height)
        modeSettingsPupUpView.frame = frame
        modeSettingsPupUpView.frame.origin.x = view.frame.width
        modeSettingsPupUpView.frame.origin.y = containerView.frame.maxY + 10
        view.addSubview(modeSettingsPupUpView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
            self.modeSettingsPupUpView.frame.origin.x = self.containerView.center.x
        }
    }
    
    private func dismissPopUp() {
        isPopUpShown = false
        UIView.animate(withDuration: 0.2) {
            self.modeSettingsPupUpView.frame.origin.x = self.view.frame.width
        } completion: { done in
            self.modeSettingsPupUpView.removeFromSuperview()
        }
    }
    
    private func configurePopUpCallBacks() {
        modeSettingsPupUpView.actionHandler = { [weak self] mode in
            guard let mode = mode else {
                self?.dismissPopUp()
                return
            }
            self?.difficultyMode = mode
            self?.dismissPopUp()
        }
    }
}

//MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
