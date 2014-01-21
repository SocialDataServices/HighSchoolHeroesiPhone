//
//  RosterViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/19/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "PlayerCell.h"
#import "Player.h"
#import "RosterViewController.h"

@interface RosterViewController ()

@end

@implementation RosterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.roster = [[NSArray alloc] init];
    
    self.school = @"Lafayette County High School";
    self.sport = @"Football";
    self.sex = @"0";
    
    NSURL *authUrl = [[NSURL alloc] initWithString:@"http://www.sodaservices.com/HighSchoolHeroes/php/getRoster.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
    [request setHTTPMethod:@"POST"];
    NSString * parameters = [NSString stringWithFormat:@"school=%@&sport=%@&sex=%@", self.school, self.sport, self.sex];
    NSData *requestData = [NSData dataWithBytes:[parameters UTF8String] length:[parameters length]];
    [request setHTTPBody:requestData];
    [request setTimeoutInterval:15.0];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
//    Player *player1 = [[Player alloc] initWithNumber:@"1" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player2 = [[Player alloc] initWithNumber:@"2" WithLastName:@"Collier" WithFirstName:@"Andrew" WithHeight:@"5-11" WithWeight:@"155" WithYear:@"Sophomore" WithPosition:@"HB"];
//    Player *player3 = [[Player alloc] initWithNumber:@"3" WithLastName:@"Ault" WithFirstName:@"William" WithHeight:@"6-2" WithWeight:@"175" WithYear:@"Junior" WithPosition:@"WR"];
//    Player *player4 = [[Player alloc] initWithNumber:@"4" WithLastName:@"Greer" WithFirstName:@"Michael" WithHeight:@"5-8" WithWeight:@"230" WithYear:@"Freshman" WithPosition:@"LB"];
//    Player *player5 = [[Player alloc] initWithNumber:@"5" WithLastName:@"Greer" WithFirstName:@"Stephen" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"DL"];
//    Player *player6 = [[Player alloc] initWithNumber:@"6" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player7 = [[Player alloc] initWithNumber:@"7" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player8 = [[Player alloc] initWithNumber:@"8" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player9 = [[Player alloc] initWithNumber:@"9" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player10 = [[Player alloc] initWithNumber:@"10" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player11 = [[Player alloc] initWithNumber:@"11" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player12 = [[Player alloc] initWithNumber:@"12" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player13 = [[Player alloc] initWithNumber:@"13" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player14 = [[Player alloc] initWithNumber:@"14" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    Player *player15 = [[Player alloc] initWithNumber:@"15" WithLastName:@"Collier" WithFirstName:@"Randy" WithHeight:@"6-0" WithWeight:@"230" WithYear:@"Senior" WithPosition:@"QB"];
//    
//    self.roster = [NSArray arrayWithObjects:player1, player2, player3, player4, player5, player6, player7, player8, player9, player10, player11, player12, player13, player14, player15, nil];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.roster.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"playerCell";
    PlayerCell *cell = [tableView
                      dequeueReusableCellWithIdentifier:CellIdentifier
                      forIndexPath:indexPath];
    
    // Configure the cell...
    Player *player = [self.roster objectAtIndex:indexPath.row];
    
    cell.numberLabel.text = player.number;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@, %@", player.lastName, player.firstName];
    cell.heightLabel.text = player.height;
    cell.weightLabel.text = player.weight;
    cell.yearLabel.text = player.year;
    cell.positionLabel.text = player.position;
    
    return cell;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"Response: %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    
    
    NSError *error = nil;
    NSArray *players = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&error];
    
//    if (error != nil) {
//        NSLog(@"Error parsing JSON.");
//    }
//    else {
//        NSLog(@"Array: %@", players);
//    }
    
    NSString *school;
    NSString *sport;
    
    NSMutableArray *playersTemp = [[NSMutableArray alloc] initWithCapacity:players.count];
    for(NSDictionary *playerInfo in players) {
        
        Player *player = [[Player alloc] init];
        player.firstName = playerInfo[@"FirstName"];
        if (playerInfo[@"Height"] == [NSNull null])
            player.height = @"N/A";
        else
            player.height = playerInfo[@"Height"];
        player.lastName = playerInfo[@"LastName"];
        player.number = playerInfo[@"Number"];
        player.position = playerInfo[@"Position"];
        if (playerInfo[@"Height"] == [NSNull null])
            player.weight = @"N/A";
        else
            player.weight = playerInfo[@"Weight"];
        player.year = playerInfo[@"Year"];
        
        school = playerInfo[@"School"];
        sport = playerInfo[@"Sport"];
        
        [playersTemp addObject:player];
    }
    self.schoolLabel.text = school;
    self.rosterLabel.text = [NSString stringWithFormat:@"%@ Roster", sport];
    self.roster = playersTemp; //set @property (nonatomic, copy) NSArray *jobsArray; in the .h
    [self.rosterTable reloadData]; //optional only if the data is loaded after the view
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"Connection: %@", connection);
}

@end