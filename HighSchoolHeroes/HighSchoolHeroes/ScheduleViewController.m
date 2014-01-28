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

@interface ScheduleViewController () {
    
    UIActivityIndicatorView *indicator;
    
}

@end

@implementation ScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:@"yes" forKey:@"firstLaunch"];
        [standardUserDefaults synchronize];
    }
    
//    self.navigationController.navigationBar.hidden = YES;
    
    self.schedule = [[NSArray alloc] init];
    
    self.school = @"Oxford High School";
    self.sport = @"Football";
    self.sex = @"0";
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
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
        NSString *date = gameInfo[@"Date"];
        NSArray *dateArray = [date componentsSeparatedByString:@"-"];
        game.date = [NSString stringWithFormat:@"%@/%@", [dateArray objectAtIndex:1], [dateArray objectAtIndex:2]];
        game.location = gameInfo[@"Location"];
        game.opponent = gameInfo[@"Opponent"];
        game.score = gameInfo[@"Score"];
        
        school = gameInfo[@"School"];
        sport = gameInfo[@"Sport"];
        
        [gamesTemp addObject:game];
    }
    
    self.schoolLabel.text = school;
    self.scheduleLabel.text = [NSString stringWithFormat:@"%@", sport];
    self.schedule = gamesTemp;
    [indicator stopAnimating];
    [self.scheduleTable reloadData]; //optional only if the data is loaded after the view
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 21)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,40,21)];
    dateLabel.text = @"Date";
    dateLabel.textAlignment = NSTextAlignmentLeft;
    UILabel *opponentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,0,184,21)];
    opponentLabel.text = @"Opponent";
    opponentLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(244,0,54,21)];
    scoreLabel.text = @"Score";
    scoreLabel.textAlignment = NSTextAlignmentRight;
    
    [view addSubview:dateLabel];
    [view addSubview:opponentLabel];
    [view addSubview:scoreLabel];
    
    return view;
}

@end
