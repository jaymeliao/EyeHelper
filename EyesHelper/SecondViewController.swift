//
//  SecondViewController.swift
//  EyesHelper
//
//  Created by Jayme Liao on 2022-04-13.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var result = " ";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text="Hello Linda and Joyce.";
        
        textView.font = UIFont.systemFont(ofSize: 30.0);

        // Do any additional setup after loading the view.
    }
    
    @IBAction func readAloudIsTapped(_ sender: UIButton) {
        
        let x = Speech()
        x.startSpeech(textView.text)
        
    }
    
    @IBAction func changeTextSize(_ sender: UISlider) {
        print(sender.value);
        textView.font = UIFont.systemFont(ofSize: CGFloat(sender.value));
        
        
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
