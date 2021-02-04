//
//  NetRestTableViewCell.swift
//  demol
//
//  Created by Dayuan on 2021/2/3.
//

import UIKit

struct netCellModel {
    var code:String
    var time:String
}

class NetRestTableViewCell: UITableViewCell {
    
    public let codeLabel:UILabel = {
        let label = UILabel.init()
        return label
    }()
    public let timeLabel:UILabel = {
        let label = UILabel.init()
        return label
    }()
    open var model:netCellModel?{
        didSet{
            if let inmodel = model{
                if inmodel.code == "200" {
                    self.codeLabel.textColor = .green
                }else{
                    self.codeLabel.textColor = .red
                }
                self.codeLabel.text = inmodel.code;
                self.timeLabel.text = inmodel.time;
            }
    
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.codeLabel)
        self.contentView.addSubview(self.timeLabel)
        
        self.codeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24);
            make.centerY.equalToSuperview()
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24);
            make.centerY.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
