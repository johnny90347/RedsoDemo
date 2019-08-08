//
//  ImageTableViewCell.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    let adImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = UIColor.yellow
        return imageview
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupADimageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupADimageView(){
        
        self.addSubview(adImageView)
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        adImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        adImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        adImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        adImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        adImageView.heightAnchor.constraint(equalToConstant: 145).isActive = true
        
    }
    
    
}
