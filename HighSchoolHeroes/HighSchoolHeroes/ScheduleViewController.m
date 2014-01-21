//
//  SecondViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/19/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "Game.h"
#import "GameCell.h"
#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

static const NSString *theURL = @"http://www.sodaservices.com/HighSchoolHeroes/php/getSchedule.php";

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
    
    self.schedule = [[NSArray alloc] init];
    
    self.school = @"Oxford High School";
    self.sport = @"Football";
    self.sex = @"0";
    
    NSURL *authUrl = [[NSURL alloc] initWithString:@"http://www.sodaservices.com/HighSchoolHeroes/php/getSchedule.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
    [request setHTTPMethod:@"POST"];
    NSString * parameters = [NSString stringWithFormat:@"school=%@&sport=%@&sex=%@", self.school, self.sport, self.sex];
    NSData *requestData = [NSData dataWithBytes:[parameters UTF8String] length:[parameters length]];
    [request setHTTPBody:requestData];
    [request setTimeoutInterval:15.0];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
	
//    Game *game1 = [[Game alloc] initOnDate:@"2013-08-15" AgainstOpponent:@"Tupelo" WithScore:@"34-85" AtLocation:@"Home"];
//    Game *game2 = [[Game alloc] initOnDate:@"2013-08-22" AgainstOpponent:@"Shannon" WithScore:@"67-23" AtLocation:@"Home"];
//    Game *game3 = [[Game alloc] initOnDate:@"2013-08-29" AgainstOpponent:@"Lafayette" WithScore:@"3-8" AtLocation:@"Away"];
//    Game *game4 = [[Game alloc] initOnDate:@"2013-09-03" AgainstOpponent:@"Corinth" WithScore:@"34-67" AtLocation:@"Away"];
//    Game *game5 = [[Game alloc] initOnDate:@"2013-09-11" AgainstOpponent:@"Saltillo" WithScore:@"34-85" AtLocation:@"Home"];
//    Game *game6 = [[Game alloc] initOnDate:@"2013-09-19" AgainstOpponent:@"Baldwin" WithScore:@"34-85" AtLocation:@"Away"];
//    Game *game7 = [[Game alloc] initOnDate:@"2013-09-25" AgainstOpponent:@"Fulton" WithScore:@"34-85" AtLocation:@"Home"];
//    Game *game8 = [[Game alloc] initOnDate:@"2013-09-31" AgainstOpponent:@"Tremont" WithScore:@"34-85" AtLocation:@"Home"];
//    Game *game9 = [[Game alloc] initOnDate:@"2013-10-15" AgainstOpponent:@"West Point" WithScore:@"34-85" AtLocation:@"Away"];
//    Game *game10 = [[Game alloc] initOnDate:@"2013-11-01" AgainstOpponent:@"Clarksdale" WithScore:@"34-85" AtLocation:@"Home"];
//    Game *game11 = [[Game alloc] initOnDate:@"2013-11-16" AgainstOpponent:@"Clinton" WithScore:@"6-2" AtLocation:@"Away"];
//    self.schedule = [NSArray arrayWithObjects:game1, game2, game3, game4, game5, game6, game7, game8, game9, game10, game11, nil];
    self.schoolLabel.text = @"Oxford High School";
    self.scheduleLabel.text = @"Football Schedule";
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
    return self.schedule.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gameCell";
    GameCell *cell = [tableView
                      dequeueReusableCellWithIdentifier:CellIdentifier
                      forIndexPath:indexPath];
    
    // Configure the cell...
    Game *game = [self.schedule objectAtIndex:indexPath.row];
    
    NSString *gameOpponent;
    
    if ([game.location isEqualToString:@"Away"])
    {
        gameOpponent = [NSString stringWithFormat:@"@ %@", game.opponent];
    }
    else
    {
        gameOpponent = game.opponent;
    }
    
    cell.dateLabel.text = game.date;
    cell.opponentLabel.text = gameOpponent;
    cell.scoreLabel.text = game.score;
    
    return cell;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"Response: %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    
    
    NSError *error = nil;
    NSArray *games = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&error];
//    
//    if (error != nil) {
//        NSLog(@"Error parsing JSON.");
//    }
//    else {
//        NSLog(@"Array: %@", jsonArray);
//    }
    
    NSString *school;
    NSString *sport;
    
    NSMutableArray *gamesTemp = [[NSMutableArray alloc] initWithCapacity:games.count];
    for(NSDictionary *gameInfo in games) {
        
        Game *game = [[Game alloc] init];
        game.date = gameInfo[@"Date"];
        game.location = gameInfo[@"Location"];
        game.opponent = gameInfo[@"Opponent"];
        game.score = gameInfo[@"Score"];
        
        school = gameInfo[@"School"];
        sport = gameInfo[@"Sport"];
        
        [gamesTemp addObject:game];
    }
    
    self.schoolLabel.text = school;
    self.scheduleLabel.text = [NSString stringWithFormat:@"%@ Schedule", sport];
    self.schedule = gamesTemp; //set @property (nonatomic, copy) NSArray *jobsArray; in the .h
    [self.scheduleTable reloadData]; //optional only if the data is loaded after the view
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"Connection: %@", connection);
}

@end
