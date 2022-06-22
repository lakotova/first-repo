//
//  PersonalBudgetVC.swift
//  MyProjects
//
//  Created by Vik Holovach on 25.05.2022.
//

import UIKit

enum TableViewSelector {
    case sevings, income, debt, expenses
}

class PersonalBudgetVC: UIViewController {
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet weak var sevingsTable: UITableView!
    
    @IBOutlet weak var incomeTable: UITableView!
    
    @IBOutlet weak var debtTable: UITableView!
    
    @IBOutlet weak var expensesTable: UITableView!
    
    @IBOutlet weak var sevingsView: UIView!
    
    @IBOutlet weak var incomeView: UIView!
    
    @IBOutlet weak var debtView: UIView!
    
    @IBOutlet weak var expensesView: UIView!
    
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var countTextField: UITextField!
   
    var cellTableViewSevings = [ModelCell]()
    var cellTableViewIncome = [ModelCell]()
    var cellTableViewDebt = [ModelCell]()
    var cellTableViewExpenses = [ModelCell]()
    var sevings = [String]()
    var countSevings = [String]()
    var income = [String]()
    var countIncome = [String]()
    var debt = [String]()
    var countDebt = [String]()
    var expenses = [String]()
    var countExpenses = [String]()
    var moneyImage = [UIImage]()
    var dataSelector: TableViewSelector = .sevings
    var indexColorArray = [Int]()
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImages()
        initTableView()
        initView()
        initCollectionView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func addImages() {
        moneyImage = [
            UIImage(named: "wallet1")!, UIImage(named: "wallet2")!, UIImage(named: "wallet3")!, UIImage(named: "wallet4")!, UIImage(named: "wallet5")!, UIImage(named: "dollar")!, UIImage(named: "working1")!, UIImage(named: "working2")!, UIImage(named: "working3")!, UIImage(named: "creditcard1")!, UIImage(named: "creditcard2")!, UIImage(named: "creditcard3")!, UIImage(named: "creditcard4")!, UIImage(named: "creditcard5")!,  UIImage(named: "shop1")!, UIImage(named: "shop2")!, UIImage(named: "shop3")!, UIImage(named: "shop4")!, UIImage(named: "shop5")!, UIImage(named: "shop6")!, UIImage(named: "shop7")!, UIImage(named: "shop8")!, UIImage(named: "shop9")!, UIImage(named: "shop10")!, UIImage(named: "pets1")!, UIImage(named: "pets2")!, UIImage(named: "kino1")!, UIImage(named: "kino2")!, UIImage(named: "home1")!, UIImage(named: "hous2")!, UIImage(named: "gym1")!, UIImage(named: "gym2")!, UIImage(named: "airplane1")!, UIImage(named: "airplane2")!, UIImage(named: "bus")!, UIImage(named: "car1")!, UIImage(named: "car2")!, UIImage(named: "present")!,
        ]
    }
    
    func initCollectionView() {
        photosCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
    }
    
    func initTableView() {
        sevingsTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        sevingsTable.dataSource = self
        sevingsTable.delegate = self
        incomeTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        incomeTable.dataSource = self
        incomeTable.delegate = self
        debtTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        debtTable.dataSource = self
        debtTable.delegate = self
        expensesTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        expensesTable.dataSource = self
        expensesTable.delegate = self
    }
    
    func initView() {
        sevingsView.layer.cornerRadius = 16
        sevingsView.layer.masksToBounds = true
        incomeView.layer.cornerRadius = 16
        incomeView.layer.masksToBounds = true
        debtView.layer.cornerRadius = 16
        debtView.layer.masksToBounds = true
        expensesView.layer.cornerRadius = 16
        expensesView.layer.masksToBounds = true
        //        photosCollectionView.layer.cornerCurve = 16
    }
    
    func showAlert() {
        blurView.backgroundColor = .black
        alertView.layer.cornerRadius = 20
        blurView.isHidden = false
        alertView.isHidden = false
        blurView.alpha = 0
        alertView.alpha = 0
        UIView.animate(withDuration: 0.45, animations: {
            self.blurView.alpha = 0.4
            self.alertView.alpha = 1
        })
    }
    
    func hideAlert() {
        self.blurView.alpha = 0
        self.alertView.alpha = 0
        UIView.animate(withDuration: 0.45, animations: {
            self.blurView.isHidden = true
            self.alertView.isHidden = true
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSavingButton(_ sender: Any) {
        dataSelector = .sevings
        showAlert()
    }
    @IBAction func addIncomeButton(_ sender: Any) {
        dataSelector = .income
        showAlert()
    }
    
    @IBAction func addDebtButton(_ sender: Any) {
        dataSelector = .debt
        showAlert()
    }
    
    @IBAction func addExpensesButton(_ sender: Any) {
        dataSelector = .expenses
        showAlert()
    }
    
    func alertEmptyTextField() {
        let alertSuccess = UIAlertController(title: "Error!", message: "Please fill in all cells!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction (title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alertSuccess.addAction(okAction)
           self.present(alertSuccess, animated: true, completion: nil)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        if nameTextField.text!.isEmpty || countTextField.text!.isEmpty || selectedIndex == nil {
            alertEmptyTextField()
        } else {
        let mdl = ModelCell(modelName: nameTextField.text!, modelCount: countTextField.text!, modelImage: moneyImage[selectedIndex!])
        switch dataSelector {
        case .sevings:
            cellTableViewSevings.append(mdl)
            sevingsTable.reloadData()
        case .income:
            cellTableViewIncome.append(mdl)
            incomeTable.reloadData()
        case .debt:
            cellTableViewDebt.append(mdl)
            debtTable.reloadData()
        case .expenses:
            cellTableViewExpenses.append(mdl)
            expensesTable.reloadData()
        }
        hideAlert()
        selectedIndex = nil
        self.photosCollectionView.reloadData()
        }
        if !nameTextField.text!.isEmpty || !countTextField.text!.isEmpty {
            nameTextField.text! = ""
            countTextField.text! = ""
        }
    }
    }


extension PersonalBudgetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case sevingsTable:
            return cellTableViewSevings.count
        case incomeTable:
            return cellTableViewIncome.count
        case debtTable:
            return cellTableViewDebt.count
        case expensesTable:
            return cellTableViewExpenses.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        var currentDataArray = [ModelCell]()
        switch tableView {
        case sevingsTable:
            currentDataArray = cellTableViewSevings
        case incomeTable:
            currentDataArray = cellTableViewIncome
        case debtTable:
            currentDataArray = cellTableViewDebt
        case expensesTable:
            currentDataArray = cellTableViewExpenses
        default:
            print("")
        }
        cell.sevingsLabel.text = currentDataArray[indexPath.row].modelName
        cell.countLable.text = currentDataArray[indexPath.row].modelCount
        cell.sevingsUIimageView.image = currentDataArray[indexPath.row].modelImage
        return cell
    }
}

extension PersonalBudgetVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moneyImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.moneyImageView.image = moneyImage[indexPath.row]
        if indexPath.row == selectedIndex {
            cell.borderView.backgroundColor = .lightGray
        } else {
            cell.borderView.backgroundColor = .white
        }
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.selectedIndex = indexPath.row
            collectionView.reloadData()
        }
    
}

