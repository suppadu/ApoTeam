//
//  Team.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 06.12.2021.
//

import Foundation

class Team {
    
    var name: String
    var members: [Member]
    
    init(name: String, members: [Member]){
        self.name = name
        self.members = members
    }
}
