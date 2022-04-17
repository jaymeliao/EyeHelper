//
//  ViewController.swift
//  EyesHelper
//
//  Created by Jayme Liao on 2022-04-09.
//

import UIKit
import Vision
import VisionKit
class FirstViewController: UIViewController, VNDocumentCameraViewControllerDelegate{

    let textRecognizationQueue = DispatchQueue.init(label: "TextRecognizationQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem, target: nil)
    var request = [VNRequest]()
    
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVision()
        // Do any additional setup after loading the view.
    }

    @IBAction func scanButtonIsPressed(_ sender: UIButton) {
        let dCC = VNDocumentCameraViewController()
        dCC.delegate=self
        self.present(dCC, animated: true, completion: nil)
    }
    
    func setUpVision(){
        let textRecognizationRequest = VNRecognizeTextRequest{
            (request,Error) in
            guard let observationsResults = request.results as? [VNRecognizedTextObservation] else {
                print("NO Result")
                return
            }
            let maximunCandidates = 1
            var resultInText=""
            for observation in observationsResults {
                let candidate = observation.topCandidates(maximunCandidates).first
                resultInText += candidate?.string ?? " "+"\n"
                
            }
            
            self.textView.text=resultInText
            print(resultInText)
        }
        textRecognizationRequest.recognitionLevel = .accurate
        self.request = [textRecognizationRequest]
    }
    
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
        controller.dismiss(animated: true, completion: nil)
        for i in 0..<scan.pageCount{
            let scannedImage = scan.imageOfPage(at: i)
                if let cgImage = scannedImage.cgImage {
                    let requestHandler = VNImageRequestHandler.init(cgImage:cgImage, options: [:])
                    do {
                        try requestHandler.perform(self.request)
                            
                    }catch{
                        print(error.localizedDescription)
                    }
                }
        }
    }

        
    @IBAction func nextButtonIsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecond", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToSecond" {
                let destinationVC = segue.destination as! SecondViewController
                destinationVC.result=textView.text;
            }
      
    }
    
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController){
        controller.dismiss(animated: true, completion: nil)
    }
    


}

