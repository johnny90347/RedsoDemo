//
//  HomeCollectionViewCell.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit



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
    
    var isDownloading = false
    
    
   
  
   
    
      let refreshcontrol = UIRefreshControl()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
       

        
      
        refreshcontrol.attributedTitle = NSAttributedString(string: "正在更新")
        
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "personCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshcontrol
        refreshcontrol.addTarget(self, action: #selector(refresh), for:       UIControl.Event.valueChanged)
        setupTableView()
        
//        getJsonData(pageNumber: 0, category: category!)
        
        
        
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
    
        var pageNumber = 0
        var category:String?
        var update:Bool = true
    
    func getJsonData(pageNumber:Int,category:String,update:Bool){
        
        
        
        
            
            self.isDownloading = true
            self.category = category
            self.update = update
        self.pageNumber = pageNumber
        
            let urlString = "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=\(category)&page=\(pageNumber)"
            guard let url = URL(string: urlString) else {return}
            
            let task = URLSession.shared.dataTask(with: url) {[weak self] (data, uRLResponse, error) in
                guard let self = self else {return}
                
                if error != nil{
                    print("獲取資料失敗")
                    return
                }
                
                guard let data = data else {return}
                print(data.count)
                self.pageNumber += 1
                
                if data.count <= 40 { //data太小就跳出 不往下跑了
                    self.isDownloading = false
                    return
                }
                
                do{
                    
                    let jsonData = try JSONDecoder().decode(Result.self, from: data)
                    
                    if self.update == false {
                        
                        self.rangerInfos = jsonData.results
                        self.pageNumber = 1
                    }else if self.update == true{
                        for info in jsonData.results {
                            
                            self.rangerInfos.append(info)
                            
                        }
                        
                    }
                    
                   
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.isDownloading = false
                    }
                }catch{
                    print("解析失敗")
                    return
                }
                
                
            }
            task.resume()
            

        }
        
    

    
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let height = scrollView.frame.height
                let contentOffsetY = scrollView.contentOffset.y
                let bottomContenOffsetY = contentOffsetY - height
                if bottomContenOffsetY  <= height {
                    update = true
                    if isDownloading == false && pageNumber <= 9 && update == true{
                        getJsonData(pageNumber: pageNumber,category: category!,update: true)
                    }

                }
            }
    
   
    
    
}
