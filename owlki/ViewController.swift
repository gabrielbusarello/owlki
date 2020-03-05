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
        loginUser(user: user.text!, password: password.text!, callback: { (user) in
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
    
    private func loginUser (user: String, password: String, callback: @escaping ((User) -> Void)) {
        
        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/login/\(user)/\(password)";
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
//        JSONEncoder()
//        urlRequest.httpBody = JSONEncoder("");
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                        var user: User;

                        user = User(id: json["user_id"] as! Int, name: json["user_name"] as! String, user: json["user"] as! String, password: json["user_password"] as! String, idFather: json["user_father_id"] as? Int)

                        callback(user)

                    }else {
                        
                        print("fudeuuuu")
                    }
                } catch let error as NSError {
                    callback(User(id: 0, name: "", user: "", password: ""))
                    print("Error = \(error.localizedDescription)")
                }
            }
            
            
        })
        
        task.resume()
    }


}

