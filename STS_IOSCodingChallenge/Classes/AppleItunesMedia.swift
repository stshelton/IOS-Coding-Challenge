//
//  AppleItunesMedia.swift
//  STS_IOSCodingChallenge
//
//  Created by Spencer Shelton on 10/21/19.
//  Copyright © 2019 Spencer Shelton. All rights reserved.
//

import Foundation
import Alamofire

class AppleItunesMedia{
    
    struct apiKeys{
        static let ARTIST_NAME = "artistName"
        static let ARTIST_URL = "artistUrl"
        static let ARTWORK_URL = "artworkUrl100"
        static let GENRES = "genres"
        static let GENRE_NAME = "name"
        static let GENRE_URL = "url"
        static let KIND_OF_MUSIC = "kind" //album or single
        static let NAME_OF_MUSIC = "name"
        static let LINK_TO_MUSIC = "url"
        static let RELEASE_DATE = "releaseDate"
    }
    
    var ArtistName = String()
    var ArtistURL = String()
    var ArtworkURL = String()
    var KindOfMusic = String()
    var NameOfMusic = String()
    var LinkToMusic = String()
    var ReleaseDate = String()
    var Genres: [Genre]  = [Genre]()
    
    
    /**
    Constructor for reading json data from api
    - Parameters:
    - json: json retuned as dictionary from api
     */
    init(json:NSDictionary) {
        if let artistname = json[apiKeys.ARTIST_NAME] as? String, let artistURL = json[apiKeys.ARTIST_URL] as? String, let artWorkURL = json[apiKeys.ARTWORK_URL] as? String, let kindOfMusic = json[apiKeys.KIND_OF_MUSIC] as? String, let nameOfMusic = json[apiKeys.NAME_OF_MUSIC] as? String, let linkToMusic = json[apiKeys.LINK_TO_MUSIC] as? String, let releaseDate = json[apiKeys.RELEASE_DATE] as? String{
            
            ArtistName = artistname
            ArtistURL = artistURL
            ArtworkURL = artWorkURL
            KindOfMusic = kindOfMusic
            NameOfMusic = nameOfMusic
            LinkToMusic = linkToMusic
            ReleaseDate = releaseDate
            
        }
        if let genres = json[apiKeys.GENRES] as? [NSDictionary]{
            for genre in genres{
                Genres.append(Genre(json: genre))
            }
        }
    }
    
    
    
}
