//
//  BudgetVC.swift
//  MyProjects
//
//  Created by Vik Holovach on 25.05.2022.
//

import UIKit

class BudgetVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func personalBudgetButton(_ sender: UIButton) {
        

    }
    
    @IBAction func familyBudgetButton(_ sender: UIButton) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
