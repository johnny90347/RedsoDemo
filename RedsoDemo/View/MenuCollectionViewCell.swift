//
//  MenuCollectionViewCell.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    
    let categoreLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor = UIColor.white
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupMenuCell()
        self.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool{
        
        didSet{
            if isSelected == true{
                categoreLabel.textColor = .white
            }else{
                categoreLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
        }
        
    }
    
    func setupMenuCell() {
        self.addSubview(categoreLabel)
        categoreLabel.translatesAutoresizingMaskIntoConstraints = false
        categoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        categoreLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        categoreLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
}
