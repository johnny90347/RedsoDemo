//
//  ViewController.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoBar()
      
    }

    
    let logoBar : LogoBar = {
        
        let logoBar = LogoBar()
        return logoBar
    }()

    
    private func setupLogoBar(){
        
    }
    
}


class LogoBar: UIView {
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = .black
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
