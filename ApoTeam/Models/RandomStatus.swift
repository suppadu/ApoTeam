//
//  RandomStatus.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 08.12.2021.
//

import Foundation

class RandomStatus: Codable {
    let quote: String
    init(quote: String){
        self.quote = quote
    }
}

typealias Status = [RandomStatus]
