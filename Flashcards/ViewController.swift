//
//  ViewController.swift
//  Flashcards
//
//  Created by Dinaol Melak on 10/13/18.
//  Copyright © 2018 Dinaol Melak. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}


class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    
    
    
    @IBOutlet weak var firstBtnBGColor: CGColor!
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius=30.0
        answerLabel.layer.cornerRadius=30.0
        questionLabel.layer.cornerRadius=30.0
        card.layer.shadowRadius=15.0
        card.layer.shadowOpacity=0.2
        answerLabel.clipsToBounds=true
        questionLabel.clipsToBounds=true
        
        firstButton.layer.borderWidth=3.0
        firstButton.layer.cornerRadius=30.0
        firstButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        firstBtnBGColor=firstButton.layer.backgroundColor
        secondButton.layer.borderWidth=3.0
        secondButton.layer.cornerRadius=30.0
        secondButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        thirdButton.layer.borderWidth=3.0
        thirdButton.layer.cornerRadius=30.0
        thirdButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        readSavedFlashcards()
        
        if flashcards.count == 0{
            updateFlashcard(newQuestion: "What is the Capital City of Ethiopia🇪🇹?", newAnswer: "Addis Ababa", extraAns1: "Gondar", extraAns2: "Adama")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        if (segue.identifier=="EditSegue")
        {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
        }
        
        
        creationController.flashcardsController = self
        
    }
    
    func updateFlashcard(newQuestion: String,newAnswer: String, extraAns1: String,extraAns2: String){
        
        let flashcard = Flashcard(question: newQuestion, answer: newAnswer)
        
        
        flashcards.append(flashcard)
        
        print("🎊Able to Append Flashcard")
        print("🎊We have now \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("Our currentIndex is \(currentIndex)")
        
        updateNextPrevButtons()
        updateLabels()
        //questionLabel.text = flashcard.question
        //answerLabel.text = flashcard.answer
        
        firstButton.setTitle(extraAns1, for: .normal)
        secondButton.setTitle(newAnswer, for: .normal)
        thirdButton.setTitle(extraAns2, for: .normal)
        
        updateNextPrevButtons()
        
        
        
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1 {
            nextButton.isEnabled=false
        }
        else{
            nextButton.isEnabled=true
        }
        if currentIndex == 0 {
            prevButton.isEnabled=false
        }
        else{
            prevButton.isEnabled=true
        }
        
    }
    
    func updateLabels(){
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        //update labels
        questionLabel.text = currentFlashcard.question
        answerLabel.text=currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return["question": card.question, "answer": card.answer]
        }
        //UserDefaults.standard.set(flashcards, forKey: "savedFlashcards") //if used u get a crash b/c ur using an array n not dictionary
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Saved Flashcards to UserDefaults")
    }
    
    func readSavedFlashcards(){
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    @IBAction func didTapReset(_ sender: Any) {
        questionLabel.isHidden=false
        firstButton.layer.backgroundColor=firstBtnBGColor
        secondButton.layer.backgroundColor=firstBtnBGColor
        thirdButton.layer.backgroundColor=firstBtnBGColor
        firstButton.isHidden=false
        thirdButton.isHidden=false
    }
    
    @IBAction func didTapBtnOptionOne(_ sender: Any) {
        //firstButton.backgroundColor=#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        firstButton.isHidden=true
    }
    @IBAction func didTapBtnOptionTwo(_ sender: Any) {
        secondButton.backgroundColor=#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        questionLabel.isHidden=true
        
    }
    @IBAction func didTapBtnOptionThree(_ sender: Any) {
        //thirdButton.backgroundColor=#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        thirdButton.isHidden=true
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
}

