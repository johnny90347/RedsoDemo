//
//  APIService.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/9.
//  Copyright © 2019 Johhny. All rights reserved.
//

import Foundation


class APIService:NSObject{
    
    static let shareInstance = APIService()
    
    
    func fetchFeed(category:String,pageNumber:Int,completion:@escaping ([SingleData])->()){
        let urlString = "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=\(category)&page=\(pageNumber)"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {(data, uRLResponse, error) in
          
            if error != nil{
                print("獲取資料失敗")
                return
            }
            
            guard let data = data else {return}
            print(data.count)
            if data.count <= 30 {
                print("沒東西 不解析")
                return
            }

            do{
                
                let jsonData = try JSONDecoder().decode(Result.self, from: data)
                let results = jsonData.results
                completion( results )
                    }catch{
                print("解析失敗")
                return
            }
            
            
        }
        task.resume()

    }
    
    private override init() {
        print("被初始化了")
    }
    
    
    
}
