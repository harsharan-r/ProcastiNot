//
//  PlanTabViewController.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-26.
//

import UIKit
import FirebaseAuth
import AVKit

class RelaxTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var blueBackground: UIImageView!

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    struct Video {
        let title: String!
        let thumbnail: String!
        let url: String
    }
    
    var videos: [Video ] = [
        Video(title: "10-Minute Meditation For Stress", thumbnail: "10-Minute Meditation For Stress", url: "https://youtu.be/z6X5oEIg6Ak"),
        Video(title: "5-Minute De-Stress Meditation", thumbnail: "5-Minute De-Stress Meditation", url: "https://youtu.be/9yj8mBfHlMk"),
        Video(title: "Mental Reset in 5 Minutes - Guided Meditation", thumbnail: "Mental Reset in 5 Minutes - Guided Meditation", url: "https://youtu.be/O39OqqYGycs"),
        Video(title: "Quick Stress Release: Anixety Release Techinique", thumbnail: "Quick Stress Release: Anixety Release Techinique", url: "https://youtu.be/lrhPTqholcc"),
        Video(title: "20 Minute Full Body Stress and Anxiety Relief Yoga", thumbnail: "20 Minute Full Body Stress and Anxiety Relief Yoga", url: "https://youtu.be/sTANio_2E0Q"),
        Video(title: "5-Meditation You Can Do Anywhere", thumbnail: "5-Meditation You Can Do Anywhere", url: "https://youtu.be/inpok4MKVLM"),
        Video(title: "Streches For Stress Relief", thumbnail: "Streches For Stress Relief", url: "https://youtu.be/6ijg6tpyxXg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blueBackground.layer.cornerRadius = 49
        greeting.text = "Hi \(Auth.auth().currentUser?.displayName ?? "No Username")"
        greeting.sizeToFit()
        
        self.getthumbnailFromImage(url: URL(string:  "https://www.youtube.com/watch?v=nQ7XbH19MkU")!) { thumbImage in
            self.videoImage.image = thumbImage

        }
    }
    
    func getthumbnailFromImage(url: URL, completion: @escaping ((_ image: UIImage)-> Void)){
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbnailTime = CMTimeMake(value: 7, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    

    @IBAction func Logout(_ sender: Any) {
        do{
            
        try Auth.auth().signOut()
            
        }catch{
            print("Error")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
        
        let video = videos[indexPath.row]
        
        tableViewCell.title.text = video.title
        tableViewCell.thumbnail.image = UIImage(named: video.thumbnail)
        
        return tableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoLink = videos[indexPath.row]
        if let url = URL(string: videoLink.url) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func PlayButtonForTedTalk(_ sender: Any) {
        if let url = URL(string: "https://youtu.be/arj7oStGLkU") {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
   
    }
    
    @IBAction func PlayButtonForSteps(_ sender: Any) {
        if let url = URL(string: "https://youtu.be/irp5ghCVNAM") {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
