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
    
    var tasks = [Task]();
    
    var challenge: Challenge?;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = TaskDAO.getList()
        
        taskList.delegate = self
        taskList.dataSource = self
        
        self.challenge = ChallengeDAO.getList().first!;
        
        self.reward.text? = self.challenge?.reward ?? "";
        self.deadLine.text? = self.challenge?.deadLine ?? "";
        self.conclusion.text? = self.challenge?.percent ?? "";
        self.name.text? = self.challenge?.nameUser ?? "";

        
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
            taskCell.status.text = task.status;
            
            return taskCell;
        }
        
        return cell;
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
