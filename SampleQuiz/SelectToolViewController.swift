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
    
    var image: UIImage? {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(UIColor.black.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PremiereProButton.layer.borderWidth = 2
        PremiereProButton.layer.borderColor = UIColor.black.cgColor
        PremiereProButton.setBackgroundImage(image, for: .highlighted)
        
        AffterEffectsButton.layer.borderWidth = 2
        AffterEffectsButton.layer.borderColor = UIColor.black.cgColor
        AffterEffectsButton.setBackgroundImage(image, for: .highlighted)
        
        PhotoshopButton.layer.borderWidth = 2
        PhotoshopButton.layer.borderColor = UIColor.black.cgColor
        PhotoshopButton.setBackgroundImage(image, for: .highlighted)
        
        illustratorButton.layer.borderWidth = 2
        illustratorButton.layer.borderColor = UIColor.black.cgColor
        illustratorButton.setBackgroundImage(image, for: .highlighted)
    }
    //「selectLevel」を「selectTool」に変更
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectTool = selectTag
    }
    
    @IBAction func ToolButtonAction(sender: UIButton) {
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    
}
