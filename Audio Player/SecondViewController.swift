//
//  SecondViewController.swift
//  Audio Player
//
//  Created by Daniel Ro on 1/1/18.
//  Copyright © 2018 Daniel Ro. All rights reserved.
//

import UIKit
import AVFoundation
var photos: [String] = []
//var pictures = [String]()
var pictures: [String] = []

extension UIImage {
    
    func resize(width: CGFloat) -> UIImage {
        let height = (width/self.size.width)*self.size.height
        return self.resize(size: CGSize(width: width, height: height))
    }
    
    func resize(height: CGFloat) -> UIImage {
        let width = (height/self.size.height)*self.size.width
        return self.resize(size: CGSize(width: width, height: height))
    }
    
    func resize(size: CGSize) -> UIImage {
        let widthRatio  = size.width/self.size.width
        let heightRatio = size.height/self.size.height
        var updateSize = size
        if(widthRatio > heightRatio) {
            updateSize = CGSize(width:self.size.width*heightRatio, height:self.size.height*heightRatio)
        } else if heightRatio > widthRatio {
            updateSize = CGSize(width:self.size.width*widthRatio,  height:self.size.height*widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(updateSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: updateSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}



class SecondViewController: UIViewController {

    @IBOutlet weak var totalLengthOfAudioLabel: UILabel!
    @IBOutlet weak var progressTimerLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    var timer:Timer!
    
    

    @IBOutlet weak var playerProgressSlider: UISlider!
    @IBOutlet weak var myImageView: UIImageView!
    var isPaused: Bool!
    var isPlaying: Bool!
    var pictureNo: Int!
    
    var audioLength = 0.0
    //var toggle = true
    //var effectToggle = true
    var totalLengthOfAudio = ""
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
        
    }
    
    
    func prepareAudio(){
        //setCurrentAudioPath()
        /*
        do {
            //keep alive audio at background
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
        */
        //audioPlayer = try? AVAudioPlayer(contentsOf: currentAudioPath)
        //audioPlayer.delegate = self
        audioLength = audioPlayer.duration
        playerProgressSlider.maximumValue = CFloat(audioPlayer.duration)
        playerProgressSlider.minimumValue = 0.0
        playerProgressSlider.value = 0.0
        audioPlayer.prepareToPlay()
        showTotalSongLength()
        UserDefaults.standard.set(playerProgressSlider.value , forKey: "playerProgressSliderValue")
        //updateLabels()
        //progressTimerLabel.text = "00:00"
        label.text = songs[thisSong]
        
        
    }
    
    @IBAction func changeAudioLocationSlider(_ sender: UISlider) {
        audioPlayer.currentTime = TimeInterval(sender.value)
    }
    @IBAction func play(_ sender: UIButton) {
        //if audioPlayer.isPlaying == false {
        if !isPlaying {
            //prepareAudio()
            /*
            retrievePlayerProgressSliderValue()
            audioPlayer.play()
            startTimer()
             */
            
            playThis(thisOne: songs[thisSong])
            
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        //if audioPlayer.isPlaying == true {
        if  isPlaying {
            audioPlayer.pause()
            stopTimer()
            isPlaying = false
            
        }
    }
    
    
    @IBAction func shuffle(_ sender: UIButton) {
        thisSong = Int(arc4random_uniform(UInt32(songs.count)))
        playThis(thisOne: songs[thisSong])
        // load song name
        label.text = songs[thisSong]
    }
    
    @IBAction func prev(_ sender: UIButton) {
        if thisSong>0 {
            thisSong -= 1 //decrement song count
            prepareAudio()
            playThis(thisOne: songs[thisSong])
        }
        else {
            thisSong = songs.count-1 //loop around
            prepareAudio()
            playThis(thisOne: songs[thisSong])
        }
        // load song name
        label.text = songs[thisSong]
    }
    
    @IBAction func next(_ sender: UIButton) {
        if thisSong<songs.count-1 {
            thisSong += 1 //increment song count
            prepareAudio()
            playThis(thisOne: songs[thisSong])
        }
        else {
            thisSong = 0 //loop around
            prepareAudio()
            playThis(thisOne: songs[thisSong])
        }
        // load song name
        label.text = songs[thisSong]
    }
    
  
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        let seconds : Int64 = Int64(sender.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        /*
        avPlayer!.seek(to: targetTime)
        if(isPaused == false){
            seekLoadingLabel.alpha = 1
        }*/
        
        
    }
    /*
    @IBAction func sliderTapped(_ sender: UILongPressGestureRecognizer) {
        if let slider = sender.view as? UISlider {
            if slider.isHighlighted { return }
            let point = sender.location(in: slider)
            let percentage = Float(point.x / slider.bounds.width)
            let delta = percentage * (slider.maximumValue - slider.minimumValue)
            let value = slider.minimumValue + delta
            slider.setValue(value, animated: false)
            let seconds : Int64 = Int64(value)
            let targetTime:CMTime = CMTimeMake(seconds, 1)
            
            //avPlayer!.seek(to: targetTime)
            //if(isPaused == false){
            //    seekLoadingLabel.alpha = 1
            //}
        }
    }
    */
    
    @IBAction func ProgressChangeAct(_ sender: UISlider) {
        
        audioPlayer.currentTime = TimeInterval(sender.value)
    }
    
    
    
    @IBAction func slider(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    //function for playing song associated with song name
    func playThis(thisOne: String) {
        //play song associated with that name
        do {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            //showTotalSongLength()
            //prepareAudio()
            retrievePlayerProgressSliderValue()
            audioPlayer.play()
            isPlaying = true
            startTimer()
            
        } catch {
            print("Error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPictureName()
        //print(pictures.count)
        
        pictureNo = Int.random(in: 0 ..< pictures.count)
        /*
        // load song name
        print(thisSong)
        print(songs[thisSong])
        label.text = songs[thisSong]
        print(thisSong)
        */
        //showTotalSongLength()
        //retrievePlayerProgressSliderValue()
        prepareAudio()
        //retrievePlayerProgressSliderValue()
        playThis(thisOne: songs[thisSong])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func startTimer(){
        //if timer == nil {
            //timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: //#selector(SecondViewController.update(_:)), userInfo: nil,repeats: true)
        if (isPlaying) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        }
            //timer.fire()
        //}
    }
    
    func stopTimer(){
        if isPlaying {
            timer.invalidate()
            
        }
        
        
    }
    
    
    //@objc func update(_ timer: Timer){
    @objc func UpdateTimer() {
        //if !audioPlayer.isPlaying{
        //    return
        //}
        var  a:Int!
        
        if isPlaying {
            let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
            progressTimerLabel.text  = "\(time.minute):\(time.second)"
        //print(progressTimerLabel)
            playerProgressSlider.value = CFloat(audioPlayer.currentTime)
            //print(playerProgressSlider.value)
            UserDefaults.standard.set(playerProgressSlider.value , forKey: "playerProgressSliderValue")
            
            //print(playerProgressSlider.value)
             a = Int(time.second)
            
            if (a! % 5 == 0) {
                //let h: Int32 = 243
                //let maxH = CGFloat(h)
                myImageView.image = UIImage(named: pictures[pictureNo])
                //myImageView.image = UIImage(named: pictures[pictureNo])?.resize(height: maxH)
                
                if (pictureNo < (pictures.count - 1)) {
                    pictureNo = pictureNo + 1
                }
                else {
                    pictureNo = 0
                }
            }
        }
        
        
        
    }
    
    func retrievePlayerProgressSliderValue(){
        let playerProgressSliderValue =  UserDefaults.standard.float(forKey: "playerProgressSliderValue")
        //let playerProgressSliderValue = Float(0.00)
        if playerProgressSliderValue != 0 {
            playerProgressSlider.value  = playerProgressSliderValue
            audioPlayer.currentTime = TimeInterval(playerProgressSliderValue)
            
            let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
            progressTimerLabel.text  = "\(time.minute):\(time.second)"
            playerProgressSlider.value = CFloat(audioPlayer.currentTime)
            
        }else{
            playerProgressSlider.value = 0.0
            audioPlayer.currentTime = 0.0
            progressTimerLabel.text = "00:00:00"
        }
    }
    
    
    
    //This returns song length
    func calculateTimeFromNSTimeInterval(_ duration:TimeInterval) ->(minute:String, second:String){
        // let hour_   = abs(Int(duration)/3600)
        let minute_ = abs(Int((duration/60).truncatingRemainder(dividingBy: 60)))
        let second_ = abs(Int(duration.truncatingRemainder(dividingBy: 60)))
        
        // var hour = hour_ > 9 ? "\(hour_)" : "0\(hour_)"
        let minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        let second = second_ > 9 ? "\(second_)" : "0\(second_)"
        return (minute,second)
    }
    
    
    
    func showTotalSongLength(){
        calculateSongLength()
        totalLengthOfAudioLabel.text = totalLengthOfAudio
    }
    
    
    func calculateSongLength(){
        audioLength = audioPlayer.duration
        let time = calculateTimeFromNSTimeInterval(audioLength)
        totalLengthOfAudio = "\(time.minute):\(time.second)"
    }

    func getPictureName() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
     
        
        for item in items {
            //if item.hasPrefix("nssl") {
            print(item)
            if item.contains(".jpg") {
                //this is a picture to load!
                pictures.append(item)
                
            }
        }
        
        //print(pictures)
    }
    
    
}

