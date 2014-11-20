//
//  ALXSong.m
//  MediaPlayerExample
//
//  Created by Alex Lamar on 11/9/14.
//  Copyright (c) 2014 Alex Lamar. All rights reserved.
//

#import "ALXSong.h"

@implementation ALXSong

-(id)initWithUrl:(NSURL*)url
{
    self = [super init];
    if (self)
    {
        
        _url = url;
        _playerItem = [[AVPlayerItem alloc] initWithURL:url];
        self.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
    }
    return self;
}

-(id)initWithUrl:(NSURL*)url andObserver:(NSObject*)observer andCallbackMethod:(SEL)callback;
{
    self = [super init];
    if (self)
    {
        _url = url;
        _playerItem = [[AVPlayerItem alloc] initWithURL:url];
        self.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
        self.observer = observer;
        self.callback = callback;
        
        //Register the observer to receive notifications from the audioPlayer
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:callback name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        
    }
    return self;
}

-(NSString *)songName
{
    NSArray *metadataList = [self.audioPlayer.currentItem.asset commonMetadata];
    
    for (AVMetadataItem *metaItem in metadataList) {
        if ([[metaItem commonKey] isEqualToString:@"title"]) {
            return [metaItem stringValue];
        }
    }
    return @"N/A";
}

-(NSString *)albumName
{
    NSArray *metadataList = [self.audioPlayer.currentItem.asset commonMetadata];
    
    for (AVMetadataItem *metaItem in metadataList) {
        if ([[metaItem commonKey] isEqualToString:@"albumName"]) {
            return [metaItem stringValue];
        }
    }
    return @"N/A";
}

-(NSString *)artist
{
    NSArray *metadataList = [self.audioPlayer.currentItem.asset commonMetadata];
    
    for (AVMetadataItem *metaItem in metadataList) {
        if ([[metaItem commonKey] isEqualToString:@"artist"]) {
            return [metaItem stringValue];
        }
    }
    return @"N/A";
}

@end
