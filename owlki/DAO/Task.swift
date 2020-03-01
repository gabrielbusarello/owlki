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
    
}
