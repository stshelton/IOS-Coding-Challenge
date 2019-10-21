//
//  Genre.swift
//  STS_IOSCodingChallenge
//
//  Created by Spencer Shelton on 10/21/19.
//  Copyright © 2019 Spencer Shelton. All rights reserved.
//

import Foundation
class Genre{
    
    struct apiKeys{
        static let GENRE_NAME = "name"
        static let GENRE_URL = "url"
    }
    
    var Name = String()
    var URL = String()
    
    /**
      Constructor for reading json data from api
      - Parameters:
      - json: json retuned as dictionary from api
       */
    init(json: NSDictionary) {
        if let name = json[apiKeys.GENRE_NAME] as? String, let genreURL = json[apiKeys.GENRE_URL] as? String{
            self.Name = name
            self.URL = genreURL
        }
    }
}
