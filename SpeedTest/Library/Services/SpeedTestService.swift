//
//  SpeedTestManager.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-14.
//

import Foundation


class SpeedTestService: NSObject {
    
    /// make a structure
    typealias SpeedTestResult = (downloadSpeed: Double, uploadSpeed: Double, isCompleteResult: Bool)
    
    
    // MARK: - Private Properties
    
    private var downloadTestStartDate: Date?
    private var uploadTestStartDate: Date?
    
    
    // MARK: - Public Methods
    
    func measureInternetSpeed(_ completion: @escaping (Result<SpeedTestResult, Error>) -> Void) {
        guard let testImageURL = URL(string: "https://www.polymtl.ca/calendrier/sites/calendrier.amigow2020.polymtl.ca/files/googlelogo.jpg") else {
            return
        }
        
        let request = URLRequest(url: testImageURL)
        
        downloadTestStartDate = Date()
//        startTime = CFAbsoluteTimeGetCurrent()
//        stopTime = startTime
//        bytesReceived = 0
//        speedTestCompletionHandler = completionHandler
        
        let configuration = URLSessionConfiguration.ephemeral
        /// Default is 7 days?????
        configuration.timeoutIntervalForResource = 10
        URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
            .dataTask(with: testImageURL)
            .resume()
    }
}


// MARK: - URLSessionDataDelegate

extension SpeedTestService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        bytesReceived! += data.length
        //            stopTime = CFAbsoluteTimeGetCurrent()
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        let elapsed = stopTime - startTime
//        guard elapsed != 0 && (error == nil || (error?.domain == NSURLErrorDomain && error?.code == NSURLErrorTimedOut)) else {
//            speedTestCompletionHandler(megabytesPerSecond: nil, error: error)
//            return
//        }
//
//        let speed = elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1
//        speedTestCompletionHandler(megabytesPerSecond: speed, error: nil)
    }
}
