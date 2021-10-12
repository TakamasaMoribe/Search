//
//  ViewController.swift
//  Search
//
//  Created by 森部高昌 on 2021/10/11.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address //地図上の位置のみ検索する
//        searchCompleter.resultTypes = .pointOfInterest //
//        searchCompleter.resultTypes = .query //
    }
    
    @IBAction private func textFieldEditingChanged(_ sender: Any) {
        //
        searchCompleter.queryFragment = textField.text!
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCompleter.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //
        let completion = searchCompleter.results[indexPath.row]
                cell.textLabel?.text = completion.title
                cell.detailTextLabel?.text = completion.subtitle
        
        return cell
    }
}


extension ViewController: MKLocalSearchCompleterDelegate {
    
    // 正常に検索結果が更新されたとき
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        tableView.reloadData()
    }
    
    // 検索が失敗したとき
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // エラー処理
    }
}
