//
//  ExpenseCategoryViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit

class ExpenseCategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var ExpenseTableView: UITableView!
    
    var arrayImageName = ["aircondition","animal","baby","book","carservice","clothes","computer","creditcard","doctor","drink","electricity","food","fuel","furniture","game","gas","gift","gym","hat","holiday","hospital","loanstudent","maintenance","market","meal","movie","newcar","oilchange","phone","publictransport","rent","service","shopping","tax","toy","travel","water","wifi"]
    var arrayName = ["Air Condition","Animal","Baby","Book","Car Service","Clothes","Computer","Credit Card","Doctor","Drink","Electricity","Food","Fuel","Funiture","Game","Gas","Souvenir","Gym","Hat","Holiday","Hospital","Loan Student","Maintenance House","Market","Meal","Movie","New Car","Oil Change","Phone","Public Transport","Rent House","Service","Shopping","Tax","Toy","Travel","Water","Wifi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ExpenseTableView.delegate = self
        ExpenseTableView.dataSource = self
        self.navigationItem.title = "Expense Categories"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayImageName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CellExpenseTableViewCell
        cell.imgCategory.image = UIImage(named: arrayImageName[indexPath.row])
        cell.lblName.text = arrayName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: "ETVC") as! ExpenseTransactionViewController
        screen.nameImage = arrayImageName[indexPath.row]
        screen.nameCategory = arrayName[indexPath.row]
        navigationController?.pushViewController(screen, animated: true)
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
