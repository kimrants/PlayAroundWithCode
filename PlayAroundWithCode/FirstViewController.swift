//
//  FirstViewController.swift
//  PlayAroundWithCode
//
//  Created by Kim Rants on 29/07/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import Foundation

// FirstViewController inherits from UIViewController class
class FirstViewController: UIViewController {

    // Create aray with colours
    let differentColours = [UIColor.black, UIColor.blue, UIColor.brown, UIColor.clear, UIColor.cyan, UIColor.darkGray]
    
    // Random colour generator
    func randomColour() -> UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(differentColours.count)))
        let randomColour = differentColours[randomIndex]
        return randomColour
    }
   
    // Change colour randomly when button pressed
    @IBAction func changeColour(_ sender: Any) {
        colourDisplayed.backgroundColor = randomColour()
    }
    
    // Display new colour
    @IBOutlet weak var colourDisplayed: UIView!
    
    
    // Go to next slide, segue only
    @IBAction func nextSlide(_ sender: Any) {
    }
    
    // Go to next slide, but programatically
    @IBAction func nextSlideWithCode(_ sender: Any) {
        // Create variable that has the class needed
        var nextController: StartRecordingViewController
        // programatically downcast as a diceviewController
        nextController = storyboard?.instantiateViewController(withIdentifier: "StartRecordingViewController") as! StartRecordingViewController
        // present; remember to change the ID in storyboard to "StartRecordingViewController"
        self.present(nextController, animated: true, completion: nil)
        
    }
    
    // Is loaded first; after this is "viewWillAppear"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

