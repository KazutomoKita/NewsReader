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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = "http://appcre.net/rss.php"
        
        Alamofire.request(requestURL).responseJSON { response in
            switch response.result {
            case.Success(let json):
                print(json)
            case .Failure(let error):
                print("通信エラー:\(error)")
            }
        }
       
        // Do any additional setup after loading the view.
    }


}

