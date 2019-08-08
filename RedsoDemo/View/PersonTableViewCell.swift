//
//  PersonTableViewCell.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit

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
        
        
        
    }
    
    
    func updateCell(data:SingleData){
        guard let name = data.name,
            let position = data.position,
            let expertisArray = data.expertise,
            let avatar = data.avatar
        else {return}
        nameLabel.text = name
        positionLabel.text = position
        
        var expertisString = ""
        for i  in expertisArray.enumerated(){
            if i.offset == 0 {
                expertisString = i.element
            }else{
                expertisString += "," + i.element
            }
        }
       
        skillTextView.text = expertisString
        
    }
  
}
