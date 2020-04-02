import UIKit

import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView

    var newsDataArray= NSArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
            //ニュース記事を取得したらテーブルビューに表示
                
            case .Failure(let error):
                print("通信エラー:\(error)")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath: NSIndexPath) -> UITableViewCell {
        
        //StoryBoardで取得したCellを取得
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        //ニュース記事データを取得(配列の"indexPath.row版目の要素を取得")
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        //タイトルとタイトルの行数、公開日時をCellにセット
        cell.textLabel!.text = newsDic["title"] as? String
        cell.textLabel!.numberOfLines = 3
        cell.detailTextLabel!.text = newsDic["publishedDate"] as? String
        
        return cell
    }
    
     //テーブルビューのセルがタップされた処理を追加
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //セルのインデックスパス番号を出力
        print("タップされたセルのインデックスパス:\(indexPath.row)")
        //ニュース記事データを取得
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        //ニュース記事のURLを取得
        let newsURL = newsDic["unescapedURL"] as! String
        //StringをNSURLに変換
        let url = NSURL(string:newsURL)
        //UIApplicationインスタンスを作成
        let app = UIApplication.sharedAppication()
        //openURLメソッドURLを引数にWEBブラウザSafariを起動
        app.openURL(url)
    }
    
   


}

