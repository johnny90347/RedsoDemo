//
//  HomeViewController.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit




class HomeViewController: UIViewController {
    
   
    
    var rangerInfos:[SingleData] = []
    
    var isDownloading = false
    
   
    
    let refreshcontrol = UIRefreshControl()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         setupTableView()
        
        getJsonData(pageNumber: pageNumber)
        
        
//         UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1734000428, alpha: 1)
        
       
        refreshcontrol.attributedTitle = NSAttributedString(string: "正在更新")
        
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "personCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshcontrol
        refreshcontrol.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)

        
        

    }
    
    @objc func refresh(){
        print("更新")
        self.refreshcontrol.endRefreshing()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    
    
     var pageNumber = 0
    
    
    func getJsonData(pageNumber:Int){
         self.isDownloading = true
        
        let urlString = "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=rangers&page=\(pageNumber)"
        
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
                
                for info in jsonData.results {
                    self.rangerInfos.append(info)
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
    
    
    
 
   

}





extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rangerInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
            cell.configureCell(data: rangerInfos[indexPath.row])
            
            return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.height
        let contentOffsetY = scrollView.contentOffset.y
        let bottomContenOffsetY = contentOffsetY - height
        if bottomContenOffsetY  <= height {
            
            if isDownloading == false && pageNumber <= 9{
                getJsonData(pageNumber: pageNumber)
            }
           
        }
    }
    
    
}





