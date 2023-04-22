//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by 仲優樹 on 2023/04/06.
//

import UIKit
//import GoogleMobileAds

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var judgeLabel: UILabel!
    
//    var bannerView: GADBannerView! 「selectLevel」を「selectTool」に変更
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectTool = 0
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
        
//        bannerView = GADBannerView(adSize: GADAdSizeBanner)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//        addBannerViewToView(bannerView)
        
        //「selectLevel」を「selectTool」に変更。
        print("選択したツールは\(selectTool)")
#if DougaQuiz
        csvArray = loadCSV(fileName: "DougaQuiz\(selectTool)")
#elseif DesignQuiz
        csvArray = loadCSV(fileName: "DesignQuiz\(selectTool)")
#elseif SmaphoQuiz
        csvArray = loadCSV(fileName: "SmaphoQuiz\(selectTool)")
#else
        csvArray = loadCSV(fileName: "WebQuiz\(selectTool)")
#endif
        csvArray.shuffle()
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        let quizText = quizArray[0].replacingOccurrences(of: "[改行]", with: "\n")
        quizTextView.text = quizText
        
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton1.setBackgroundImage(image, for: .highlighted)
        
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton2.setBackgroundImage(image, for: .highlighted)
        
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton3.setBackgroundImage(image, for: .highlighted)
        
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        answerButton4.setBackgroundImage(image, for: .highlighted)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    //ボタンを押したときに呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
            judgeLabel.text = ""
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
//            judgeLabel.text = "正解は\(quizArray[1])"
            let answerNumber = Int(quizArray[1])!
            let answerText = quizArray[answerNumber + 1]
            judgeLabel.text = "正解は\(answerText)"
        }
        
        print("スコア：\(correctCount)")
        
        judgeImageView.isHidden = false
        judgeLabel.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.judgeImageView.isHidden = true
            self.judgeLabel.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
        }
        
    }
    
    func nextQuiz() {
        quizCount += 1
        
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            let quizText = quizArray[0].replacingOccurrences(of: "[改行]", with: "\n")
            quizTextView.text = quizText
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
        
    }
    //「loadCSV」はいじってはいけない。
    func loadCSV(fileName: String) -> [String] {
        
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        
        return csvArray
    }
    
}
