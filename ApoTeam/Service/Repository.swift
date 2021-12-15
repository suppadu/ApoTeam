//
//  Repository.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 08.12.2021.
//

import Foundation
import RealmSwift

class Repository {
    let realm = try! Realm()
    var teams = try! Realm().objects(Team.self)
    
    private let ns: NetworkService
    static var shared = Repository(ns: NetworkService())
    
    private init(ns: NetworkService){
        self.ns = ns
        loadTeamsInDB()
//        print(String(describing: realm.configuration.fileURL))
    }
    
    //постоянный массив элемнтов которые могут быть в инвентаре
    let emojiArray = ["🎩", "🧤", "👑", "🔧", "🔫", "🔪", "🗡"]
    
    //MARK: - Все для создания новой команды НЕ пустой
    
    private let newInvent = ["🎩", "", "", "", "", "", ""]
    private var newMember: Member {
        let newMember = Member()
        let listInvent = List<String>()
        for str in newInvent {
            listInvent.append(str)
        }
        newMember.invent = listInvent
        return newMember
    }
    var newTeam: Team {
        let newTeam = Team()
        newTeam.name = "New Team"
        let listMembers = List<Member>()
        for _ in 0..<3 {
            listMembers.append(newMember)
        }
        newTeam.members = listMembers
        return newTeam
    }
//    var editMember: Member {
//        newMember
//    }
    
    //MARK: - Функции получения данных из сети
    
    func getRandomUser(complit: @escaping (_ user: RandomUser) -> Void) {
        ns.getRandomUser { data in
            let userDecode = try? JSONDecoder().decode(RandomUser.self, from: data)
            if let user = userDecode {
                complit(user)
//                complit(user.results[0].name.first + " " + user.results[0].name.last)
            }
        }
    }
    
    func getRandomStatus(complit: @escaping (_ status: String) -> Void) {
        ns.getStatus { data in
            let statusDecode = try? JSONDecoder().decode(Status.self, from: data)
            if let status = statusDecode {
                if status.isEmpty == false {
                    complit(status[0].quote)
                }
                else {
                    complit("Everyone is replaceable, including me")
                }
            }
        }
    }
    
    func getRandomAvatar(_ url: String, complit: @escaping (_ dataImg: Data) -> Void) {
        ns.getAvatar(url) { data in
            complit(data)
        }
    }
    
    //MARK: - Функции для БД
    
    func saveTeamInDB(team: Team) {
        try! realm.write({
            self.realm.add(team)
        })
        loadTeamsInDB()
    }
    
    func loadTeamsInDB() {
        teams = realm.objects(Team.self)
    }
    
    func editTeamInDB(team: Team) {
        try? realm.write({
            self.realm.add(team, update: .all)
        })
    }
    
    func editMemberInDB(member: Member) {
        try? realm.write({
            self.realm.add(member, update: .all)
        })
    }
}
