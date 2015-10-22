//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marco Antonio Copa@ on 18/10/15.
//  Copyright © 2015 mcopa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
     var audioPlayer: AVAudioPlayer?
       override func viewDidLoad() {
        super.viewDidLoad()
        let filePatUrl = NSURL.fileURLWithPath(
            NSBundle.mainBundle().pathForResource("movie_quote",
                ofType: "mp3")!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: filePatUrl);
            
        } catch {
            print("audioPlayer error")
        }
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySlowEffect(sender: UIButton) {
        audioPlayer?.play();
  
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
