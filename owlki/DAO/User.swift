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
    var idPai: Int?

    init (id: Int, name: String, user: String, password: String, idPai: Int?) {
        self.id = id;
        self.name = name;
        self.user = user;
        self.password = password;
        self.idPai = idPai;
    }
    
    // Convenience initializer
    convenience init(id: Int, name: String, user: String, password: String) {
        self.init(id: id, name: name, user: user, password: password, idPai: nil);
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
            User(id: 6, name: "Walter Junior", user: "waltinhoJJ", password: "Walter", idPai: 5)
        ];
    }
    
}
