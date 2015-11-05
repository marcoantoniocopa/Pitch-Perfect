//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marco Antonio Copa@ on 21/9/15.
//  Copyright © 2015 mcopa. All rights reserved.
//

import UIKit
import AVFoundation;

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // Global variables
    var audioRecorder: AVAudioRecorder!;
    var recordedAudio: RecordedAudio!
    
    // Referencing outlets
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

    
    /** Function linked to recordButton, and used to record audio */
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.text = "Recording"
        stopButton.hidden = false
        recordButton.enabled = false
        
        //getting the path to the document directory within our App
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // prepare the path where the audio will saved
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        // Setup audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // Initialize and prepare the recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        

    }

    /** Save the file path and title of the record when the record is finished */
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            // save the recorded audio info
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            // move to the next scene aka perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    
    /** Perform the transitions to next views */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    
    /** Stop recording  */
    @IBAction func stopRecordAudio(sender: UIButton) {
        recordingInProgress.text = "Tap to Record"
        // Stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        recordingInProgress.text = "Tap to Record"
        stopButton.hidden = true
        recordButton.enabled = true
    }
}

