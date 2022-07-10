//
//  ResultViewController.swift
//  Personal Quiz
//
//  Created by Sergei Volotka on 10.07.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getResult()
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func doneButtomPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
}

extension ResultViewController {
    private func getResult() {
        
        var selectedAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalCount = selectedAnimals[animal] {
                selectedAnimals.updateValue(animalCount + 1, forKey: animal)
            } else {
                selectedAnimals[animal] = 1
            }
        }
        
        let sortedSelectedAnimals = selectedAnimals.sorted { $0.value > $1.value }
        
        guard let mostPopularAnswer = sortedSelectedAnimals.first?.key else { return }
        
        updateUI(with: mostPopularAnswer)
    }
    
    private func updateUI(with animal: Animal?) {
        animalLabel.text = "Вы - \(animal?.rawValue ?? "🐷" )!"
        definitionLabel.text = animal?.definition ?? ""
    }
}
