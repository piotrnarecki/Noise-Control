//
//  GeneratorViewController.swift
//  Noise Control
//
//  Created by Piotr Narecki on 03/04/2023.
//

import UIKit

class GeneratorViewController: UIViewController {

    
    
    @IBOutlet weak var generatorLabel: UILabel!
    
    
    @IBOutlet weak var frequencySlider: UISlider!
    
    
    @IBOutlet weak var generateButton: UIButton!
    
    
    @IBOutlet weak var goBackButton: UIButton!
    
    
    var frequencyValue: Float = 0.0
    var isGenerating: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isGenerating = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func frequencySliderChanged(_ sender: UISlider) {
        
        frequencyValue = sender.value
        generatorLabel.text=String(frequencyValue)
        
    }
    
    @IBAction func generatePressed(_ sender: UIButton) {
        
        if(!isGenerating){
            
            isGenerating=true
            generateSound()
            generateButton.tintColor=UIColor.red
            generateButton.setTitle("stop", for: .normal)
            
        }else{
            isGenerating=false
            generateButton.tintColor=UIColor.blue
            generateButton.setTitle("generate", for: .normal)
        }
        
    }
    
    func generateSound(){
        
        
        
    }

    
    
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        
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
