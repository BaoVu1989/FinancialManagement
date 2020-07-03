//
//  ExpenseTransactionViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit
import CoreData

class ExpenseTransactionViewController: UIViewController {

    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var imgExpenseCategory: UIImageView!
    @IBOutlet weak var lblExpenseName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtNote: UITextField!
    
    var nameImage = "category"
    var nameCategory:String = "Category"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Expense Detail"
        
        //Custom Button Save
        btnSave.layer.borderColor = UIColor.lightGray.cgColor
        btnSave.layer.borderWidth = 1
        btnSave.layer.cornerRadius = 5
        
        //Custom Button Choose Income Category
        btnChoose.layer.borderColor = UIColor.lightGray.cgColor
        btnChoose.layer.borderWidth = 1
        btnChoose.layer.cornerRadius = 5
        
        //Appear category and its lable
        imgExpenseCategory.image = UIImage(named: nameImage)
        lblExpenseName.text = nameCategory
        
        //Appear current date
        lblDate.text = "\(day)/\(month)/\(year)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //This action is to insert data of Expenses into Core Data
    @IBAction func btn_Save(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: context)
        let image = imgExpenseCategory.image?.pngData()
        newItem.setValue(image, forKey: "image")
        newItem.setValue(txtAmount.text, forKey: "amount")
        newItem.setValue(txtNote.text, forKey: "note")
        newItem.setValue(lblDate.text, forKey: "date")
        newItem.setValue(lblExpenseName.text, forKey: "name")
        do{
            try context.save()
            print("Saved")
        }catch{
            print("Error")
        }
        let screen = storyboard?.instantiateViewController(withIdentifier: "IAEVC") as! IncomeAndExpenseViewController
        navigationController?.pushViewController(screen, animated: true)
    }
}
