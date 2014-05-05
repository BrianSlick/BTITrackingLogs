BTITrackingLogs
===========

by **Brian Slick**

Personal Stuff
- Visit my blog at [http://clingingtoideas.blogspot.com](http://clingingtoideas.blogspot.com)
- Follow [@BrianSlick on Twitter](http://twitter.com/BrianSlick)

Business Stuff
- Visit my company web site at [http://briterideas.com](http://briterideas.com)
- Follow [@BriTerIdeas on Twitter](http://twitter.com/BriTerIdeas)

(This README has been adapted from [MGWordCounter](https://github.com/mattgemmell/MGWordCounter) by Matt Gemmell)


## What is BTITrackingLogs?

**A project for making an Automator action that creates entry/exit logs in methods**

Given this input:

     {
         // This is a nice method
         
         if (somethingBadHappened)
         {
              return nil;
         }
         
         // At last, the real work can begin
         
         return @YES;
     }
     
Get this output:

     {
         NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

         // This is a nice method
         
         if (somethingBadHappened)
         {
              NSLog(@"<<< Leaving  <%p> %s >>> EARLY - <reason not specified>", self, __PRETTY_FUNCTION__);
              return nil;
         }
         
         // At last, the real work can begin
         

         NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
         return @YES;
     }

When this code is run, the specific console output will look something like this:

     >>> Entering <0x833a1d0> -[SamplePlainViewController initWithNibName:bundle:] <<<
     <<< Leaving  <0x833a1d0> -[SamplePlainViewController initWithNibName:bundle:] >>>

An alternate version is included that uses "BTITrackingLog" instead of "NSLog", so that these logs can be disabled independent of other logs.  The project builds two different Automator actions, depending on desired output.  If you have your own log macro such as DLog, the code can be easily modified with whatever prefix you need. 

Also included is a testing app, with a few unit tests, since testing Automator actions in Automator is really annoying.


## Usage

- Highlight some code beginning with { and ending with }. This is most easily accomplished by double-clicking either brace. Ideally this should be the first and last brace of a method. The output probably won't make sense otherwise.
- Select the appropriate service from the Xcode -> Services menu
- There is no step 3.


## Installation

- Acquire this project by the usual means
- Build the Action.  If a Mac app launches, you built the wrong thing
- Reveal the product in the Finder
- The .action file needs to be placed in ~/Library/Automator
- Launch Automator, and create a new Workflow using the Service template
- The settings at the top should be "text", "any application", and the "Output replaces selected text" checkbox should be ON
- Locate the custom action in the list. It might be in the "Recently Added" smart group.  Drag it into the workflow
- Save. Give it a name you'll recognize, such as "Add Tracking NSLogs"
- This action will be available in the Services menu any time you have a text selection

- Misc tip: During development I frequently found that Automator and/or the Services menu would cache previous states of the action.  Quitting Automator and sometimes Xcode, and sometimes creating an entirely new workflow, would help to see the newest code. FYI in case you modify the code and want to try it out.


## Discussion of output


- The original text selection should be unharmed if this action is not able to insert the logs.
- The action will put an "entering" log at the beginning, and a "leaving" log at the end. If the method returns a value, the leaving log will be placed before the return line.
- If the method has multiple exit points, additional logs will be placed before those return lines, with placeholder text meant to indicate a reason for leaving there. This helps to determine which route the flow of execution took through your code.
- The action should ignore any return lines that are inside of blocks.
- It will not create duplicate logs if logs are already there.
- I have an older output format (see comments in code) that I've been using for a while. If found, those logs will be converted to the new format.
- Running the BTITrackingLog version will convert existing NSLogs.  Running the NSLog version will convert existing BTITrackingLogs.


## Why did you create this?

It may not be sexy or l33t, but I use these logs constantly. Very handy to retrace the steps the program took. Very nice to add to inherited code to find out what it is doing. This is especially useful if sharing the code with someone, say a client, who is capable of running Xcode but is not otherwise a developer. Problem? Give me the console output please. Thanks. Now I can figure out what the problem is.

I've recently switched to the BTITrackingLog version because this technique does indeed generate tons and tons of console output, and you don't always need that. Turn the trackers on when you need them, turn them off when you don't. Other NSLogs are otherwise unharmed.  See [BTIConcepts](https://github.com/BriTerIdeas/BTIConcepts) for a macro that disables the logs.


## Getting the code

BTITrackingLogs can be cloned from its git repository on github. You can find the repository here: [http://github.com/BriTerIdeas/BTITrackingLogs](http://github.com/BriTerIdeas/BTITrackingLogs)


## Requirements and supported OS versions

- Tested on Mavericks.  Not sure how far back it will work.  Previous version worked fine on Mountain Lion.
- Current build target is Mavericks, which uses ARC.  If building for anything older, you have to use garbage collection.


## License

BTITrackingLogs is distributed freely.  Use it or modify it in any way you see fit.


## Saying Thank You

If you find this code useful, then any of the following would really make me happy:
- I have an app: [SlickShopper](https://itunes.apple.com/us/app/slickshopper-2/id434077651?mt=8). Buy a copy. Tell friends and family about how great it is so they'll buy copies too.  Seriously, I'm lucky to sell one copy a week.  You could literally make my month!
- I do contract development: [BriTer Ideas LLC](http://www.briterideas.com/services.shtml). Hire me. Or if you know of anyone else looking for a developer, I'd appreciate a referral.
- A shout out on Twitter never hurt anybody.
- I will graciously accept a [PayPal](http://bit.ly/AW4Cc) donation.


## Bugs and feature requests

There is very little support offered with this code.  I am always interested in better ways of doing things, so I'll be happy to consider feature requests.  (Note, "consider" doesn't mean I will do anything).  I don't speak Git/GitHub all that well, so I can't make any promises about pull requests.

To discuss this project, please post in [this thread](http://iphonedevsdk.com/forum/iphone-sdk-development/52981-free-utility-for-adding-logs.html).