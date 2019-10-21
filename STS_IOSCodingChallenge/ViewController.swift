//
//  ViewController.swift
//  STS_IOSCodingChallenge
//
//  Created by Spencer Shelton on 10/21/19.
//  Copyright © 2019 Spencer Shelton. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getAppleItunesMedia()
        // Do any additional setup after loading the view.
    }
    
    func getAppleItunesMedia(){
        let url = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
        Alamofire.request(url).responseJSON { (response) in
            if let result = response.result.value {
                if let json = result as? NSDictionary{
                    if let feed = json["feed"] as? NSDictionary{
                        //print(feed)
                        if let results = feed["results"] as? [NSDictionary]{
                            for artist in results{
                             let artist =    AppleItunesMedia(json: artist)
                                print(artist)
                            }
                            print(results)
                        }
                    }
                    //print(json["feed"] )
                }
            }
        }
        
    }


}

