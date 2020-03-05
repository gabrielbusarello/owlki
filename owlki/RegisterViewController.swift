//
//  RegisterViewController.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//
import UIKit

class RegisterViewController: UIViewController{

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround();
        // Do any additional setup after loading the view.
    }
    
    @IBAction  func register(_ sender: Any) {
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
            UserDAO.createUser(id: "user9", userId: 9, user: user.text ?? "", user_name: name.text ?? "", user_password: password.text ?? "", user_father_id: 0, callback: { (user) in print(user) })

            self.navigationController?.popToRootViewController(animated: true)
        }
    
    /*
    // MARK: - Navigationa

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
