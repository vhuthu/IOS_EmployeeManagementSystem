//
//  DetailsViewController.swift
//  APIProject
//
//  Created by DA MAC M1 162 on 2023/05/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var text2Label: UILabel!
    
    var numLabel: String?
    var titleLbl: String?
    var titleLbl2 : String?
    var departL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numberLabel.text = numLabel
        textLabel.text = titleLbl
        departmentLabel.text = departL
        text2Label.text = titleLbl2
    }
    

}
