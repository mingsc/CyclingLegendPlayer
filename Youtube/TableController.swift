//
//  tableController.swift
//  playerYoutube
//
//  Created by christophe milliere on 22/04/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//class TableController: UITableViewController {
    @IBOutlet weak var tableViewController: UITableView!
    
    var musics = [Music]()
    let identifierCell = "MusicCell"
    let idenfifierSegue = "toVideo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        //title = " Legend of Youtube"
        addMusic()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let music = musics[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell) as? MusicCell {
            cell.setupCell(music: music)
            return cell
        }
        
        return UITableViewCell()
    }
    

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let music = musics[indexPath.row]
        performSegue(withIdentifier: idenfifierSegue, sender: music)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == idenfifierSegue {
            if let newController = segue.destination as? VideoController {
                newController.music = sender as? Music
            }
        }
    }
    
    func addMusic () {
        musics = [Music]()
        
        let contador1 = Music(artist: "CycleTube", title: "Alberto Contador-Best moments", code: "U_OY38O0OUk")
         musics.append(contador1)
        let contador2 = Music(artist: "Tom Donnenwirth", title: "Contador The King", code: "TsCKRGBwPM0")
        musics.append(contador2)
        //y3UuzFLi8tA
        let contador21 = Music(artist: "S-ìon HDD", title: "Two Steps From Hell - Star Sky (The Hobbit)", code: "y3UuzFLi8tA")
        musics.append(contador21)
        let contador3 = Music(artist: "Official Cycling Videos", title: "Epic Climb Mortirolo 2015", code: "vkWOG6orh8Y")
        musics.append(contador3)
        
        let contador5 = Music(artist: "Nathan Guillaud", title: "Alberto Contador | The last chapter", code: "iTdbh2ffD8c")
        musics.append(contador5)
        
        let contador6 = Music(artist: "Best Cycling", title: "Alberto Contador - The Last Shot", code: "YdeEBel0Buk")
        musics.append(contador6)
        
        let contador7 = Music(artist: "crisz4zz", title: "Attack best of Giro D'italia 2015", code: "7ONg6I5iiiM")
        musics.append(contador7)
        
        let contador8 = Music(artist: "crisz4zz", title: "Attack best of Vuelta 2014", code: "nPj2sR5CInA")
        musics.append(contador8)
        
        /*
        let beau = Music(artist: "Orlesan Feat Stromae", title: "La pluie", code: "37StRy0LEbI")
        musics.append(beau)
        
        let defaite = Music(artist: "Orlesan", title: "Défaite de famille", code: "wRQEfN8PGYI")
        musics.append(defaite)
        
        let basique = Music(artist: "Orlesan", title: "Basique", code: "2bjk26RwjyU")
        musics.append(basique)
        
        let cool = Music(artist: "Orlesan feat Gringe", title: "Ils Sont Cools", code: "_DT-4-jJTZc")
        musics.append(cool)
        
        let precieux = Music(artist: "Soprano", title: "Mon précieux", code: "OVmfGb8XKSg")
        musics.append(precieux)
        
        let casa = Music(artist: "La Casa de Papel", title: "My Life Is Going On", code: "F1oHBcTdKL4&list=PLkLimRXN6NKyOOVAqgfHWns1ICNiGXgOd")
        musics.append(casa)
        */
        
        tableViewController.reloadData()
        
        
        
    }



}
