//
//  MusicCell.swift
//  STS_IOSCodingChallenge
//
//  Created by Spencer Shelton on 10/21/19.
//  Copyright © 2019 Spencer Shelton. All rights reserved.
//

import Foundation
import UIKit
/**
  Protocol used for buttons within UITableview Cell
   */
protocol ButtonsClicked {
    /**
      View Artist buton was clicked
      - Parameters:
      - musicInfo: info connected to music user selected
       */
    func viewArtist(musicInfo: AppleItunesMedia)
    
    /**
     View Album  buton was clicked
     - Parameters:
     - musicInfo: info connected to music user selected
     */
    func viewAlbum(musicInfo: AppleItunesMedia)
}



class MusicCell: UITableViewCell{
    var delegate: ButtonsClicked?
    var musicInfo: AppleItunesMedia? {
        didSet{
            ArtworkImage.sd_setImage(with: URL(string: musicInfo!.ArtworkURL), completed: nil)
            ArtistNameLabel.text = musicInfo?.ArtistName
            NameOfMusic.text = musicInfo?.NameOfMusic
            ReleaseDate.text = musicInfo?.ReleaseDate
            ViewMusic.setTitle("View \(musicInfo?.KindOfMusic ?? "Album")", for: .normal)
            
        }
    }
    
    
    private let ArtistNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.label
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    private let NameOfMusic: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.label
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    private let ReleaseDate: UILabel = {
          let lbl = UILabel()
              lbl.textColor = UIColor.secondaryLabel
              lbl.font = UIFont.systemFont(ofSize: 12)
              return lbl
    }()
    
    private let ArtworkImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let ViewArtist : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.secondarySystemBackground
        btn.layer.cornerRadius = 5
        btn.setTitleColor(UIColor.label, for: .normal)
        btn.setTitle("View Artist", for: .normal)
        return btn
    }()
    
    private let ViewMusic: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.label, for: .normal)
        btn.setTitle("View Album", for: .normal)
        return btn
    }()
    
    @objc func ViewMusicClicked(){
        if let info = self.musicInfo{
             self.delegate?.viewAlbum(musicInfo: info)
        }
       
    }
    
    @objc func ViewArtistClicked(){
        if let info = self.musicInfo{
              self.delegate?.viewArtist(musicInfo: info)
        }
      
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(ArtworkImage)
        addSubview(ArtistNameLabel)
        addSubview(NameOfMusic)
        addSubview(ReleaseDate)
        
        //setting Constriants
        ArtworkImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil , right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 60, height: 60, enableInsets: false)
        NameOfMusic.anchor(top: topAnchor, left: ArtworkImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        ArtistNameLabel.anchor(top: NameOfMusic.bottomAnchor, left: ArtworkImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        ReleaseDate.anchor(top: ArtistNameLabel.bottomAnchor, left: ArtworkImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        //creating stack view to host buttons
        let stackView = UIStackView(arrangedSubviews: [ViewArtist, ViewMusic])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 0
        addSubview(stackView)
        stackView.anchor(top: ArtworkImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 50, enableInsets: false)
        
        //adding targets to bottons
        self.ViewMusic.addTarget(self, action: #selector(ViewMusicClicked), for: .touchUpInside)
        self.ViewArtist.addTarget(self, action: #selector(ViewArtistClicked), for: .touchUpInside)
        
        
        
    }
    
   required init?(coder aDecoder: NSCoder) {
    fatalError(" has not been implemented")
    }
}
