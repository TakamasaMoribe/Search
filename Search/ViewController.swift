//
//  ViewController.swift
//  Search
//
//  Created by 森部高昌 on 2021/10/11.
//

import UIKit
import MapKit


class ViewController: UIViewController,UISearchBarDelegate,XMLParserDelegate {
    
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる
        view.endEditing(true)
        if let searchWord = searchBar.text {
            print(searchWord)
        //入力されていたら、地名を検索する
            searchPlace(keyword: searchWord)
        }
    }
    
    //searchPlace メソッド
    // 第一引数：keyword 検索したい語句
    func searchPlace(keyword:String) {
        // keyword をurlエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        // リクエストurlの組み立て
        guard let req_url = URL(string: "https://geocode.csis.u-tokyo.ac.jp/cgi-bin/simple_geocode.cgi?addr=\(keyword_encode)") else {
            return
        }
        // リクエストに必要な情報を生成する
        let req = URLRequest(url: req_url)
        
        let task = URLSession.shared.dataTask(with: req, completionHandler: {(data,response,error) in
        let parser:XMLParser? = XMLParser(data:data!)
        parser!.delegate = self
        parser!.parse()
        })
        
        // ダウンロード開始
        task.resume()
        print(req_url)//入力されていたら、urlを表示する
    }
    
    //private var searchCompleter = MKLocalSearchCompleter()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.delegate = self
        searchText.placeholder = "検索する地名を入力"
    }
    
}
