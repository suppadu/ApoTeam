//
//  MemberRedactPresenter.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 13.12.2021.
//

import Foundation
import RealmSwift

class MemberRedactPresenter {
    var member: Member
    var new: Bool
    var memberInDB: Member? = nil
    var urlImg: String = ""
    var inventory = List<String>()
    
    init(member: Member, new: Bool) {
        self.member = member
        self.new = new
        if !new {
            memberInDB = member
            self.member = Member(value: member)
        }
    }
    
    func getArrayInventory() -> [String] {
        return Repository.shared.emojiArray
    }
    
    func getRandomName(complit: @escaping(_ name: String) -> Void) {
        Repository.shared.getRandomUser { user in
            self.urlImg = user.results[0].picture.large
            complit(user.results[0].name.first + " " + user.results[0].name.last)
        }
    }
    
    func getRandomAvatar(complit: @escaping(_ dataImg: Data) -> Void) {
        Repository.shared.getRandomAvatar(urlImg) { dataImg in
            complit(dataImg)
        }
    }
    
    func getRandomStatus(complit: @escaping(_ status: String) -> Void) {
        Repository.shared.getRandomStatus { status in
            complit(status)
        }
    }
    
    func getRandomInventory(complit: @escaping(_ inventory: [String]) -> Void) {
        var array: [String] = []
        for _ in 0..<Int.random(in: 0...6){
            array.append(Repository.shared.emojiArray[Int.random(in: 0...6)])
        }
        complit(array)
    }
    
    func editMember(name: String, status: String, avatar: Data) {
        member.name = name
        member.status = status
        member.avatar = avatar
        member.invent = inventory
        if !new {
            memberInDB = Member(value: member)
            Repository.shared.editMemberInDB(member: memberInDB!)
        }
    }
}
