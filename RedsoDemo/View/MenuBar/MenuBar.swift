//
//  MenuBar.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit


extension MenuBar:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCollectionViewCell
        let categorys = ["Rangers","Elastic","Dynamo"]
        cell.categoreLabel.text = categorys[indexPath.row]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        HomeSwipViewController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
    }
    
    
   
    
}


class MenuBar:UIView{
    
    
    
    var HomeSwipViewController:HomeSwipViewController?

    
    let collectionView :UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.backgroundColor = UIColor.black
        return collectionview
        }()
    
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")

        
        setupMenuBar()
        
        setupHorizontalBar()
        
        //一開始就讓第一個item的燈亮起來
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    
    
    
  
    
    var horizontalBarledingAnchorConstraint:NSLayoutConstraint?
    
    
    
    //MARK: 水平bar 設置
    func setupHorizontalBar(){
  
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .white
        self.addSubview(horizontalBarView)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
       horizontalBarledingAnchorConstraint = horizontalBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        horizontalBarledingAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        
    }
    
    //MARK: mrnuBar 設置
    func setupMenuBar(){
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }


}
