//
//  IncomeTransactionViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit
import CoreData

let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)

class IncomeTransactionViewController: UIViewController {

    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var imgExpenseCategory: UIImageView!
    @IBOutlet weak var lblExpenseCategory: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtNote: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    var nameImage = "category"
    var nameCategory:String = "Category"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Income Detail"
        //Custom Button Save
        btnSave.layer.borderColor = UIColor.lightGray.cgColor
        btnSave.layer.borderWidth = 1
        btnSave.layer.cornerRadius = 5
        
        //Custome Button Choose Income Category
        btnChoose.layer.borderColor = UIColor.lightGray.cgColor
        btnChoose.layer.borderWidth = 1
        btnChoose.layer.cornerRadius = 5
        
        //Appear an image of expense category and its lable
        imgExpenseCategory.image = UIImage(named: nameImage)
        lblExpenseCategory.text = nameCategory
        
        //Appear current date
        lblDate.text = "\(day)/\(month)/\(year)"
    }
    //this action to transfer to IncomeCategoryViewController
    @IBAction func btn_Choose(_ sender: Any) {
        let screen = storyboard?.instantiateViewController(withIdentifier: "ICVC") as! IncomeCategoryViewController
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
    
    //This action is to insert data of Income into Core Data
    @IBAction func btn_Save(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Income", into: context)
        let image = imgExpenseCategory.image?.pngData()
        
        newItem.setValue(image, forKey: "image")
        newItem.setValue(txtAmount.text, forKey: "amount")
        newItem.setValue(txtNote.text, forKey: "note")
        newItem.setValue(lblDate.text, forKey: "date")
        newItem.setValue(lblExpenseCategory.text, forKey: "name")
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
