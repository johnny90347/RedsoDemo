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

        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshcontrol
        refreshcontrol.addTarget(self, action: #selector(refresh), for:  UIControl.Event.valueChanged)
        setupTableView()
        
        
        
        
    }
    
    var isDownloading = false
    var pageNumber = 0
    var category:String?
    
    
    func fetchCategoryFeed(category:String,pageNumber:Int){
        
        
            self.category = category
            APIService.shareInstance.fetchFeed(category: category, pageNumber: pageNumber) {[weak self] (data) in
                guard let self = self else {return}
                self.rangerInfos = data

                self.pageNumber = 1
                self.isDownloading = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        
       
    }
    
    
    
    func updateCategoryFeed(category:String,pageNumber:Int){
        
        
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
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func refresh(){
        print("更新")
        refreshcontrol.endRefreshing()
        fetchCategoryFeed(category: category!, pageNumber: 0)
    }
    
    private func setupTableView(){
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    

    

    
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let height = scrollView.frame.height
                let contentOffsetY = scrollView.contentOffset.y
                let bottomContenOffsetY = contentOffsetY - height
                if bottomContenOffsetY  <= height {
                   
                    if isDownloading == false && pageNumber <= 9{
                        updateCategoryFeed(category: category!, pageNumber: pageNumber)
                    }

                }
            }
    
   
    
    
}
