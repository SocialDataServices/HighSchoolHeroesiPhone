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
#import "School.h"

@interface SchoolViewController () {
    NSMutableData *responseData;
    School *school;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

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
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [self.saveButton setEnabled:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.stateLabel.text = self.state;
    self.cityLabel.text = self.city;
    
    responseData = [[NSMutableData alloc] init];
    school = [[School alloc] init];
    
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
        
        school = [[School alloc] init];
        school.schoolId = schoolInfo[@"SchoolId"];
        school.name = schoolInfo[@"Name"];
        school.city = schoolInfo[@"City"];
        school.state = schoolInfo[@"State"];
        school.zip = schoolInfo[@"ZIP"];
        school.size = schoolInfo[@"Size"];
        
        
        [schoolsTemp addObject:school];
    }
    self.schools = schoolsTemp;
    
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
    return [self.schools count];
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
        school = [self.schools objectAtIndex:row];
        self.schoolLabel.text = school.name;
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
    if (!label)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    if (row == 0)
    {
        label.text = [self.schools objectAtIndex:row];
    }
    else
    {
        school = [self.schools objectAtIndex:row];
        label.text = school.name;
    }
    
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
    
    BOOL isThere = NO;
    NSArray *array = [delegate getMySchools];
    for (School *object in array)
    {
        if ([object.schoolId isEqualToString:school.schoolId])
        {
            isThere = YES;
            break;
        }
    }
    
    if (!isThere)
    {
        School *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"School"
                                                         inManagedObjectContext:self.managedObjectContext];
        
        newEntry.schoolId = school.schoolId;
        newEntry.name = school.name;
        newEntry.city = school.city;
        newEntry.state = school.state;
        newEntry.zip = school.zip;
        newEntry.size = school.size;
        
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
 
    }
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}
@end
