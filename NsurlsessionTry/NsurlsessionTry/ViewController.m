//
//  ViewController.m
//  NsurlsessionTry
//
//  Created by kazuhiro on 2014/02/14.
//  Copyright (c) 2014年 kazuhiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //_myText.text = @"aaaaaaaaa";
    
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)myTap:(id)sender
{
    NSLog(@"番号1");
    // 1. セッションコンフィグレーションを作成します．
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 2. コンフィグレーションオブジェクトと self デリゲートを指定してセッションを作成します．
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    // 3. 任意の接続先を設定します．
    NSString *urlString = @"http://www.kent-web.com/pwd/pwmgr/secret/"
;
    //NSString *urlString = @"http://mediaprobe.co.jp/blog/clips/2014/01/09/ios-7-2/";

    //繋げなかったのってw得bページのほうの問題？？
    //@"http://www.chama.ne.jp/htaccess_sample/index.htm"
    //@"http://hirooka.pro/?p=3223"
    //@"http://www.kent-web.com/pwd/pwmgr/secret/"
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 4. タスクオブジェクトを作成します．
    NSURLSessionDataTask *sessionDataTask =  [session dataTaskWithURL:url];
    [sessionDataTask resume];
    // インジケータを開始します．
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}





// ---------------------------------------------------------------------
//  NSURLSessionDateDelegate
// ---------------------------------------------------------------------

/*
 The NSURLSessionDataDelegate protocol defines the methods that a delegate of an NSURLSession object can implement to handle task-level events specific to data tasks. The object should also implement the methods in the NSURLSessionTaskDelegate protocol—to handle task-level events that are common to all task types—and methods in the NSURLSessionDelegate protocol—to handle session-level events.
 */

// URLSession:dataTask:didReceiveResponse:completionHandler:
//  Tells the delegate that the data task received the initial reply (headers) from the server.
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"番号2");
    ///ここにダウンロードするデータやファイルをいれこむ
    
    
    // インジケータを停止します．
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // HTTP レスポンスかどうか確認してみます．
    //NSHTTPURLResponse:Webサーバによって返されるヘッダとステータスコードを格納
    if([response isKindOfClass:[NSHTTPURLResponse class]]){
        
        NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
        
        // ステータスコードを確認してみます．
        NSInteger statusCode = [httpURLResponse statusCode];
        NSLog(@"[statusCode] %ld", (long)statusCode);
        
        // HTTP 200 OK の場合，
        if(statusCode == 200){
            NSLog(@"番号2a");
            
            // レスポンスヘッダを確認してみます．
            NSDictionary *dicHeaders = [httpURLResponse allHeaderFields];
            NSUInteger sizeDicHeaders = [dicHeaders count];
            NSLog(@"[sizeDicHeaders] %lu", (unsigned long)sizeDicHeaders);
            
            NSArray *keys = [dicHeaders allKeys];
            for(int i = 0; i < [keys count]; i++){
                NSLog(@"key: %@, value: %@\n", [keys objectAtIndex:i], [dicHeaders objectForKey:[keys objectAtIndex:i]]);
                // 例えば，Content-Type を取得するなど．
                if([[keys objectAtIndex:i] caseInsensitiveCompare:@"CONTENT-TYPE"] == NSOrderedSame){
                    NSLog(@"[%@] %@", [keys objectAtIndex:i], [dicHeaders objectForKey:[keys objectAtIndex:i]]);
                }
            }
            
            NSURLSessionResponseDisposition disposition = NSURLSessionResponseAllow;
            completionHandler(disposition);
            
        }else{
            NSLog(@"番号2b");
            // other status code (3xx, 4xx, 5xx, ...)
        } // if(statusCode
        
    } // if([response isKindOfClass
}




// URLSession:dataTask:didBecomeDownloadTask:
// Tells the delegate that the data task was changed to a download task.
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    NSLog(@"番号3");
    //BLog();
}




// URLSession:dataTask:didReceiveData:
// Tells the delegate that the data task finished receiving all of the expected data.
// リクエストからタスクに、一度に一部分ずつデータを提供する
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"番号4");
    
    // レスポンスボディの有無を確認してみます．
    if(data){
        
        NSUInteger lengthData = [data length];
        NSLog(@"[lengthData] %lu", (unsigned long)lengthData);
        
        // 例えば，Content-Type の charset が UTF-8 の場合，
        NSString *bodyStringUTF8 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        ///_myText.text = @"aaaa";
        ///_myText.text = bodyStringUTF8;
        NSLog(@"[bodyStringUTF8 length] %lu", (unsigned long)[bodyStringUTF8 length]);
        NSLog(@"%@", bodyStringUTF8);
        NSLog(@"try = bodystringutf8");
        
    }else{
        // no data
    } // if(data)
}




// URLSession:dataTask:willCacheResponse:completionHandler:
// Asks the delegate whether the data task should store the response in the cache.
//アプリケーションが特定のレスポンスをキャッシュすべきかどうかを,リクエストごとに判定できるデリゲートメソッド
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler
{
    NSLog(@"番号5");
    //BLog();
    
    NSLog(@"[proposedResponse.storagePolicy] %lu", (unsigned long)proposedResponse.storagePolicy); // 0
    NSCachedURLResponse *cachedResponse = proposedResponse;
    completionHandler(cachedResponse);
}




// ---------------------------------------------------------------------
//  NSURLSessionTaskDelegate
// ---------------------------------------------------------------------

/*
 The NSURLSessionTaskDelegate protocol defines the methods that a delegate of an NSURLSession object should implement to handle task-level events that are common to all task types.
 
 Delegates of sessions with download tasks should also implement the methods in the NSURLSessionDownloadDelegate protocol to handle task-level events specific to download tasks.
 */

// URLSession:task:didCompleteWithError:
// Tells the delegate that the task finished transferring data.
//コードネーム：後の祭り！！
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"番号6");
    //BLog();
    
    // インジケータを停止します．
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // エラーオブジェクトがあるかどうか確認します．
    if(error){
        
        NSLog(@"%@", [error localizedDescription]);
        
        // DNS 名前解決に失敗すると呼ばれます．
        // A server with the specified hostname could not be found.
        
        // サーバからリセットを返されると呼ばれます．
        // Could not connect to the server.
        
        // タイムアウトすると呼ばれます．
        // The request timed out.
        
    }else{
        NSLog(@"done!");
    }
    
    // セッションを必要としなくなった場合，未処理のタスクをキャンセルするために invalidateAndCancel を呼ぶことでセッションを無効とします．
    [session invalidateAndCancel];
}





// ベーシック認証，ダイジェスト認証が掛かっている場合に呼ばれます．
// URLSession:task:didReceiveChallenge:completionHandler:
// Requests credentials from the delegate in response to an authentication request from the remote server.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    //このメソッド返せてない！！orz
    NSLog(@"番号7");
    //BLog();
    
    //NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengeUseCredential;
    NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:@"guest" password:@"guest" persistence:NSURLCredentialPersistenceNone];
    completionHandler(disposition, credential);
}




// URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:
// Periodically informs the delegate of the progress of sending body content to the server.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"番号8");
    //BLog();
}





// URLSession:task:needNewBodyStream:
// Tells the delegate when a task requires a new request body stream to send to the remote server.
// Note: You do not need to implement this if your code provides the request body using a file URL or an NSData object.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler
{
    NSLog(@"番号9");
    //BLog();
}




// URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:
// Tells the delegate that the remote server requested an HTTP redirect.
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler
{
    NSLog(@"番号10");
    //BLog();
}


@end
