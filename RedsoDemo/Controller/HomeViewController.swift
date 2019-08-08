//
//  HomeViewController.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import UIKit


struct Result:Codable {
    var results:[SingleData]
}

struct SingleData:Codable {
    var name:String?
    var position:String?
    var expertise:[String]?
    var avatar:String? //頭像
    var url:String?
}


//struct PersonInfo {
//    var name:String?
//    var position:String?
//    var expertise:String?
//    var avatar:String?
//    var url:String?
//}



class HomeViewController: UIViewController {
    
    let logoBar:LogoBar = {
        let view = LogoBar()
        return view
    }()
    
    let menuBar:MenuBar = {
        let view = MenuBar()
        return view
    }()
    
    let tableView = UITableView()
    
    var personInfos = [SingleData]()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getJsonData()
        
        
         UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.1734000428, alpha: 1)
        
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "personCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.dataSource = self
        tableView.delegate = self
   

        setupLogoBar()
        
        setupMenuBar()
        
        setupTableView()
        
       
     
    }
    
    func getJsonData(){
        
        
        let urlString = "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=rangers&page=0"
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, uRLResponse, error) in
            guard let self = self else {return}
            
            if error != nil{
                print("獲取資料失敗")
                return
            }
            guard let data = data else {return}
            do{
                let jsonData = try JSONDecoder().decode(Result.self, from: data)
                self.personInfos = jsonData.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print("解析失敗")
            }
            
            
        }
        task.resume()
        
        
        
        
        
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
    
    
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
   

}





extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
            cell.updateCell(data: personInfos[indexPath.row])
            
            return cell
        }
        
    }
    
    
}





