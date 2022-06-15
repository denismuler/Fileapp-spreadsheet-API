//
//  File.swift
//  Test_App
//
//  Created by Georgie Muler on 15.06.2022.
//

import Foundation

struct File: Decodable {
  var name: String
  var id: String
  var parentId: String?
  var type: FileType
}

enum FileType: String, Decodable {
    case file = "f"
    case directory = "d"
}
