//
//  SnackBarView.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 26.09.2022.
//

import UIKit

class SnackbarView: UIView {
    
    //MARK: - Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.textColor = .main
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    init(text: String, frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.text = text
        backgroundColor = .softWhite
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
}
