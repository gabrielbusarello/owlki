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

class TaskJson {

    let id: Int;
    let name: String;
    let status: String;
    let idChallenge: Int;

    init (json: [String: AnyObject]) {
        self.id = json["id"] as? Int ?? 0;
        self.name = json["name"] as? String ?? "";
        self.status =  json["status"] as? String ?? "";
        self.idChallenge =  json["idChallenge"] as? Int ?? 0;
    }

}

class TaskDAO {
    
    static func getList() -> [Task] {
        return [
            Task(id: 1, name: "Lição de casa", status: "N", idChallenge: 1),
            Task(id: 2, name: "Limpar o quarto", status: "F", idChallenge: 1)
        ];
    }

    static func getTasks (callback: @escaping ((TaskJson) -> Void)) {
        
        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/owlkitasks?_id=task1"
        
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
                        
                        let task = TaskJson(json: json[0])
                        
                        callback(task)
                        
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
    
}
