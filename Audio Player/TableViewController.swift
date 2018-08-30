//
//  TableViewController.swift
//  Legend Audio Player
//
//  Created by Ming hsien Chen on 2018/8/18.
//  Copyright © 2018年 Daniel Ro. All rights reserved.
//

import UIKit
import AVFoundation
var songs: [String] = []
//global audio player
var audioPlayer = AVAudioPlayer()
//global var for keeping track of current song number
var thisSong = 0

extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gettingSongName()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    //this function registers when a user taps on a certain cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //play song associated with that name
        do {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            //let audioPath = Bundle.main.path(forResource: songs[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.capitalizedLetters)!, ofType: ".mp3")
            //let mySongEncode = mySong.addingPercentEncoding(withAllowedCharacters: CharacterSet.capitalizedLetters)!
            
            //var URL = NSURL(string: audioPath.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            //audioPlayer.play()
            //SecondViewController.startTimer()
            //store which song user tapped on
            thisSong = indexPath.row
            //print(thisSong)
            //navigationController?.pushViewController(SecondViewController(), animated: true)
            //self.presentViewController(SecondViewController(), animated: true, completion: nil)
            //present(songController, animated: true, completion: nil)
            let songController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "song")
            self.navigationController?.pushViewController(songController, animated: true)
            
            /*
            if let songController =
                storyboard?.instantiateViewController(withIdentifier:
                    "song") {
                present(songController, animated: true, completion: nil)
            }
 */
            
            
        } catch {
            print("Error")
        }
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
                    
                    //print(mySong.urlDecoded())
                    //songs.append(mySong)
                    //将编码后的url转换回原始的url
                    //http://www.hangge.com/blog/cache/detail_1583.html
                    
                    songs.append(mySong.urlDecoded())
                }
            }
            //myTableView.reloadData() //reload table view
        } catch {
            
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

