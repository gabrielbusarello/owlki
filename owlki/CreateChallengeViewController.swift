//
//  CreateChallengeViewController.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import UIKit

class CreateChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var reward: UITextField!
    @IBOutlet weak var deadLine: UITextField!
    @IBOutlet weak var taskList: UITableView!

    var challenge: Challenge?;
    var tasks = [Task]();

    override func viewDidLoad() {
        super.viewDidLoad()

        taskList.delegate = self
        taskList.dataSource = self

        self.challenge = ChallengeDAO.getList().first!;
        self.tasks = TaskDAO.getList()
        // Do any additional setup after loading the view.
        self.reward.text? = self.challenge?.reward ?? "";
        self.deadLine.text? = self.challenge?.deadLine ?? "";
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskColumn", for: indexPath);

        if let taskCell = cell as? CreateChallengeTaskTableViewCell {
            let task = tasks[indexPath.row];
            
            taskCell.task.text = task.name;
            
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
