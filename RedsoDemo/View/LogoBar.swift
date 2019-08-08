//
//  LogoBar.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit


class LogoBar: UIView {
    
    
    let logoLabel:UILabel = {
        let label = UILabel()
//        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        
        var myString:String = "RedSo"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica-Bold", size: 40)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:3,length:2))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:3))
        
        label.attributedText = myMutableString
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = .black
        setupLogo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLogo(){
        self.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        logoLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        logoLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
       
        
    }
    
}
