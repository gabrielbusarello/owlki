//
//  User.swift
//  owlki
//
//  Created by Gabriel Dezan Busarello on 29/02/20.
//  Copyright © 2020 Gabriel Dezan Busarello. All rights reserved.
//

import Foundation

class User {

    let id: Int;
    let name: String;
    let user: String;
    let password: String;
    var idFather: Int?

    init (id: Int, name: String, user: String, password: String, idFather: Int?) {
        self.id = id;
        self.name = name;
        self.user = user;
        self.password = password;
        self.idFather = idFather;
    }
    
    // Convenience initializer
    convenience init(id: Int, name: String, user: String, password: String) {
        self.init(id: id, name: name, user: user, password: password, idFather: nil);
    }

}

class UserDAO {
    
    static func getList() -> [User] {
        return [
            User(id: 1, name: "Gabriel", user: "dezan", password: "Gabriel"),
            User(id: 2, name: "Jenifer", user: "jenifer", password: "Jenifer"),
            User(id: 3, name: "Luan", user: "luan", password: "Luan"),
            User(id: 4, name: "Vinícius", user: "vinicius", password: "Vinícius"),
            User(id: 5, name: "Walter", user: "waltinho", password: "Walter"),
            User(id: 6, name: "Walter Junior", user: "waltinhoJJ", password: "Walter", idFather: 5)
        ];
    }
        
    static func loginUser (user: String, password: String, callback: @escaping ((User) -> Void)) {
        
        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/login/\(user)/\(password)";
        
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
    

    static func createUser(id: String, userId: Int, user: String, user_name: String, user_password: String, user_father_id: Int, callback: @escaping ((User) -> Void)) {

        let endpoint: String = "https://telegramjesidioapp.mybluemix.net/insertuser"

        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }

        var urlRequest = URLRequest(url: url)

        let parameters: [String: Any] = [
            "_id": id, "user_id": userId, "user": user, "user_name": user_name, "user_password": user_password, "user_father_id": user_father_id
        ];
        
        do {
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

                if error != nil {
                    print("Error = \(String(describing: error))")
                    return
                }

                let responseString = String(data: data!, encoding: String.Encoding.utf8)
                print("responseString = \(String(describing: responseString))")

                DispatchQueue.main.async() {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                            var user: User

    //                        let task = Task(json: json[0])

                            user = User(id: json["user_id"] as! Int, name: json["user_name"] as! String, user: json["user"] as! String, password: json["user_password"] as! String, idFather: json["user_father_id"] as? Int);

                            callback(user)

                        }else {

                            print("fudeuuuu")
                        }
                    } catch let error as NSError {
                        print("Error = \(error.localizedDescription)")
                    }
                }


            })

            task.resume()
        } catch {
            print("Deu ruim");
        }
    }
    
}
