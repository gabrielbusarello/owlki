//
//  Challenge.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import Foundation

class Challenge {

    let id: Int;
    let reward: String;
    let deadLine: String;
    let percent: String;
    let idUser: Int;
    let nameUser: String;

    init (id: Int, reward: String, deadLine: String, percent: String, idUser: Int, nameUser: String) {
        self.id = id;
        self.reward = reward;
        self.deadLine = deadLine;
        self.percent = percent;
        self.idUser = idUser;
        self.nameUser = nameUser;
    }

}

class ChallengeDAO {
    
    static func getList() -> [Challenge] {
        return [
            Challenge(id: 1, reward: "Skin de jojinho", deadLine: "06/03/2020", percent: "50%", idUser: 1, nameUser: "Fulano"),
            Challenge(id: 2, reward: "Dolce Gusto", deadLine: "06/03/2020", percent: "60%", idUser: 2, nameUser: "Fulano2")
        ];
    }
    
    static func getChallenge (callback: @escaping (([Challenge]) -> Void)) {
        
        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/owlkichallenges/all"
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let challenge = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        var challenges: [Challenge] = [];
                        
                        for challenge in json {
                            challenges.append(Challenge(id: challenge["challenge_id"] as! Int, reward: challenge["challenge_reward"] as! String, deadLine: challenge["challenge_deadline"] as! String, percent: challenge["challenge_percent"] as! String, idUser: challenge["challenge_user_id"] as! Int, nameUser: challenge["challenge_user_name"] as! String));
                        }
                        
                        callback(challenges)
                        
                    }else {
                        
                        print("fudeuuuu")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
            
        })
        
        challenge.resume()
    }
    
}
