//
//  Papers.swift
//  PaperReferences
//
//  Created by Mudit Verma on 8/22/20.
//  Copyright © 2020 Mudit Verma. All rights reserved.
//

import Foundation

struct Person{
    var name: String
}

public struct Paper: Codable{
    var title: String
    var authors: [String]
    var date: Date
    var bibtex: String
//    var abstract: String
//    var done: Bool
//    var dateAdded: Date
//    var dateDone: Date
//    var authors: [Person]

}





public class TableData: NSObject {
    private var papers : [Paper]
    let url: String

    
    
    public init(jsonPath: String){
        url = jsonPath
        
        
        // read stuff from json and make it into Paper.
        let datefirst = Date()
        let first = Paper(title: "first", authors: ["1", "2"], date: datefirst, bibtex: "woah")
        let second = Paper(title: "second", authors: ["5", "3"], date: datefirst, bibtex: "hey")
        papers = [first, second]
        
    }
    
    func getData() -> [Paper] {
        loadData()
        
        return papers
    }
    
    private func loadData(){
        // use url here
        guard let dummyDataURL = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json"),
                   let dummyData = try? Data(contentsOf: dummyDataURL)
                   else {
//                    print ("some problem")
                    return }
        
        
//        print ("loaded something")
        
        let data = dummyData
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        print(json)
        
//        STILL NOT COMPLETE>...
        if let array = json as? [Any] {
            if let firstObject = array.first {
                // access individual object in array
            }

            for object in array {
                // access all objects in array
            }

            for case let string as String in array {
                // access only string values in array
            }
        }
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            papers = try decoder.decode([Paper].self, from: dummyData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
