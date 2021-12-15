//
//  NetworkService.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 07.12.2021.
//

import Foundation

class NetworkService {
    
    func getStatus(complit: @escaping (_ data: Data) -> Void) {
        let random = Int.random(in: 1..<102)
        print(random)
        request("https://www.breakingbadapi.com/api/quotes/\(random)", httpMethod: .GET) { data in
            complit(data)
        }
    }
    
    func getRandomUser(complit: @escaping (_ data: Data) -> Void){
        request("https://randomuser.me/api/", httpMethod: .GET) { data in
            complit(data)
        }
    }
    
    func getAvatar(_ url: String, complit: @escaping (_ data: Data) -> Void) {
        request("\(url)", httpMethod: .GET) { data in
//            print(data)
            complit(data)
        }
    }
}



extension NetworkService {
    private func request(_ url: String, param: [String:String] = [:], httpMethod: HttpMethod, header: [String:String] = ["Accept":"application/json"], complit: @escaping (_ data: Data) -> Void){
        var dataReturn: Data!
        let url = URL(string: "\(url)")!
        var request = URLRequest(url: url)
        
        switch httpMethod {
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
            
        }
        
        request.allHTTPHeaderFields = header

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, erorr in
            dataReturn = data
            complit(dataReturn)
            
        }.resume()
    }
    private enum HttpMethod {
        case GET
        case POST
    }
}
