//
//  UIViewController+.swift
//  TicTacToeGame
//
//  Created by Алексей Павленко on 26.09.2022.
//

import UIKit

extension UIViewController {
    public func showSnackbar(with title: String) {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width/1.5, height: 60)
        let snackBar = SnackbarView(text: title, frame: frame)
        snackBar.center.x = view.center.x
        snackBar.center.y = view.frame.maxY + 100
        view.addSubview(snackBar)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
            snackBar.center = CGPoint(x: self.view.center.x, y: self.view.frame.maxY - 70)
        } completion: { done in
            UIView.animate(withDuration: 0.3, delay: 2) {
                snackBar.center = CGPoint(x: self.view.center.x, y: self.view.frame.maxY + 100)
            } completion: { done in
                snackBar.removeFromSuperview()
            }
        }
    }
}
