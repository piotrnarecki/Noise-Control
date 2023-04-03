//
//  RecorderViewController.swift
//  Noise Control
//
//  Created by Piotr Narecki on 03/04/2023.
//

import UIKit

class RecorderViewController: UIViewController {

    
    @IBOutlet weak var recorderLabel: UILabel!
    
    
    @IBOutlet weak var valueLabel: UILabel!
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    @IBOutlet weak var goBackButton: UIButton!
    
    
    
    var isRecording: Bool = false
    
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        
        
        isRecording=false
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func recordButtonPressed(_ sender: UIButton) {
        
        
        if(!isRecording){
            
        isRecording=true
           recordSound()
            recordButton.tintColor=UIColor.red
            recordButton.setTitle("stop", for: .normal)
            
        }else{
            isRecording=false
            recordButton.tintColor=UIColor.blue
            recordButton.setTitle("record", for: .normal)
        }
        
        
        
        
    }
    
    
    @IBAction func goBackPressed(_ sender: UIButton) {
    }
    
    
    
    
    func recordSound(){
        
        
        
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
