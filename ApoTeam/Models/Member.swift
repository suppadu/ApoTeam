//
//  MemberRealm.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 14.12.2021.
//

import Foundation
import RealmSwift

class Member: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = "New member"
    @objc dynamic var status: String = "Status"
    dynamic var invent: List<String> = List<String>()
    @objc dynamic var avatar: Data = Data()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
