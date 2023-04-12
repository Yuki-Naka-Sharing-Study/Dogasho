//
//  SelectLevelViewController.swift
//  SampleQuiz
//
//  Created by 仲優樹 on 2023/04/09.
//

import UIKit

class SelectToolViewController: UIViewController {
    
    @IBOutlet weak var PremiereProButton: UIButton!
    @IBOutlet weak var AffterEffectsButton: UIButton!
    @IBOutlet weak var PhotoshopButton: UIButton!
    @IBOutlet weak var illustratorButton: UIButton!
    
    var selectTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PremiereProButton.layer.borderWidth = 2
        PremiereProButton.layer.borderColor = UIColor.black.cgColor
        
        AffterEffectsButton.layer.borderWidth = 2
        AffterEffectsButton.layer.borderColor = UIColor.black.cgColor
        
        PhotoshopButton.layer.borderWidth = 2
        PhotoshopButton.layer.borderColor = UIColor.black.cgColor
        
        illustratorButton.layer.borderWidth = 2
        illustratorButton.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLevel = selectTag
    }
    
    @IBAction func ToolButtonAction(sender: UIButton) {
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
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
