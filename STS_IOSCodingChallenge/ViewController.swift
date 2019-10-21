//
//  ViewController.swift
//  STS_IOSCodingChallenge
//
//  Created by Spencer Shelton on 10/21/19.
//  Copyright © 2019 Spencer Shelton. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SafariServices

class ViewController: UITableViewController {
    
    var appleMusic = [AppleItunesMedia]()
    let cellID = "cell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAppleItunesMedia()
        tableView.register(MusicCell.self, forCellReuseIdentifier: cellID)
        // Do any additional setup after loading the view.
    }
    
    
    /**
    Get  the latest 10 upcoming albums on itunes 
     */
    func getAppleItunesMedia(){
        let url = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
        Alamofire.request(url).responseJSON { (response) in
            if let result = response.result.value {
                if let json = result as? NSDictionary{
                    if let feed = json["feed"] as? NSDictionary{
                        //print(feed)
                        if let results = feed["results"] as? [NSDictionary]{
                            for artist in results{
                             let artist = AppleItunesMedia(json: artist)
                                self.appleMusic.append(artist)
                            }
                            print(results)
                            self.tableView.reloadData()
                        }
                        
                    }
                }
            }
        }
        
    }


}

//MARK: TABLE VIEW DELEGATE AND DATA SOURCE
extension ViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MusicCell{
            cell.musicInfo = appleMusic[indexPath.row]
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appleMusic.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: SAFARI VC DELEGATE
extension ViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: BUTTONS DELEGATE
extension ViewController: ButtonsClicked{
    func viewAlbum(musicInfo: AppleItunesMedia) {
        if let URL = URL(string: musicInfo.LinkToMusic){
            let vc = SFSafariViewController(url: URL)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    func viewArtist(musicInfo: AppleItunesMedia) {
        if let URL = URL(string: musicInfo.ArtistURL){
            let vc = SFSafariViewController(url: URL)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    
}

