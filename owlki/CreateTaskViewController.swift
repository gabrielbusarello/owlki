//
//  CreateTaskViewController.swift
//  owlki
//
//  Created by Student on 02/03/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    @IBOutlet weak var task: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround();

        // Do any additional setup after loading the view.
    }
    
    @IBAction func send(_ sender: Any) {
        if (task.text == "") {
            let alert = UIAlertController(title: "Alerta!", message: "É necessário preencher a tarefa", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            //            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            
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
