//
//  IncomeAndExpenseViewController.swift
//  Financial Individual
//
//  Created by Bao Vu on 3/29/20.
//  Copyright © 2020 Bao Vu. All rights reserved.
//

import UIKit
import CoreData

class IncomeAndExpenseViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet weak var IncomeCollectionView: UICollectionView!
    
    @IBOutlet weak var ExpenseCollectionView: UICollectionView!
    
    var arrayIncomeImage = [UIImage]()
    var arrayIncomeAmount = [String]()
    var arrayIncomeName = [String]()
    
    var arrayExpenseImage = [UIImage]()
    var arrayExpenseAmount = [String]()
    var arrayExpenseName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Transaction"
        IncomeCollectionView.delegate = self
        IncomeCollectionView.dataSource = self
        ExpenseCollectionView.delegate = self
        ExpenseCollectionView.dataSource = self
        fetchIncome()
        fetchExpense()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == ExpenseCollectionView){
            return arrayExpenseName.count
        }
        return arrayIncomeName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cellIncome = IncomeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellIncomeCollectionViewCell
            cellIncome.imgIncomeCategory.image = arrayIncomeImage[indexPath.row]
            cellIncome.lblDate.text = "\(day)/\(month)/\(year)"
            cellIncome.lblAmountIncome.text = arrayIncomeAmount[indexPath.row]
            cellIncome.lblIncomeNameCategory.text = arrayIncomeName[indexPath.row]
            
        if (collectionView == ExpenseCollectionView) {
            let cellExpense = ExpenseCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! CellExpenseCollectionViewCell
            cellExpense.imgExpenseCategory.image = arrayExpenseImage[indexPath.row]
            cellExpense.lblDate.text = "\(day)/\(month)/\(year)"
            cellExpense.lblExpenseName.text = arrayExpenseName[indexPath.row]
            cellExpense.lblExpenseAmount.text = arrayExpenseAmount[indexPath.row]
            return cellExpense
        }
       return cellIncome
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 40, height: 70)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btn_AddIncome(_ sender: Any) {
        let screen = storyboard?.instantiateViewController(withIdentifier: "ITVC") as! IncomeTransactionViewController
        navigationController?.pushViewController(screen, animated: true)
    }
    //This function is to fetch Income data from coredata
    func fetchIncome(){
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: "Income")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject]{
                arrayIncomeAmount.append(result.value(forKey: "amount") as! String)
                let data = result.value(forKey: "image")
                arrayIncomeImage.append(UIImage(data: data as! Data)!)
                arrayIncomeName.append(result.value(forKey: "name") as! String)
            }
        }catch{
            print("error")
        }
    }
    //This function is to fetch Expense data from coredata
    func fetchExpense(){
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject]{
                arrayExpenseAmount.append(result.value(forKey: "amount") as! String)
                let data = result.value(forKey: "image")
                arrayExpenseImage.append(UIImage(data: data as! Data)!)
                arrayExpenseName.append(result.value(forKey: "name") as! String)
            }
        }catch{
            print("error")
        }
    }
}
