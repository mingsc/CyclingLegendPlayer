//
//  FirstViewController.swift
//  Audio Player
//
//  Created by Daniel Ro on 1/1/18.
//  Copyright © 2018 Daniel Ro. All rights reserved.
//

import UIKit
import AVFoundation

//global array containing songs
var songs: [String] = []
//global audio player
var audioPlayer = AVAudioPlayer()
//global var for keeping track of current song number
var thisSong = 0

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    //var myTableView: UITableView
    
    //this function tells the table view how many rows we need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    //this function tells the table view what we want to display in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }

    //this function registers when a user taps on a certain cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //play song associated with that name
        do {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            //audioPlayer.play()
            //SecondViewController.startTimer()
            //store which song user tapped on
            thisSong = indexPath.row
            //print(thisSong)
            if let songController =
                storyboard?.instantiateViewController(withIdentifier:
                    "song") {
                present(songController, animated: true, completion: nil)
            }
            
        
        } catch {
            print("Error")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gettingSongName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gettingSongName() {
        //getting the URL to our folder
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        //loop through the items in this folder
        do {
            //songPath is an array that contains all the URLs for the songs
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            //looping through array items
            for song in songPath {
                var mySong = song.absoluteString //we don't want it as a URL, we want it as a string so we can work with it
                print(mySong)
                //checking that mySong is an mp3 file
                if mySong.contains(".mp3") {
                    //formatting to only song name
                    let findString = mySong.components(separatedBy: "/") //get an array filled with components of URL separated by "/"
                    mySong = findString[findString.count-1] //get the last component of URL, which is the song name
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ") //more formatting
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "") //more formatting to just get song title
                    songs.append(mySong)
                }
            }
            myTableView.reloadData() //reload table view
        } catch {
            
        }
    }
}

