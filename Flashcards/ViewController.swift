//
//  ViewController.swift
//  Flashcards
//
//  Created by Dinaol Melak on 10/13/18.
//  Copyright © 2018 Dinaol Melak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var question: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius=30.0
        answerLabel.layer.cornerRadius=30.0
        questionLabel.layer.cornerRadius=30.0
        card.layer.shadowRadius=15.0
        card.layer.shadowOpacity=0.2
        answerLabel.clipsToBounds=true
        questionLabel.clipsToBounds=true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapFlashcard(_ sender: Any) {
        if(questionLabel.isHidden==false)
        {
            questionLabel.isHidden=true
        }
        else
        {
            questionLabel.isHidden=false
        }
        
    }
    
    
    
}

