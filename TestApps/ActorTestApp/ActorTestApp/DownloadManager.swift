//
//  DownloadManager.swift
//  ActorTestApp
//
//  Created by Shitesh Patel on 12/07/23.
//

import Foundation

class DownloadManager: NSObject {
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.downloadmanager")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    
}

extension DownloadManager: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // here do something after download finished
        print("Download finished for url: \(location.absoluteString)")
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                            totalBytesExpectedToWrite: Int64) {
        // Here show the progress of download file
        print("bytesWritten: \(bytesWritten)    totalBytesWritten: \(totalBytesWritten)  totalBytesExpectedToWrite: \(totalBytesExpectedToWrite)")
    }
}
