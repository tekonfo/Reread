//
//  doApi.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/07/24.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import Foundation
import UIKit


class URLSessionGetClient{
    //query形成のための関数作る
    func add_query(query_data: String) -> String{
        let types = ["title","creator"]
        var string = ""
        for (index, type) in types.enumerated(){
            string += type + "=\"" +  query_data + "\" "
            if index != types.count-1 {
                string += "or "
            }
        }
        string += "mediatype" + "=\"" +  "1" + "\" "
        return string
    }
    func parse_xml(data: Data){
        
    }
}
