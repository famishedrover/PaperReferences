//
//  TableModel.swift
//  PaperReferences
//
//  Created by Mudit Verma on 8/22/20.
//  Copyright © 2020 Mudit Verma. All rights reserved.
//

import Foundation

struct Papers: Codable{
    var id : Int?
}

struct PaperInfo: Codable {
    var id: Int?
    var title: String?
    var bibtex: String?
}

struct AuthorsInfo: Codable{
    var id: Int?
    var names: String?
}
