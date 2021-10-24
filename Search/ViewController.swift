//
//  ViewController.swift
//  Search
//
//  Created by 森部高昌 on 2021/10/11.
//

import UIKit
import MapKit


class ViewController: UIViewController,UISearchBarDelegate {
    
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
        print(req_url)//入力されていたら、urlを表示する
    }
    
    //private var searchCompleter = MKLocalSearchCompleter()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.delegate = self
        searchText.placeholder = "検索する地名を入力"
                
    }
    
    
    
// --------------------------------------
//        tableView.delegate = self
//        tableView.dataSource = self
//        searchCompleter.delegate = self
//
//        // 東京駅を中心にして検索する
//        let tokyoStation = CLLocationCoordinate2DMake(35.6811673, 139.7670516) // 東京駅
//        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001) // ここは適当な値です
//        let region = MKCoordinateRegion(center: tokyoStation, span: span)
//        searchCompleter.region = region
//
//        searchCompleter.resultTypes = .address //地図上の位置のみ検索する
////        searchCompleter.resultTypes = .pointOfInterest //
////        searchCompleter.resultTypes = .query //
// --------------------------------------
        
}


//--------------------------------
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchCompleter.results.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        //
//        let completion = searchCompleter.results[indexPath.row]
//                cell.textLabel?.text = completion.title
//                cell.detailTextLabel?.text = completion.subtitle
//
//        return cell
//    }
//}
//
//
//extension ViewController: MKLocalSearchCompleterDelegate {
//
//    // 正常に検索結果が更新されたとき
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        tableView.reloadData()
//    }
//
//    // 検索が失敗したとき
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        // エラー処理
//    }
//}
