//
//  TeamRealm.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 14.12.2021.
//

import Foundation
import RealmSwift

class Team: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    dynamic var members: List<Member> = List()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
