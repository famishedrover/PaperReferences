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

public struct Paper: Decodable{
    var title: String
    var authors: [String]
    var date: String   // must be string for now since we are reading from json which has everything as string...                     // Using Date() does not work well.
    var bibtex: String

}





public class TableData: NSObject {
    private var papers : [Paper]
    let url: String

    
    
    public init(jsonPath: String){
        url = jsonPath
        
        
        // read stuff from json and make it into Paper.
        let first = Paper(title: "first", authors: ["1", "2"], date: "02.04.2020", bibtex: "woah")
        let second = Paper(title: "second", authors: ["5", "3"], date: "02.04.2020", bibtex: "hey")
        papers = [first, second]
        
    }
    
    func getData() -> [Paper] {
        loadData()
        
        return papers
    }
    
    private func loadData(){
        // use url here
        guard let jsonDataURL = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json"),
                   let jsonData = try? Data(contentsOf: jsonDataURL)
                   else {
//                    print ("some problem")
                    return }
        
        
//        print ("loaded something")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            papers = try decoder.decode([Paper].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
