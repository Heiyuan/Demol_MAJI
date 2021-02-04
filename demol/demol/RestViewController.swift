//
//  RestViewController.swift
//  demol
//
//  Created by Dayuan on 2021/2/3.
//

import UIKit

class RestViewController: UIViewController {

    @IBOutlet weak var restTextView: UITextView!
    @IBOutlet weak var TimeLabel: UILabel!
    open var dataStr:String = "";
    open var timeStr:String = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        self.TimeLabel.text = timeStr;
        self.restTextView.text = dataStr;
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
