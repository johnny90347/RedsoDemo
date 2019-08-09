//
//  PersonTableViewCell.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit
import SDWebImage






class PersonTableViewCell: UITableViewCell {
    
    let profileImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "test")
        imageview.layer.cornerRadius = 60
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Matchman Ho"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let positionLabel:UILabel = {
        let label = UILabel()
        label.text = "Principal Engineer"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    let skillTextView:UITextView = {
        let textView = UITextView()
        textView.text = "Python,Google Cloud,kuberntes"
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return textView
    }()
    
    
    let adImageView: UIImageView = {
        let imageview = UIImageView()
        
        return imageview
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .red
        setupPersonCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func setupPersonCell(){
        self.addSubview(nameLabel)
        self.addSubview(positionLabel)
        self.addSubview(skillTextView)
        self.addSubview(profileImageView)
        self.addSubview(adImageView)
      
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120 ).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,constant: 8 ).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        positionLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        positionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        skillTextView.translatesAutoresizingMaskIntoConstraints = false
        skillTextView.leadingAnchor.constraint(equalTo: positionLabel.leadingAnchor).isActive = true
        skillTextView.topAnchor.constraint(equalTo: positionLabel.bottomAnchor).isActive = true
        skillTextView.trailingAnchor.constraint(equalTo: positionLabel.trailingAnchor).isActive = true
        skillTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skillTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        adImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        adImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        adImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        adImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    
    func configureCell(data:SingleData){
        
        
        profileImageView.image = nil
        adImageView.image = nil
        
        
        
        if let urlString = data.url  {
            let url = URL(string: urlString)
            adImageView.sd_setImage(with: url, completed: nil)
        }
        

        
        
        
        
        if let name = data.name,
                let position = data.position,
                let expertisArray = data.expertise,
            let avatarUrlString = data.avatar{
            
            var expertisString = ""
            for i  in expertisArray.enumerated(){
                if i.offset == 0 {
                    expertisString = i.element
                }else{
                    expertisString += "," + i.element
                }
            }
            
            skillTextView.text = expertisString
            nameLabel.text = name
            positionLabel.text = position
            profileImageView.sd_setImage(with: URL(string: avatarUrlString), completed: nil)
            
        }
        
            
        
            
        
      
       
        
    }
  
}
