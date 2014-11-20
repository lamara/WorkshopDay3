//
//  ALXSongListViewController.m
//  MediaPlayerExample
//
//  Created by Alex Lamar on 11/9/14.
//  Copyright (c) 2014 Alex Lamar. All rights reserved.
//

#import "ALXSongListViewController.h"
#import "AudioPlayerViewController.h"

@implementation ALXSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return a cell to be used for the row at the given index
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Called whenever the user clicks on a table cell
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Called whenever the view is about to segue to another view
}

@end