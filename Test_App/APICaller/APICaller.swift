//
//  APICaller.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import Foundation

class APICaller {
    func callAPI() {
        guard let url = URL(string: "https://sheetdb.io/api/v1/ev7ycrfrs5p4v") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let string = String (data: data, encoding: .utf8) {
                print (string)
            }
        }
            task.resume()
    }
       
}
                               
struct FileData: Decodable {
    let type: Bool
    let name: String
    let id: Int
}
