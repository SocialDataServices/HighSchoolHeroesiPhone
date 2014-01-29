//
//  SchoolViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/28/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "SchoolViewController.h"
#import "ScheduleViewController.h"
#import "AppDelegate.h"

@interface SchoolViewController () {
    NSMutableData *responseData;
}

@end

@implementation SchoolViewController

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
	// Do any additional setup after loading the view.
    
    [self.saveButton setEnabled:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.stateLabel.text = self.state;
    self.cityLabel.text = self.city;
    
    responseData = [[NSMutableData alloc] init];
    
    NSURL *authUrl = [[NSURL alloc] initWithString:@"http://www.sodaservices.com/HighSchoolHeroes/php/getSchools.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
    [request setHTTPMethod:@"POST"];
    NSString * parameters = [NSString stringWithFormat:@"state=%@&city=%@", self.state, self.city];
    NSData *requestData = [NSData dataWithBytes:[parameters UTF8String] length:[parameters length]];
    [request setHTTPBody:requestData];
    [request setTimeoutInterval:15.0];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    
    [responseData appendData:d];
    //    if (responseData != nil)
    //        NSLog(@"Data: %@", responseData);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *error = nil;
    NSArray *schools = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
//        if (error != nil)
//            NSLog(@"Error: %@", error);
//        else
//            NSLog(@"Array: %@", schools);
    
    NSMutableArray *schoolsTemp = [[NSMutableArray alloc] initWithCapacity:schools.count + 1];
    [schoolsTemp addObject:@"Select One"];
    for(NSDictionary *schoolInfo in schools) {
        
        NSString *school = schoolInfo[@"Name"];
        
        [schoolsTemp addObject:school];
    }
    self.schoolNames = schoolsTemp;
    
    [self.selectSchools reloadAllComponents];
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.schoolNames count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (row == 0)
    {
        self.schoolLabel.text = @"";
        [self.saveButton setEnabled:NO];
    }
    else
    {
        self.schoolLabel.text = [self.schoolNames objectAtIndex:row];
        [self.saveButton setEnabled:YES];
    }
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (id)view;
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self.schoolNames objectAtIndex:row];
    return label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)schedule:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    delegate.school = self.schoolLabel.text;
    delegate.sport = @"Football";
    delegate.sex = @"0";
    delegate.dataHasChangedForRoster = YES;
    delegate.dataHasChangedForSchedule = YES;
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}
@end
