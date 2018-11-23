//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Dinaol Melak on 10/18/18.
//  Copyright © 2018 Dinaol Melak. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    var initialQuestion: String?
    var initialAnswer: String?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAnswer1: UITextField!
    @IBOutlet weak var extraAnswer2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let newExtraAns1 = extraAnswer1.text
        let newExtraAns2 = extraAnswer2.text
        
        let alert = UIAlertController(title: "Missing Info", message: "Either the question or answer field is left blank!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK, I'll fix it", style: .default)
        alert.addAction(okAction)
        
        if(questionTextField.text==nil||answerTextField.text==nil||questionText!.isEmpty||answerText!.isEmpty)
        {
            present(alert, animated: true)
        }
        else{
            var isExisting = false
            if initialQuestion != nil{
                isExisting = true
            }
        flashcardsController.updateFlashcard(newQuestion: questionText!, newAnswer: answerText!, isExisting: isExisting, extraAns1: newExtraAns1!,extraAns2: newExtraAns2!)
            dismiss(animated: true)
        }
        
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
