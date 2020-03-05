//
//  ChallengeViewController.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var conclusion: UILabel!
    @IBOutlet weak var deadLine: UILabel!
    @IBOutlet weak var reward: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var taskList: UITableView!
    @IBOutlet weak var challengeViewTop: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var createChallengeButton: UIButton!
    
    var tasks = [Task]();
    
    var challenge: Challenge?;
    var idUser: Int?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskList.delegate = self
        taskList.dataSource = self
        
        ChallengeDAO.getChallenge(idUser: idUser ?? UserDefaults.standard.integer(forKey: "user_id")) { (challenge) in
            self.challenge = challenge;
            self.reward.text? = self.challenge?.reward ?? "";
            let deadLineArr = self.challenge!.deadLine.split(separator: "-")
            self.deadLine.text? = "\(deadLineArr[2])/\(deadLineArr[1])/\(deadLineArr[0])"
            self.conclusion.text? = "\(self.challenge?.percent ?? "")%";
            self.name.text? = self.challenge?.nameUser ?? "";
            
            let nmbPercent = (Double)(self.challenge!.percent)!;
            self.challengeViewTop.backgroundColor = nmbPercent < 33 ? UIColor.red : (nmbPercent < 66 ? UIColor.yellow : UIColor.green)

            TaskDAO.getTasks (idChallenge: self.challenge!.id) { (tasks) in self.tasks = tasks; self.taskList.reloadData(); }
        };
        
        if (UserDefaults.standard.integer(forKey: "father_id") == 0) {
            self.logoutButton.isHidden = true;
            self.createChallengeButton.isHidden = false;
        } else {
            self.logoutButton.isHidden = false;
            self.createChallengeButton.isHidden = true;
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskList.dequeueReusableCell(withIdentifier: "taskColumn", for: indexPath);
        
        if let taskCell = cell as? ChallengeTaskTableViewCell {
            let task = tasks[indexPath.row];
            
            taskCell.task.text = task.name;
            taskCell.status.text = (task.status == "1") ? "\u{2713}" : "\u{2717}";
            
            return taskCell;
        }
        
        return cell;
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createChallenge") {
            if let cchallengeView = segue.destination as? CreateChallengeViewController {
                cchallengeView.idUser = self.challenge?.idUser;
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC(vcInstance: self, sender);
    }

}
