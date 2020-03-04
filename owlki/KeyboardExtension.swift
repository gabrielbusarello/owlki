//
//  KeyboardExtension.swift
//  owlki
//
//  Created by Student on 03/03/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//
import UIKit;

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
