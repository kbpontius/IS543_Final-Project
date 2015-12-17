//
//  VideoViewController.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation

class VideoViewController: UIViewController {
//    var moviePlayer: AVPlayerViewController! // NOT USING ANYMORE
    var watchURL: String!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // playVideo()
        loadWebView()
    }
    
    // My first attempt at making this work.
    // I thought the URL was a video file URL.
    private func playVideo() {
        let videoURL = NSURL(string: watchURL)
        let player = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    private func loadWebView() {
        let url = NSURL(string: watchURL)!
        let urlRequest = NSURLRequest(URL: url)
        
        webView.loadRequest(urlRequest)
    }
}
