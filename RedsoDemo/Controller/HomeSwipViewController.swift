//
//  HomeSwipViewController.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit


extension HomeSwipViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //return 3個cell 之後cell內容要換就很方便
        
        if indexPath.item == 0 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
                cell.fetchCategoryFeed(category: "rangers",pageNumber: 0)
            return cell
        }else if indexPath.item == 1 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "elasticCell", for: indexPath) as! ElasticCell

            cell.fetchCategoryFeed(category: "elastic",pageNumber: 0)
            return cell
        }else{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dynamoCell", for: indexPath) as! DynamoCell

            cell.fetchCategoryFeed(category: "dynamo",pageNumber: 0)

            return cell
        }
        
       
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //滾動時 拿 contenoffset.x / 4  更動menuBar 中的 水平bar 的 constraint 讓他追蹤到相對位置
        menuBar.horizontalBarledingAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        // 滑動collectionview的cell  menubar 被選中相對應的item
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    
}

class HomeSwipViewController: UIViewController {
    
    
    let logoBar:LogoBar = {
        let view = LogoBar()
        return view
    }()
    
    //****
    lazy var menuBar:MenuBar = {
        let view = MenuBar()
        view.HomeSwipViewController = self
        return view
    }()
    
    let collectionView :UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.backgroundColor = UIColor.white
        return collectionview
    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
         UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1734000428, alpha: 1)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ElasticCell.self, forCellWithReuseIdentifier: "elasticCell")
        collectionView.register(DynamoCell.self, forCellWithReuseIdentifier: "dynamoCell")
        collectionView.isPagingEnabled = true

        
        setupLogoBar()
        
        setupMenuBar()
        
        setupCollectionView()
        
        
    
      
       
    }
    

    
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    
    func scrollToMenuIndex(menuIndex:Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}
