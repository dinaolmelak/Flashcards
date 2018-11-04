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
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        
        
        let answerText = answerTextField.text
        
        let alert = UIAlertController(title: "Missing Info", message: "Either the question or answer field is left blank!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK, I'll fix it", style: .default)
        alert.addAction(okAction)
        
        if(questionTextField.text==nil||answerTextField.text==nil||questionText!.isEmpty||answerText!.isEmpty)
        {
            present(alert, animated: true)
        }
        else{
            flashcardsController.updateFlashcard(newQuestion: questionText!, newAnswer: answerText!)
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
