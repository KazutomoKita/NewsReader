//
//  ViewController.swift
//  NewsReader
//
//  Created by Kazutomo Kita on 2020/03/30.
//  Copyright © 2020 Kazutomo Kita. All rights reserved.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    var newsDataArray= NSArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = "http://appcre.net/rss.php"
        
        Alamofire.request(requestURL).responseJSON { response in
            switch response.result {
            case.Success(let json):
            //JSONデータをNSDictionaryに
            let jsonDic = json as! NSDictionary
            //辞書化したjsonDicからキー値"responseData"を取り出す
            let responseData = jsonDic["resposeData"] as! NSDictionary
            //responseDataからキー値"results"を取り出す
            self.newsDataArray = responseData["results"] as! NSArray
            print("\(self.newsDataArray)")
                
            case .Failure(let error):
                print("通信エラー:\(error)")
            }
        }
       
        // Do any additional setup after loading the view.
    }


}

