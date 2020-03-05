//
//  Task.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import Foundation

class Task {

    let id: Int;
    let name: String;
    let status: String;
    let idChallenge: Int;

    init (id: Int, name: String, status: String, idChallenge: Int) {
        self.id = id;
        self.name = name;
        self.status = status;
        self.idChallenge = idChallenge;
    }

}

class TaskDAO {
    
    static func getList() -> [Task] {
        return [
            Task(id: 1, name: "Lição de casa", status: "N", idChallenge: 1),
            Task(id: 2, name: "Limpar o quarto", status: "F", idChallenge: 1)
        ];
    }

    static func getTasks (callback: @escaping (([Task]) -> Void)) {
        
        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/owlkitasks/all"
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        var tasks: [Task] = [];

//                        let task = Task(json: json[0])
                        
                        for task in json {
                            tasks.append(Task(id: task["task_id"] as! Int, name: task["task_name"] as! String, status: task["task_status"] as! String, idChallenge: task["task_challenge_id"] as! Int));
                        }
                        
                        callback(tasks)
                        
                    }else {
                        
                        print("fudeuuuu")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
            
        })
        
        task.resume()
    }

//    static func createTask (callback: @escaping ((Task) -> Void)) {
//
//        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/inserttask"
//
//        guard let url = URL(string: endpoint) else {
//            print("Erroooo: Cannot create URL")
//            return
//        }
//
//        let urlRequest = URLRequest(url: url)
//
//        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
//
//            if error != nil {
//                print("Error = \(String(describing: error))")
//                return
//            }
//
//            let responseString = String(data: data!, encoding: String.Encoding.utf8)
//            print("responseString = \(String(describing: responseString))")
//
//            DispatchQueue.main.async() {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
//                        var tasks: [Task] = [];
//
//                        let task = Task(json: json[0])
//
//                        for task in json {
//                            tasks.append(Task(id: task["task_id"] as! Int, name: task["task_name"] as! String, status: task["task_status"] as! String, idChallenge: task["task_challenge_id"] as! Int));
//                        }
//
//                        callback(tasks)
//
//                    }else {
//
//                        print("fudeuuuu")
//                    }
//                } catch let error as NSError {
//                    print("Error = \(error.localizedDescription)")
//                }
//            }
//
//
//        })
//
//        task.resume()
//    }
//
}
