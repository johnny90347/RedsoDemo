//
//  HomeCollectionViewCell.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit


class DynamoCell:HomeCollectionViewCell{
    
}


class ElasticCell:HomeCollectionViewCell{
    
}



class HomeCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rangerInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        as! PersonTableViewCell
        cell.configureCell(data: rangerInfos[indexPath.row])
        return cell
    }
    
    
    
    let tableView = UITableView()
    
    var rangerInfos:[SingleData] = []
    
   
    
    
      let refreshcontrol = UIRefreshControl()
    
        override init(frame: CGRect) {
        super .init(frame: frame)
       
         
        
      
        refreshcontrol.attributedTitle = NSAttributedString(string: "正在更新")
        
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "personCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshcontrol
        refreshcontrol.addTarget(self, action: #selector(refresh), for:  UIControl.Event.valueChanged)
        setupTableView()
        
        
        
        
    }
    
    var isDownloading = false
    var pageNumber = 0
    var category:String?
    var update:Bool = true
    
    
    func fetchCategoryFeed(category:String,pageNumber:Int){
        
        if isDownloading == false {
            self.category = category
            isDownloading = true
            APIService.shareInstance.fetchFeed(category: category, pageNumber: pageNumber) {[weak self] (data) in
                guard let self = self else {return}
                self.rangerInfos = data
                
                self.isDownloading = false
                self.pageNumber = 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
       
    }
    
    
    
    func updateCategoryFeed(category:String,pageNumber:Int){
        
        if isDownloading == false {
            self.category = category
            isDownloading = true
            APIService.shareInstance.fetchFeed(category: category, pageNumber: pageNumber) {[weak self] (data) in
                guard let self = self else {return}
                for index in data {
                    self.rangerInfos.append(index)
                }
                self.isDownloading = false
                self.pageNumber += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func refresh(){
        print("更新")
        refreshcontrol.endRefreshing()
//        getJsonData(pageNumber: pageNumber, category: category!)
    }
    
    private func setupTableView(){
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
//    func getJsonData(pageNumber:Int,category:String,update:Bool){
//
//            self.isDownloading = true
//            self.category = category
//            self.update = update
//            self.pageNumber = pageNumber
//
//
//        }
    
    

    
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let height = scrollView.frame.height
                let contentOffsetY = scrollView.contentOffset.y
                let bottomContenOffsetY = contentOffsetY - height
                if bottomContenOffsetY  <= height {
                    update = true
                    if isDownloading == false && pageNumber <= 9 && update == true{
                        updateCategoryFeed(category: category!, pageNumber: pageNumber)
                    }

                }
            }
    
   
    
    
}
