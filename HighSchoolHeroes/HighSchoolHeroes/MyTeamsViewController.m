//
//  MyTeamsViewController.m
//  HighSchoolHeroes
//
//  Created by Randy Collier on 1/28/14.
//  Copyright (c) 2014 Randy Collier. All rights reserved.
//

#import "MyTeamsViewController.h"
#import "CityViewController.h"

@interface MyTeamsViewController () {
    NSMutableData *responseData;
}

@end

@implementation MyTeamsViewController

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
    
    [self.saveButton setEnabled:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    responseData = [[NSMutableData alloc] init];
    
    NSURL *authUrl = [[NSURL alloc] initWithString:@"http://www.sodaservices.com/HighSchoolHeroes/php/getStates.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
    [request setHTTPMethod:@"POST"];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSArray *states = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    //    if (error != nil)
    //        NSLog(@"Error: %@", error);
    //    else
    //        NSLog(@"Array: %@", players);
    
    NSMutableArray *statesTemp = [[NSMutableArray alloc] initWithCapacity:states.count + 1];
    [statesTemp addObject:@"Select One"];
    for(NSDictionary *stateInfo in states) {
        
        NSString *state = stateInfo[@"State"];
        
        [statesTemp addObject:state];
    }
    self.stateNames = statesTemp;
    
    [self.selectState reloadAllComponents];
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.stateNames count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (row == 0)
    {
        self.stateLabel.text = @"";
        [self.saveButton setEnabled:NO];
    }
    else
    {
        self.stateLabel.text = [self.stateNames objectAtIndex:row];
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
    label.text = [self.stateNames objectAtIndex:row];
    return label;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toCity"]) {
        CityViewController *cityView = segue.destinationViewController;
        cityView.state = self.stateLabel.text;
    }
}

@end
