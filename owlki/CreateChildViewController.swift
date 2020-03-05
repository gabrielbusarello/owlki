//
//  CreateChildViewController.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import UIKit

class CreateChildViewController: UIViewController {

    var idUser: Int?;
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround();
       
    }
    
    @IBAction func cadastra(_ sender: Any) {
        if (name.text == "" && user.text == "" && password.text == "") {
            let alert = UIAlertController(title: "Alerta!", message: "Preencha todos os campos", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(name.text == ""){
            let alert = UIAlertController(title: "Alerta!", message: "O campo nome deve ser preenchido", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(user.text == ""){
            let alert = UIAlertController(title: "Alerta!", message: "O campo usuário deve ser preenchido", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(password.text == ""){
            let alert = UIAlertController(title: "Alerta!", message: "O campo senha deve ser preenchido", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            UserDAO.getLastUser { (userLU) in
                if (userLU.id != 0) {
                    UserDAO.createUser(id: "user\(userLU.id + 1)", userId: userLU.id + 1, user: self.user.text ?? "", user_name: self.name.text ?? "", user_password: self.password.text ?? "", user_father_id: UserDefaults.standard.integer(forKey: "user_id"), callback: { (user) in print(user) })

                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "defaulthome") as! ChidrenViewController;

                    vc.navigationItem.setHidesBackButton(true, animated: true)

                    self.view.window?.rootViewController!.show(vc, sender: sender);
                }
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
