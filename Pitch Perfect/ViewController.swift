//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Marco Antonio Copa@ on 21/9/15.
//  Copyright © 2015 mcopa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
       
        recordingInProgress.hidden = false;
        stopButton.hidden = false;
        recordButton.enabled = false;
        //TODO: Record the user's voice.
        print("in record audio");
    }

    @IBAction func stopRecordAudio(sender: UIButton) {
        recordingInProgress.hidden = true;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;
        recordButton.enabled = true;
    }
}

