//
//  Member.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 06.12.2021.
//

import Foundation

class Member {
    var name: String
    var status: String
    var invent: [String]
    var avatar: Data
    
    init(name: String, status: String, invent: [String], avatar: Data){
        self.name = name
        self.status = status
        self.invent = invent
        self.avatar = avatar
    }
}
