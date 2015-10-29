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
    var audioPlayer: AVAudioPlayer!;
    var receivedAudio : RecordedAudio!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote",ofType: "mp3"){
//            let filePathUrl = NSURL.fileURLWithPath(filePath);
//            
//        }else{
//            print("audioPlayer error")
//        }
        audioPlayer =  try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySlowEffect(sender: UIButton) {
        playAudioAtRate(0.5);
  
       
    }

   
    @IBAction func playFastSound(sender: UIButton) {
        playAudioAtRate(1.5);
    }

    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop();
        audioPlayer.currentTime = 0.0;
    }
    
    func playAudioAtRate(rate: Float){
        audioPlayer.stop();
        audioPlayer.rate = rate;
        audioPlayer.currentTime = 0.0;
        audioPlayer.play();
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
