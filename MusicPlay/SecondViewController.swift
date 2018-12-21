//
//  SecondViewController.swift
//  MusicPlay
//

import UIKit
import AVFoundation

//Variables
var timer:Timer!


class SecondViewController: UIViewController {
    
    //Outlets and Actions
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var playedTime: UILabel!
    
   @IBAction func onShareTapped(_ sender: Any) {
        
       let text = "Check out this song"
       let imageName = UIImage(named: "Skjermbilde 2017-01-30 kl. 16.14.11.png")
       let songName = Bundle.main.path(forResource: songs[thisSong], ofType: ".mp3")
       
        
       let activityViewController = UIActivityViewController(activityItems: [text, imageName as Any ,[songName as Any]], applicationActivities: nil)
                
        present(activityViewController, animated: true, completion: nil)
        
    }
        
    @IBAction func play(_ sender: Any)
    {        if audioStuffed == true && audioPlayer.isPlaying == false
        {
            audioPlayer.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pause(_ sender: Any)
    {
        if audioStuffed == true && audioPlayer.isPlaying
        {
            audioPlayer.pause()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func prev(_ sender: Any)
    {
        if thisSong != 0 && audioStuffed == true
        {
            playThis(thisOne: songs[thisSong-1])
            thisSong -= 1
            label.text = songs[thisSong]
        }
        else
        {
            
        }
    }
    
    @IBAction func next(_ sender: Any)
    {
        if thisSong < songs.count-1 && audioStuffed == true
        {
            playThis(thisOne: songs[thisSong+1])
            thisSong += 1
            label.text = songs[thisSong]
        }
        else
        {
            
        }
    }
    
    @IBAction func slider(_ sender: UISlider)
    {
        if audioStuffed == true
        {
            audioPlayer.volume = sender.value
        }
    }
    
    func playThis(thisOne:String)
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        }
        catch
        {
            print ("ERROR")
        }
    }
    
    @objc func updateTime() {
        
        let currentTime = Int(audioPlayer.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        
        playedTime.text = String(format: "%02d:%02d", minutes,seconds) as String
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        label.text = songs[thisSong]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

