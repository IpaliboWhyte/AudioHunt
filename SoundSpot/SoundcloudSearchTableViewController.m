//
//  SoundcloudSearchTableViewController.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 15/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "SoundcloudSearchTableViewController.h"


@interface SoundcloudSearchTableViewController ()

@end

@implementation SoundcloudSearchTableViewController

-(void)viewDidDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad {

    [super viewDidLoad];

    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self setTitle:@"Search"];
    
    [self layoutTextField];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:0.7]];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    selectedCellid = -1;
    
}

-(void)layoutTextField{
    
    self.customSearchView = [[searchView alloc] initWithFrame:CGRectMake(0, 0, 270, 50)];
    
    [self.customSearchView layoutwithBackground];
    
    self.customTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 270, 50)];
    
    [self.customTextField setFont:[UIFont fontWithName:@"bariol" size:20]];
    
    [self.customTextField setPlaceholder:@"Search"];
    
    [self.customTextField setTextColor:[UIColor whiteColor]];
    
    [self.customTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.customTextField setReturnKeyType:UIReturnKeyGo];
    
    self.customTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self.customSearchView addSubview:self.customTextField];
    
    [self.customTextField setDelegate:self];
    
    [self.customTextField becomeFirstResponder];
    
    [self.tableView setTableHeaderView:self.customSearchView];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.customTextField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *search = [self.customTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [SCRequest performMethod:SCRequestMethodGET onResource:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.soundcloud.com/tracks?client_id=546952635e22cc0182d85daceff34381&q=%@&format=json", search]] usingParameters:nil withAccount:[SCSoundCloud account] sendingProgressHandler:nil responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSError *jsonError;
        NSJSONSerialization *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {
            
            self.searchResult = (NSArray *)jsonResponse;

            [self.tableView reloadData];
            
        }
        
        else {
            
            NSLog(@"%@", error.localizedDescription);
            
        }
        
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.searchResult count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath row] == selectedCellid) {
        
        return  120;
        
    }
    
    else return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    SongItemCustomCell *songItem = [[SongItemCustomCell alloc] init];
    
    songItem = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (songItem == nil)
    {
        songItem = [[SongItemCustomCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:MyIdentifier];
        
        songItem.accessoryType = UITableViewCellAccessoryNone;
        
        NSDictionary *song = [self.searchResult objectAtIndex:[indexPath row]];
        
        NSString *songTitle = [song valueForKey:@"title"];
        
        NSString *artworkURL = [song valueForKey:@"artwork_url"];
        
        if((artworkURL != (id)[NSNull null] && artworkURL.length != 0)){
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:artworkURL]];
            
            [songItem layoutSongProperties:songTitle :[UIImage imageWithData:imageData]];
            [songItem layoutButtons];
            
        }else{
            
        }
        [songItem setTag:[indexPath row]];
        [songItem setClipsToBounds:YES];
        [songItem setDelegate:self];

    }
    
    return songItem;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (selectedCellid == [indexPath row]) {
        selectedCellid =-1;
    }else{
        int row = (int)[indexPath row];
        selectedCellid = row;
    }
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)sendToUser:(id)sender{
    // SendToViewController *friendsList = [[SendToViewController alloc] init];
   // [self.navigationController pushViewController:friendsList animated:YES];
    
    SendToViewController *friendsList = [[SendToViewController alloc] init];
    [self.navigationController pushViewController:friendsList animated:YES];
    
}

-(void)playSong:(id)sender{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
