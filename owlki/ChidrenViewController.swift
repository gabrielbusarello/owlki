//
//  ChidrenViewController.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import UIKit

class ChidrenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var childrenList: UITableView!
    
    var childrenUser = [User]();

    override func viewDidLoad() {
        super.viewDidLoad()

        welcome.text? = "Bem vindo, \(UserDefaults.standard.string(forKey: "user_name") ?? "")!";
        
        childrenList.delegate = self
        childrenList.dataSource = self
        
        self.childrenUser = UserDAO.getList();
    }

    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC(vcInstance: self, sender);
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "childChallenge" {
//            if let musicView = segue.destination as? MusicViewController,
//                let index = tableView.indexPathForSelectedRow?.row {
//                musicView.musicReciver = musics[index];
//            }
        } else if segue.identifier == "createChild" {
            if let createChildView = segue.destination as? CreateChildViewController {
                createChildView.idUser? = 1; // Mudar isso!!!
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenUser.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "childColumn", for: indexPath);

        if let childCell = cell as? ChildTableViewCell {
            let childUser = childrenUser[indexPath.row];
            
            childCell.name.text = childUser.name;
            
            return childCell;
        }

        return cell;
    }

}
