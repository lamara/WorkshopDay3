//
//  ALXSong.h
//  MediaPlayerExample
//
//  Created by Alex Lamar on 11/9/14.
//  Copyright (c) 2014 Alex Lamar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ALXSong : NSObject

@property AVPlayer *audioPlayer;

@property (readonly) AVPlayerItem* playerItem;

@property NSURL *url;

@property NSObject *observer;
@property SEL callback;

-(id)initWithUrl:(NSURL*)url;

-(id)initWithUrl:(NSURL*)url andObserver:(NSObject*)observer andCallbackMethod:(SEL)callback;

-(NSString *)songName;
-(NSString *)artist;
-(NSString *)albumName;

@end
