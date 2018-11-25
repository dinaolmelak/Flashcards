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
    var multipleChoice1: String
    var multipleChoice2: String
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
            updateFlashcard(newQuestion: "What is the Capital City of Ethiopia🇪🇹?", newAnswer: "Addis Ababa", isExisting: false, extraAns1: "Gondar", extraAns2: "Adama")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateCard()
        animateFirstButton()
        animateSecondButton()
        animateThirdButton()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        if (segue.identifier=="EditSegue")
        {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
            creationController.initialChoice1 = firstButton.titleLabel?.text
            creationController.initialChoice2 = thirdButton.titleLabel?.text
        }
        
        
        creationController.flashcardsController = self
        
    }
    
    func updateFlashcard(newQuestion: String,newAnswer: String,isExisting: Bool, extraAns1: String,extraAns2: String){
        
        let flashcard = Flashcard(question: newQuestion, answer: newAnswer, multipleChoice1: extraAns1, multipleChoice2: extraAns2)
        
        if isExisting{
            flashcards[currentIndex]=flashcard
        }
        else{
        flashcards.append(flashcard)
        
        print("🎊Able to Append Flashcard")
        print("🎊We have now \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("Our currentIndex is \(currentIndex)")
        
        updateNextPrevButtons()
        }
        updateLabels()
        
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
        firstButton.setTitle(currentFlashcard.multipleChoice1, for: .normal)
        secondButton.setTitle(currentFlashcard.answer, for: .normal)
        thirdButton.setTitle(currentFlashcard.multipleChoice2, for: .normal)
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return["question": card.question, "answer": card.answer,"extraAnswer1": card.multipleChoice1,"extraAnswer2": card.multipleChoice2]
        }
        //UserDefaults.standard.set(flashcards, forKey: "savedFlashcards") //if used u get a crash b/c ur using an array n not dictionary
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Saved Flashcards to UserDefaults")
    }
    
    func readSavedFlashcards(){
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, multipleChoice1: dictionary["extraAnswer1"]!, multipleChoice2: dictionary["extraAnswer2"]!)
                
            }
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    @IBAction func didTapReset(_ sender: Any) {
        if questionLabel.isHidden==true{
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.questionLabel.isHidden=false
            })
        }
        else{
            //begin animation
            UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
            })
            //end animation
            UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.card.alpha = 1.0
                self.card.transform = CGAffineTransform.identity
            })
        }
        //questionLabel.isHidden=false
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
        flipFlashcard()
        
    }
    @IBAction func didTapBtnOptionThree(_ sender: Any) {
        //thirdButton.backgroundColor=#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        thirdButton.isHidden=true
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        animateCardOutToLeft()
        currentIndex = currentIndex + 1
        
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        animateCardOutToRight()
        currentIndex = currentIndex - 1
        
        
        updateNextPrevButtons()
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard?", message: "Are You Sure You Want To Delete This?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){action in self.deleteCurrentFlashcard()}
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        if currentIndex>flashcards.count-1{
            currentIndex=flashcards.count-1
        }
        updateLabels()
        updateNextPrevButtons()
        saveAllFlashcardsToDisk()
        
    }
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.questionLabel.isHidden=true
        })
        
    }
    func animateCardOutToLeft(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardInFromRight()
            
        })
    }
    func animateCardInFromRight(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {self.card.transform = CGAffineTransform.identity}
    }
    func animateCardInFromLeft(){
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {self.card.transform = CGAffineTransform.identity}
    }
    func animateCardOutToRight(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)}, completion: {finished in
            
            self.updateLabels()
            
            self.animateCardInFromLeft()
            
        })
    }
    
    func animateCard(){
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    
    func animateFirstButton(){
        firstButton.alpha = 0.0
        firstButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        //Here Comes the animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.firstButton.alpha = 1.0
            self.firstButton.transform = CGAffineTransform.identity
        })
    }
    func animateSecondButton(){
        secondButton.alpha = 0.0
        secondButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        //Here Comes the animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.secondButton.alpha = 1.0
            self.secondButton.transform = CGAffineTransform.identity
        })
    }
    func animateThirdButton(){
        thirdButton.alpha = 0.0
        thirdButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        //Here Comes the animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.thirdButton.alpha = 1.0
            self.thirdButton.transform = CGAffineTransform.identity
        })
    }
    
    
    
    
    
    
}

