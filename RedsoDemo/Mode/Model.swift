//
//  Model.swift
//  RedsoDemo
//
//  Created by 梁鑫文 on 2019/8/8.
//  Copyright © 2019 Johhny. All rights reserved.
//

import Foundation



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

