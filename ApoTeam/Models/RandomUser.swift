//
//  RandomUser.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 07.12.2021.
//

import Foundation

class RandomUser: Codable {
    var results: [Resultat]
    init(results: [Resultat]){
        self.results = results
    }
}

class Resultat: Codable {
    let gender: String
    let name: Name
    let picture: Picture
    
    init(gender: String, name: Name, picture: Picture){
        self.gender = gender
        self.name = name
        self.picture = picture
    }
}

class Name: Codable {
    let first: String
    let last: String
    
    init(first: String, last: String){
        self.first = first
        self.last = last
    }
}

class Picture: Codable {
    let large: String
    init(large: String){
        self.large = large
    }
}
