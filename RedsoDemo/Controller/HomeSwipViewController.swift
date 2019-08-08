//
//  HomeSwipViewController.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit

class HomeSwipViewController: UIViewController {
    
    let logoBar:LogoBar = {
        let view = LogoBar()
        return view
    }()
    
    let menuBar:MenuBar = {
        let view = MenuBar()
        return view
    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogoBar()
        
        setupMenuBar()
        
       
    }
    
    private func setupLogoBar(){
        
        view.addSubview(logoBar)
        logoBar.translatesAutoresizingMaskIntoConstraints = false
        logoBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        logoBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        logoBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        logoBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: logoBar.bottomAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
}
