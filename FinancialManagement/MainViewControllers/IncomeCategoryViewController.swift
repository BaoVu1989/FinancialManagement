//
//  IncomeCategoryViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit

class IncomeCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var IncomeCategoryTableView: UITableView!
    
    var arrayImageName = ["bonus","cash","check","commission","gift","profit"]
    var arrayName = ["Bonus","Salary","Check","Commission","Gift","Profit From Assets"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Income Categories"
        IncomeCategoryTableView.delegate = self
        IncomeCategoryTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CellIncomeCategoryTableViewCell
        cell.imgCategory.image = UIImage(named: arrayImageName[indexPath.row])
        cell.lblName.text = arrayName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = storyboard?.instantiateViewController(withIdentifier: "ITVC") as! IncomeTransactionViewController
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
