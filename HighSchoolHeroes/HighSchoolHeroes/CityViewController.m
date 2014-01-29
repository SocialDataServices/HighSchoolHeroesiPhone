//
//  CityViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/28/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "CityViewController.h"
#import "SchoolViewController.h"

@interface CityViewController () {
    NSMutableData *responseData;
}

@end

@implementation CityViewController

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
    
    responseData = [[NSMutableData alloc] init];
    
    NSURL *authUrl = [[NSURL alloc] initWithString:@"http://www.sodaservices.com/HighSchoolHeroes/php/getCities.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
    [request setHTTPMethod:@"POST"];
    NSString * parameters = [NSString stringWithFormat:@"state=%@", self.state];
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
    NSArray *cities = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    //    if (error != nil)
    //        NSLog(@"Error: %@", error);
    //    else
    //        NSLog(@"Array: %@", players);
    
    NSMutableArray *citiesTemp = [[NSMutableArray alloc] initWithCapacity:cities.count + 1];
    [citiesTemp addObject:@"Select One"];
    for(NSDictionary *cityInfo in cities) {
        
        NSString *city = cityInfo[@"City"];
        
        [citiesTemp addObject:city];
    }
    self.cityNames = citiesTemp;
    
    [self.selectCity reloadAllComponents];
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.cityNames count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (row == 0)
    {
        self.cityLabel.text = @"";
        [self.saveButton setEnabled:NO];
    }
    else
    {
        self.cityLabel.text = [self.cityNames objectAtIndex:row];
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
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self.cityNames objectAtIndex:row];
    return label;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSchool"]) {
        SchoolViewController *schoolView = segue.destinationViewController;
        schoolView.state = self.stateLabel.text;
        schoolView.city = self.cityLabel.text;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
