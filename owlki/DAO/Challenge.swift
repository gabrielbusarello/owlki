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
    let idUser: Int;

    init (id: Int, reward: String, deadLine: String, idUser: Int) {
        self.id = id;
        self.reward = reward;
        self.deadLine = deadLine;
        self.idUser = idUser;
    }

}

class ChallengeDAO {
    
    static func getList() -> [Challenge] {
        return [
            Challenge(id: 1, reward: "Skin de jojinho", deadLine: "06/03/2020", idUser: 1),
            Challenge(id: 2, reward: "Dolce Gusto", deadLine: "06/03/2020", idUser: 2)
        ];
    }
    
}