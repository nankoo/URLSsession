//
//  ViewController.h
//  NsurlsessionTry
//
//  Created by kazuhiro on 2014/02/14.
//  Copyright (c) 2014年 kazuhiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<NSURLSessionDataDelegate, NSURLSessionTaskDelegate>
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
//- (IBAction)begin:(id)sender;
- (IBAction)myTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *myText;


// ---------------------------------------------------------------------
//  NSURLSessionDataDelegate
// ---------------------------------------------------------------------

/*
 The NSURLSessionDataDelegate protocol defines the methods that a delegate of an NSURLSession object can implement to handle task-level events specific to data tasks. The object should also implement the methods in the NSURLSessionTaskDelegate protocol—to handle task-level events that are common to all task types—and methods in the NSURLSessionDelegate protocol—to handle session-level events.
 
 Note: An NSURLSession object need not have a delegate. If no delegate is assigned, a system-provided delegate is used.
 */

// URLSession:dataTask:didReceiveResponse:completionHandler:
//  Tells the delegate that the data task received the initial reply (headers) from the server.
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler;

// URLSession:dataTask:didBecomeDownloadTask:
// Tells the delegate that the data task was changed to a download task.
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask;

// URLSession:dataTask:didReceiveData:
// Tells the delegate that the data task finished receiving all of the expected data.
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data;

// URLSession:dataTask:willCacheResponse:completionHandler:
// Asks the delegate whether the data task should store the response in the cache.
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler;


// ---------------------------------------------------------------------
//  NSURLSessionTaskDelegate
// ---------------------------------------------------------------------

/*
 The NSURLSessionTaskDelegate protocol defines the methods that a delegate of an NSURLSession object should implement to handle task-level events that are common to all task types.
 
 Delegates of sessions with download tasks should also implement the methods in the NSURLSessionDownloadDelegate protocol to handle task-level events specific to download tasks.
 
 Delegates of sessions with data tasks should also implement the methods in the NSURLSessionDataDelegate protocol to handle task-level events specific to download tasks.
 
 Note: An NSURLSession object need not have a delegate. If no delegate is assigned, a system-provided delegate is used.
 */

// URLSession:task:didCompleteWithError:
// Tells the delegate that the task finished transferring data.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;

// URLSession:task:didReceiveChallenge:completionHandler:
// Requests credentials from the delegate in response to an authentication request from the remote server.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler;

// URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:
// Periodically informs the delegate of the progress of sending body content to the server.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend;

// URLSession:task:needNewBodyStream:
// Tells the delegate when a task requires a new request body stream to send to the remote server.
// Note: You do not need to implement this if your code provides the request body using a file URL or an NSData object.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler;

// URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:
// Tells the delegate that the remote server requested an HTTP redirect.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler;

@end
