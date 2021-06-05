//Tipsy

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctBtn: UIButton!
    @IBOutlet weak var tenPctBtn: UIButton!
    @IBOutlet weak var twentyPctBtn: UIButton!
    @IBOutlet weak var splitNumLabel: UILabel!
    
    var billValue: Double?
    var tipPctselected: Double?
    var split: Int?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctBtn.isSelected = false
        tenPctBtn.isSelected = false
        twentyPctBtn.isSelected = false
        sender.isSelected = true
        billTextField.endEditing(true)
        
        let btnTitle = sender.currentTitle!
        let btnTitleMinusPercentSign =  String(btnTitle.dropLast())
        let btnTitleNumber = Double(btnTitleMinusPercentSign)!
        tipPctselected = btnTitleNumber / 100
    }
   
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumLabel.text = String(format: "%.0f", sender.value)
        split = Int(sender.value)
    }
   
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text
        if bill != "" {
            billValue = Double(bill!)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "총 금액(total bill)을 입력하세요", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }
            
            alert.addAction(okAction)
            
            present(alert, animated: false, completion: nil)
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.notice =  "Split between \(split!) people, with \(Int(tipPctselected! * 100))% tip."
            destinationVC.totalValue = String(format: "%.2f", (billValue! * (tipPctselected! + 1)) / Double(split!))
        }
    }
}
