//
//  Networking.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import Foundation

protocol NetworkingDelegate {
    func showFiles(with files: [File])
}

class Networking {
    
    static var shared = Networking()
    
    var delegate: NetworkingDelegate?
    
    private var decoder = JSONDecoder()
    
    private init() {}
    
    func fetchFiles() {
        guard let url = URL(string: "https://sheetdb.io/api/v1/ev7ycrfrs5p4v") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let files = self.decodeFiles(with: data) {
                    self.delegate?.showFiles(with: files)
                } else {
                    // Error
                }
            }
        }.resume()
    }
    
    func decodeFiles(with data: Data) -> [File]? {
        do {
            let files = try decoder.decode([File].self, from: data)
            print(files)
            return files
        } catch {
            return nil
        }
    }
}
