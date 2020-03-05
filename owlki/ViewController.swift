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

        self.hideKeyboardWhenTappedAround();
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        UserDAO.loginUser(user: user.text!, password: password.text!, callback: { (user) in
            if (user.id != 0) {
                UserDefaults.standard.set(true, forKey: "status");
                UserDefaults.standard.set(user.idFather == 1, forKey: "child");
                UserDefaults.standard.set(user.id, forKey: "user_id");
                UserDefaults.standard.set(user.name, forKey: "user_name");
                UserDefaults.standard.set(user.idFather, forKey: "father_id");
                Switcher.updateRootVC(vcInstance: self, sender);
            } else {
                let alert = UIAlertController(title: "Alerta!", message: "Usuário ou senha incorretos", preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
    //            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        });
    }


}

