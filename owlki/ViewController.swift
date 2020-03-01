//
//  ViewController.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 16/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        if (user.text == "dezan" && password.text == "Gabriel") {
            UserDefaults.standard.set(true, forKey: "status");
            UserDefaults.standard.set(false, forKey: "child");
            Switcher.updateRootVC(vcInstance: self, sender);
        } else {
            let alert = UIAlertController(title: "Alerta!", message: "Usuário ou senha incorretos", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
//            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }


}

