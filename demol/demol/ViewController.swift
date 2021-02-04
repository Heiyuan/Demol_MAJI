//
//  ViewController.swift
//  demol
//
//  Created by Dayuan on 2021/2/1.
//

import UIKit
import SwiftyJSON
import RxCocoa
import RxSwift
import SnapKit
class ViewController: UIViewController {
    let disposeBag = DisposeBag.init()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false;
        return tableView
    }()
    var dataArr:NSMutableArray = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataJsonStr = UserDefaults.standard.string(forKey: "DATAJSONSTR");
        if let jsonStr = dataJsonStr{
            let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false)
            let arr:NSArray  = try! JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers) as! NSArray
            self.dataArr = NSMutableArray.init(array: arr)
        }
        
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(0)
        }
       
        
        Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler())
            .subscribe(onNext: { (state) in
                self.request()
            })
            .disposed(by: disposeBag)
        
        
        if self.dataArr.count > 0 {
            self.tableView.scrollToRow(at: IndexPath.init(row: self.dataArr.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
        }
        
    }
    
    func request() {
        DYApiTool.request("https://api.github.com/") { (json, statusCode) in
            let time = String.getCurrentTimeStampWithS()
            let date = time.timeWithTimeInterval()
            let code = "\(statusCode)"
            let data = ["time":date,"code":code,"json":json.description] as [String : String];
            self.dataArr.add(data);
            
            let jsondata = try? JSONSerialization.data(withJSONObject: self.dataArr, options: [])
            let jsonStr = String(data: jsondata!, encoding: String.Encoding.utf8)
            UserDefaults.standard.setValue(jsonStr, forKey: "DATAJSONSTR")
            self.tableView.reloadData();
            self.tableView.scrollToRow(at: IndexPath.init(row: self.dataArr.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
        } error: { (err) in
            
        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArr.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell:NetRestTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NetRestTableViewCellid") as? NetRestTableViewCell;
        if cell == nil{
            cell = NetRestTableViewCell(style: .default, reuseIdentifier: "NetRestTableViewCellid")
            cell!.selectionStyle = .none
        }
        
        let data:[String : String] = self.dataArr.object(at: indexPath.row) as! [String : String];
        let model = netCellModel.init(code: data["code"]!, time: data["time"]!);
        cell?.model = model;
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data:[String : String] = self.dataArr.object(at: indexPath.row) as! [String : String];
        let vc = RestViewController.init()
        vc.dataStr = data["json"]!
        vc.timeStr = data["time"]!
        self.present(vc, animated: true, completion: nil)
    }
}
